-- ==================================================================== -- HR AI EVALUATION SYSTEM - DATABASE SCHEMA -- MySQL 8.0+ Compatible -- ====================================================================

-- Drop existing tables if they exist (for clean setup) DROP TABLE IF EXISTS rankings; DROP TABLE IF EXISTS evaluations; DROP TABLE IF EXISTS candidate_skills; DROP TABLE IF EXISTS skills; DROP TABLE IF EXISTS candidates;

-- ==================================================================== -- TABLE: candidates -- Stores candidate profile information -- ==================================================================== CREATE TABLE candidates ( candidate_id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(100) NOT NULL, last_name VARCHAR(100) NOT NULL, full_name VARCHAR(200) GENERATED ALWAYS AS (CONCAT(first_name, ' ', last_name)) STORED, email VARCHAR(255) UNIQUE NOT NULL, phone VARCHAR(20), years_of_experience INT NOT NULL CHECK (years_of_experience >= 0), current_position VARCHAR(200), education_level ENUM('High School', 'Associate', 'Bachelor', 'Master', 'PhD') DEFAULT 'Bachelor', location VARCHAR(200), resume_url VARCHAR(500), linkedin_url VARCHAR(500), status ENUM('Applied', 'Under Review', 'Evaluated', 'Shortlisted', 'Rejected', 'Hired') DEFAULT 'Applied', application_date DATETIME DEFAULT CURRENT_TIMESTAMP, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

-- Indexes for performance
INDEX idx_status (status),
INDEX idx_experience (years_of_experience),
INDEX idx_application_date (application_date),
INDEX idx_full_name (full_name)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==================================================================== -- TABLE: skills -- Master list of skills -- ==================================================================== CREATE TABLE skills ( skill_id INT AUTO_INCREMENT PRIMARY KEY, skill_name VARCHAR(100) UNIQUE NOT NULL, category ENUM('Leadership', 'Technical', 'Communication', 'Management', 'Analytical', 'Creative') DEFAULT 'Technical', description TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

INDEX idx_category (category),
INDEX idx_skill_name (skill_name)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==================================================================== -- TABLE: candidate_skills -- Many-to-many relationship between candidates and skills -- ==================================================================== CREATE TABLE candidate_skills ( candidate_skill_id INT AUTO_INCREMENT PRIMARY KEY, candidate_id INT NOT NULL, skill_id INT NOT NULL, proficiency_level ENUM('Beginner', 'Intermediate', 'Advanced', 'Expert') DEFAULT 'Intermediate', years_experience INT DEFAULT 0, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id) ON DELETE CASCADE,
FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE,
UNIQUE KEY unique_candidate_skill (candidate_id, skill_id),
INDEX idx_candidate (candidate_id),
INDEX idx_skill (skill_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==================================================================== -- TABLE: evaluations -- AI evaluation scores for each candidate -- ==================================================================== CREATE TABLE evaluations ( evaluation_id INT AUTO_INCREMENT PRIMARY KEY, candidate_id INT NOT NULL,

-- AI Evaluation Metrics (0-100 scale)
crisis_management_score DECIMAL(5,2) NOT NULL CHECK (crisis_management_score BETWEEN 0 AND 100),
sustainability_score DECIMAL(5,2) NOT NULL CHECK (sustainability_score BETWEEN 0 AND 100),
team_motivation_score DECIMAL(5,2) NOT NULL CHECK (team_motivation_score BETWEEN 0 AND 100),

-- Calculated overall score
overall_score DECIMAL(5,2) GENERATED ALWAYS AS (
    (crisis_management_score + sustainability_score + team_motivation_score) / 3
) STORED,

-- AI Analysis Details
crisis_management_analysis TEXT,
sustainability_analysis TEXT,
team_motivation_analysis TEXT,
overall_summary TEXT,

-- AI Model Information
ai_model_version VARCHAR(50) DEFAULT 'GPT-4',
evaluation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
evaluated_by VARCHAR(100) DEFAULT 'AI System',

-- Metadata
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id) ON DELETE CASCADE,
INDEX idx_candidate (candidate_id),
INDEX idx_overall_score (overall_score DESC),
INDEX idx_evaluation_date (evaluation_date)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==================================================================== -- TABLE: rankings -- Auto-updated candidate rankings based on evaluations -- ==================================================================== CREATE TABLE rankings ( ranking_id INT AUTO_INCREMENT PRIMARY KEY, candidate_id INT NOT NULL, evaluation_id INT NOT NULL,

-- Ranking information
overall_rank INT NOT NULL,
crisis_rank INT NOT NULL,
sustainability_rank INT NOT NULL,
motivation_rank INT NOT NULL,

-- Scores (denormalized for performance)
overall_score DECIMAL(5,2) NOT NULL,
crisis_score DECIMAL(5,2) NOT NULL,
sustainability_score DECIMAL(5,2) NOT NULL,
motivation_score DECIMAL(5,2) NOT NULL,

-- Ranking metadata
ranking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
is_current BOOLEAN DEFAULT TRUE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id) ON DELETE CASCADE,
FOREIGN KEY (evaluation_id) REFERENCES evaluations(evaluation_id) ON DELETE CASCADE,
INDEX idx_overall_rank (overall_rank),
INDEX idx_current (is_current),
INDEX idx_candidate (candidate_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==================================================================== -- TRIGGER: Auto-update rankings after evaluation insert -- ==================================================================== DELIMITER //

CREATE TRIGGER after_evaluation_insert AFTER INSERT ON evaluations FOR EACH ROW BEGIN -- Mark old rankings as not current UPDATE rankings SET is_current = FALSE WHERE candidate_id = NEW.candidate_id;

-- Calculate overall rank
SET @overall_rank = (
    SELECT COUNT(*) + 1
    FROM evaluations
    WHERE overall_score > NEW.overall_score
);

-- Calculate crisis management rank
SET @crisis_rank = (
    SELECT COUNT(*) + 1
    FROM evaluations
    WHERE crisis_management_score > NEW.crisis_management_score
);

-- Calculate sustainability rank
SET @sustainability_rank = (
    SELECT COUNT(*) + 1
    FROM evaluations
    WHERE sustainability_score > NEW.sustainability_score
);

-- Calculate team motivation rank
SET @motivation_rank = (
    SELECT COUNT(*) + 1
    FROM evaluations
    WHERE team_motivation_score > NEW.team_motivation_score
);

-- Insert new ranking
INSERT INTO rankings (
    candidate_id,
    evaluation_id,
    overall_rank,
    crisis_rank,
    sustainability_rank,
    motivation_rank,
    overall_score,
    crisis_score,
    sustainability_score,
    motivation_score,
    is_current
) VALUES (
    NEW.candidate_id,
    NEW.evaluation_id,
    @overall_rank,
    @crisis_rank,
    @sustainability_rank,
    @motivation_rank,
    NEW.overall_score,
    NEW.crisis_management_score,
    NEW.sustainability_score,
    NEW.team_motivation_score,
    TRUE
);

END//

DELIMITER ;

-- ==================================================================== -- TRIGGER: Auto-update rankings after evaluation update -- ==================================================================== DELIMITER //

CREATE TRIGGER after_evaluation_update AFTER UPDATE ON evaluations FOR EACH ROW BEGIN -- Mark old rankings as not current UPDATE rankings SET is_current = FALSE WHERE evaluation_id = NEW.evaluation_id;

-- Calculate overall rank
SET @overall_rank = (
    SELECT COUNT(*) + 1
    FROM evaluations
    WHERE overall_score > NEW.overall_score
);

-- Calculate crisis management rank
SET @crisis_rank = (
    SELECT COUNT(*) + 1
    FROM evaluations
    WHERE crisis_management_score > NEW.crisis_management_score
);

-- Calculate sustainability rank
SET @sustainability_rank = (
    SELECT COUNT(*) + 1
    FROM evaluations
    WHERE sustainability_score > NEW.sustainability_score
);

-- Calculate team motivation rank
SET @motivation_rank = (
    SELECT COUNT(*) + 1
    FROM evaluations
    WHERE team_motivation_score > NEW.team_motivation_score
);

-- Insert updated ranking
INSERT INTO rankings (
    candidate_id,
    evaluation_id,
    overall_rank,
    crisis_rank,
    sustainability_rank,
    motivation_rank,
    overall_score,
    crisis_score,
    sustainability_score,
    motivation_score,
    is_current
) VALUES (
    NEW.candidate_id,
    NEW.evaluation_id,
    @overall_rank,
    @crisis_rank,
    @sustainability_rank,
    @motivation_rank,
    NEW.overall_score,
    NEW.crisis_management_score,
    NEW.sustainability_score,
    NEW.team_motivation_score,
    TRUE
);

END//

DELIMITER ;

-- ==================================================================== -- USEFUL VIEWS -- ====================================================================

-- View: Current top performers CREATE VIEW v_top_performers AS SELECT c.candidate_id, c.full_name, c.email, c.years_of_experience, c.current_position, r.overall_rank, r.overall_score, r.crisis_score, r.sustainability_score, r.motivation_score FROM candidates c JOIN rankings r ON c.candidate_id = r.candidate_id WHERE r.is_current = TRUE ORDER BY r.overall_rank ASC LIMIT 10;

-- View: Candidate skills summary CREATE VIEW v_candidate_skills_summary AS SELECT c.candidate_id, c.full_name, GROUP_CONCAT(s.skill_name ORDER BY s.skill_name SEPARATOR ', ') AS skills, COUNT(cs.skill_id) AS skill_count FROM candidates c LEFT JOIN candidate_skills cs ON c.candidate_id = cs.candidate_id LEFT JOIN skills s ON cs.skill_id = s.skill_id GROUP BY c.candidate_id, c.full_name;

-- View: Complete candidate profile with rankings CREATE VIEW v_candidate_profiles AS SELECT c.candidate_id, c.full_name, c.email, c.phone, c.years_of_experience, c.current_position, c.status, e.overall_score, e.crisis_management_score, e.sustainability_score, e.team_motivation_score, r.overall_rank, r.crisis_rank, r.sustainability_rank, r.motivation_rank, GROUP_CONCAT(s.skill_name ORDER BY s.skill_name SEPARATOR ', ') AS skills FROM candidates c LEFT JOIN evaluations e ON c.candidate_id = e.candidate_id LEFT JOIN rankings r ON e.evaluation_id = r.evaluation_id AND r.is_current = TRUE LEFT JOIN candidate_skills cs ON c.candidate_id = cs.candidate_id LEFT JOIN skills s ON cs.skill_id = s.skill_id GROUP BY c.candidate_id, c.full_name, c.email, c.phone, c.years_of_experience, c.current_position, c.status, e.overall_score, e.crisis_management_score, e.sustainability_score, e.team_motivation_score, r.overall_rank, r.crisis_rank, r.sustainability_rank, r.motivation_rank;

-- ==================================================================== -- INDEXES FOR OPTIMIZATION -- ====================================================================

-- Additional composite indexes for common queries CREATE INDEX idx_candidate_status_score ON candidates(status, candidate_id); CREATE INDEX idx_evaluation_scores ON evaluations(overall_score DESC, crisis_management_score DESC);

-- ==================================================================== -- END OF SCHEMA -- ====================================================================
