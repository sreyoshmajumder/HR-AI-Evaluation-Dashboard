-- ====================================================================
-- HR AI EVALUATION SYSTEM - DATABASE SCHEMA
-- MySQL 8.0+ Compatible
-- ====================================================================

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS rankings;
DROP TABLE IF EXISTS evaluations;
DROP TABLE IF EXISTS candidate_skills;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS candidates;

-- ====================================================================
-- TABLE: candidates
-- Stores candidate profile information
-- ====================================================================
CREATE TABLE candidates (
    candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    full_name VARCHAR(200) GENERATED ALWAYS AS (CONCAT(first_name, ' ', last_name)) STORED,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    years_of_experience INT NOT NULL CHECK (years_of_experience >= 0),
    current_position VARCHAR(200),
    education_level ENUM('High School', 'Associate', 'Bachelor', 'Master', 'PhD') DEFAULT 'Bachelor',
    location VARCHAR(200),
    resume_url VARCHAR(500),
    linkedin_url VARCHAR(500),
    status ENUM('Applied', 'Under Review', 'Evaluated', 'Shortlisted', 'Rejected', 'Hired') DEFAULT 'Applied',
    application_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indexes for performance
    INDEX idx_status (status),
    INDEX idx_experience (years_of_experience),
    INDEX idx_application_date (application_date),
    INDEX idx_full_name (full_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================================================
-- TABLE: skills
-- Master list of skills
-- ====================================================================
CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) UNIQUE NOT NULL,
    category ENUM('Leadership', 'Technical', 'Communication', 'Management', 'Analytical', 'Creative') DEFAULT 'Technical',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_category (category),
    INDEX idx_skill_name (skill_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================================================
-- TABLE: candidate_skills
-- Many-to-many relationship between candidates and skills
-- ====================================================================
CREATE TABLE candidate_skills (
    candidate_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level ENUM('Beginner', 'Intermediate', 'Advanced', 'Expert') DEFAULT 'Intermediate',
    years_experience INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE,
    UNIQUE KEY unique_candidate_skill (candidate_id, skill_id),
    INDEX idx_candidate (candidate_id),
    INDEX idx_skill (skill_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================================================
-- TABLE: evaluations
-- AI evaluation scores for each candidate
-- ====================================================================
CREATE TABLE evaluations (
    evaluation_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    
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

-- ====================================================================
-- TABLE: rankings
-- Auto-updated candidate rankings based on evaluations
-- ====================================================================
CREATE TABLE rankings (
    ranking_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    evaluation_id INT NOT NULL,
    
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

-- ====================================================================
-- TRIGGER: Auto-update rankings after evaluation insert
-- ====================================================================
DELIMITER //

CREATE TRIGGER after_evaluation_insert
AFTER INSERT ON evaluations
FOR EACH ROW
BEGIN
    -- Mark old rankings as not current
    UPDATE rankings SET is_current = FALSE WHERE candidate_id = NEW.candidate_id;
    
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

-- ====================================================================
-- TRIGGER: Auto-update rankings after evaluation update
-- ====================================================================
DELIMITER //

CREATE TRIGGER after_evaluation_update
AFTER UPDATE ON evaluations
FOR EACH ROW
BEGIN
    -- Mark old rankings as not current
    UPDATE rankings SET is_current = FALSE WHERE evaluation_id = NEW.evaluation_id;
    
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

-- ====================================================================
-- USEFUL VIEWS
-- ====================================================================

-- View: Current top performers
CREATE VIEW v_top_performers AS
SELECT 
    c.candidate_id,
    c.full_name,
    c.email,
    c.years_of_experience,
    c.current_position,
    r.overall_rank,
    r.overall_score,
    r.crisis_score,
    r.sustainability_score,
    r.motivation_score
FROM candidates c
JOIN rankings r ON c.candidate_id = r.candidate_id
WHERE r.is_current = TRUE
ORDER BY r.overall_rank ASC
LIMIT 10;

-- View: Candidate skills summary
CREATE VIEW v_candidate_skills_summary AS
SELECT 
    c.candidate_id,
    c.full_name,
    GROUP_CONCAT(s.skill_name ORDER BY s.skill_name SEPARATOR ', ') AS skills,
    COUNT(cs.skill_id) AS skill_count
FROM candidates c
LEFT JOIN candidate_skills cs ON c.candidate_id = cs.candidate_id
LEFT JOIN skills s ON cs.skill_id = s.skill_id
GROUP BY c.candidate_id, c.full_name;

-- View: Complete candidate profile with rankings
CREATE VIEW v_candidate_profiles AS
SELECT 
    c.candidate_id,
    c.full_name,
    c.email,
    c.phone,
    c.years_of_experience,
    c.current_position,
    c.status,
    e.overall_score,
    e.crisis_management_score,
    e.sustainability_score,
    e.team_motivation_score,
    r.overall_rank,
    r.crisis_rank,
    r.sustainability_rank,
    r.motivation_rank,
    GROUP_CONCAT(s.skill_name ORDER BY s.skill_name SEPARATOR ', ') AS skills
FROM candidates c
LEFT JOIN evaluations e ON c.candidate_id = e.candidate_id
LEFT JOIN rankings r ON e.evaluation_id = r.evaluation_id AND r.is_current = TRUE
LEFT JOIN candidate_skills cs ON c.candidate_id = cs.candidate_id
LEFT JOIN skills s ON cs.skill_id = s.skill_id
GROUP BY 
    c.candidate_id, c.full_name, c.email, c.phone, c.years_of_experience,
    c.current_position, c.status, e.overall_score, e.crisis_management_score,
    e.sustainability_score, e.team_motivation_score, r.overall_rank,
    r.crisis_rank, r.sustainability_rank, r.motivation_rank;

-- ====================================================================
-- INDEXES FOR OPTIMIZATION
-- ====================================================================

-- Additional composite indexes for common queries
CREATE INDEX idx_candidate_status_score ON candidates(status, candidate_id);
CREATE INDEX idx_evaluation_scores ON evaluations(overall_score DESC, crisis_management_score DESC);

-- ====================================================================
-- END OF SCHEMA
-- ====================================================================



-- ====================================================================
-- HR AI EVALUATION SYSTEM - SAMPLE DATA
-- 40 Realistic Candidates with Skills and AI Evaluations
-- ====================================================================

USE hr_ai_evaluation;

-- ====================================================================
-- INSERT SKILLS (Master List)
-- ====================================================================

INSERT INTO skills (skill_name, category) VALUES
('Leadership', 'Leadership'),
('Communication', 'Communication'),
('Problem Solving', 'Analytical'),
('Strategic Thinking', 'Management'),
('Team Building', 'Leadership'),
('Project Management', 'Management'),
('Data Analysis', 'Technical'),
('Innovation', 'Creative'),
('Adaptability', 'Leadership'),
('Conflict Resolution', 'Communication'),
('Decision Making', 'Management'),
('Mentoring', 'Leadership'),
('Negotiation', 'Communication'),
('Time Management', 'Management'),
('Creativity', 'Creative');

-- ====================================================================
-- INSERT 40 CANDIDATES
-- ====================================================================

INSERT INTO candidates (first_name, last_name, email, phone, years_of_experience, current_position, education_level, location, status) VALUES
('James', 'Smith', 'james.smith@email.com', '+1-555-0101', 12, 'Senior Product Manager', 'Master', 'New York, NY', 'Evaluated'),
('Emma', 'Johnson', 'emma.johnson@email.com', '+1-555-0102', 8, 'Operations Director', 'Bachelor', 'San Francisco, CA', 'Evaluated'),
('Michael', 'Williams', 'michael.williams@email.com', '+1-555-0103', 5, 'Marketing Manager', 'Master', 'Chicago, IL', 'Evaluated'),
('Sophia', 'Brown', 'sophia.brown@email.com', '+1-555-0104', 14, 'VP of Engineering', 'PhD', 'Austin, TX', 'Evaluated'),
('William', 'Jones', 'william.jones@email.com', '+1-555-0105', 3, 'Business Analyst', 'Bachelor', 'Seattle, WA', 'Evaluated'),
('Olivia', 'Garcia', 'olivia.garcia@email.com', '+1-555-0106', 10, 'HR Director', 'Master', 'Boston, MA', 'Evaluated'),
('David', 'Miller', 'david.miller@email.com', '+1-555-0107', 7, 'Sales Manager', 'Bachelor', 'Denver, CO', 'Evaluated'),
('Ava', 'Davis', 'ava.davis@email.com', '+1-555-0108', 9, 'Product Owner', 'Master', 'Los Angeles, CA', 'Evaluated'),
('Joseph', 'Rodriguez', 'joseph.rodriguez@email.com', '+1-555-0109', 6, 'UX Design Lead', 'Bachelor', 'Portland, OR', 'Evaluated'),
('Isabella', 'Martinez', 'isabella.martinez@email.com', '+1-555-0110', 11, 'Chief Strategy Officer', 'PhD', 'Miami, FL', 'Evaluated'),
('Robert', 'Hernandez', 'robert.hernandez@email.com', '+1-555-0111', 4, 'Data Scientist', 'Master', 'Atlanta, GA', 'Evaluated'),
('Mia', 'Lopez', 'mia.lopez@email.com', '+1-555-0112', 13, 'Director of Operations', 'MBA', 'Dallas, TX', 'Evaluated'),
('Daniel', 'Gonzalez', 'daniel.gonzalez@email.com', '+1-555-0113', 2, 'Junior Project Manager', 'Bachelor', 'Phoenix, AZ', 'Evaluated'),
('Charlotte', 'Wilson', 'charlotte.wilson@email.com', '+1-555-0114', 15, 'CEO', 'PhD', 'Philadelphia, PA', 'Evaluated'),
('Thomas', 'Anderson', 'thomas.anderson@email.com', '+1-555-0115', 8, 'Engineering Manager', 'Master', 'San Diego, CA', 'Evaluated'),
('Amelia', 'Thomas', 'amelia.thomas@email.com', '+1-555-0116', 5, 'Content Strategy Lead', 'Bachelor', 'Minneapolis, MN', 'Evaluated'),
('Christopher', 'Taylor', 'christopher.taylor@email.com', '+1-555-0117', 10, 'Finance Director', 'MBA', 'Detroit, MI', 'Evaluated'),
('Harper', 'Moore', 'harper.moore@email.com', '+1-555-0118', 7, 'Customer Success Manager', 'Bachelor', 'Nashville, TN', 'Evaluated'),
('Matthew', 'Jackson', 'matthew.jackson@email.com', '+1-555-0119', 12, 'VP of Sales', 'Master', 'Charlotte, NC', 'Evaluated'),
('Evelyn', 'Martin', 'evelyn.martin@email.com', '+1-555-0120', 6, 'Innovation Manager', 'PhD', 'Raleigh, NC', 'Evaluated'),
('John', 'Lee', 'john.lee@email.com', '+1-555-0121', 9, 'Product Marketing Manager', 'Master', 'Indianapolis, IN', 'Evaluated'),
('Abigail', 'Perez', 'abigail.perez@email.com', '+1-555-0122', 4, 'Business Development Associate', 'Bachelor', 'Columbus, OH', 'Evaluated'),
('Andrew', 'Thompson', 'andrew.thompson@email.com', '+1-555-0123', 11, 'CTO', 'PhD', 'Jacksonville, FL', 'Evaluated'),
('Emily', 'White', 'emily.white@email.com', '+1-555-0124', 3, 'Marketing Coordinator', 'Bachelor', 'Memphis, TN', 'Evaluated'),
('Joshua', 'Harris', 'joshua.harris@email.com', '+1-555-0125', 14, 'VP of Product', 'Master', 'Louisville, KY', 'Evaluated'),
('Elizabeth', 'Sanchez', 'elizabeth.sanchez@email.com', '+1-555-0126', 8, 'Operations Manager', 'MBA', 'Milwaukee, WI', 'Evaluated'),
('Ryan', 'Clark', 'ryan.clark@email.com', '+1-555-0127', 5, 'Program Manager', 'Bachelor', 'Albuquerque, NM', 'Evaluated'),
('Sofia', 'Ramirez', 'sofia.ramirez@email.com', '+1-555-0128', 10, 'HR VP', 'Master', 'Tucson, AZ', 'Evaluated'),
('Nicholas', 'Lewis', 'nicholas.lewis@email.com', '+1-555-0129', 7, 'Analytics Director', 'PhD', 'Fresno, CA', 'Evaluated'),
('Avery', 'Robinson', 'avery.robinson@email.com', '+1-555-0130', 13, 'Chief Innovation Officer', 'PhD', 'Sacramento, CA', 'Evaluated'),
('Alexander', 'Walker', 'alexander.walker@email.com', '+1-555-0131', 6, 'Senior Consultant', 'Master', 'Kansas City, MO', 'Evaluated'),
('Ella', 'Young', 'ella.young@email.com', '+1-555-0132', 9, 'Brand Director', 'Bachelor', 'Mesa, AZ', 'Evaluated'),
('Benjamin', 'Allen', 'benjamin.allen@email.com', '+1-555-0133', 4, 'Product Analyst', 'Master', 'Virginia Beach, VA', 'Evaluated'),
('Scarlett', 'King', 'scarlett.king@email.com', '+1-555-0134', 12, 'VP of Marketing', 'MBA', 'Atlanta, GA', 'Evaluated'),
('Samuel', 'Wright', 'samuel.wright@email.com', '+1-555-0135', 2, 'Associate Product Manager', 'Bachelor', 'Oakland, CA', 'Evaluated'),
('Grace', 'Scott', 'grace.scott@email.com', '+1-555-0136', 15, 'Chief Operating Officer', 'PhD', 'Minneapolis, MN', 'Evaluated'),
('Nathan', 'Torres', 'nathan.torres@email.com', '+1-555-0137', 8, 'Design Director', 'Master', 'Tulsa, OK', 'Evaluated'),
('Chloe', 'Nguyen', 'chloe.nguyen@email.com', '+1-555-0138', 5, 'Strategy Manager', 'Bachelor', 'Arlington, TX', 'Evaluated'),
('Jonathan', 'Hill', 'jonathan.hill@email.com', '+1-555-0139', 11, 'VP of Technology', 'PhD', 'New Orleans, LA', 'Evaluated'),
('Victoria', 'Flores', 'victoria.flores@email.com', '+1-555-0140', 7, 'Customer Experience Director', 'Master', 'Bakersfield, CA', 'Evaluated');

-- ====================================================================
-- INSERT CANDIDATE SKILLS (Randomized realistic assignments)
-- ====================================================================

-- Candidate 1: James Smith
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(1, 1, 'Expert'), (1, 3, 'Advanced'), (1, 4, 'Expert'), (1, 6, 'Advanced'), (1, 11, 'Expert');

-- Candidate 2: Emma Johnson
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(2, 2, 'Advanced'), (2, 5, 'Expert'), (2, 6, 'Advanced'), (2, 10, 'Advanced');

-- Candidate 3: Michael Williams
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(3, 2, 'Expert'), (3, 8, 'Advanced'), (3, 13, 'Advanced'), (3, 15, 'Expert');

-- Candidate 4: Sophia Brown
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(4, 1, 'Expert'), (4, 4, 'Expert'), (4, 7, 'Expert'), (4, 11, 'Expert'), (4, 12, 'Advanced');

-- Candidate 5: William Jones
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(5, 3, 'Intermediate'), (5, 7, 'Advanced'), (5, 14, 'Intermediate');

-- Candidate 6: Olivia Garcia
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(6, 2, 'Expert'), (6, 5, 'Expert'), (6, 10, 'Expert'), (6, 12, 'Advanced'), (6, 13, 'Advanced');

-- Candidate 7: David Miller
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(7, 2, 'Advanced'), (7, 9, 'Advanced'), (7, 13, 'Expert'), (7, 14, 'Advanced');

-- Candidate 8: Ava Davis
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(8, 1, 'Advanced'), (8, 3, 'Expert'), (8, 4, 'Advanced'), (8, 6, 'Expert');

-- Candidate 9: Joseph Rodriguez
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(9, 8, 'Expert'), (9, 15, 'Expert'), (9, 2, 'Advanced'), (9, 3, 'Advanced');

-- Candidate 10: Isabella Martinez
INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(10, 1, 'Expert'), (10, 4, 'Expert'), (10, 11, 'Expert'), (10, 13, 'Advanced'), (10, 9, 'Advanced');

-- Continue for all 40 candidates...
-- (Abbreviated for brevity - add similar patterns for candidates 11-40)

INSERT INTO candidate_skills (candidate_id, skill_id, proficiency_level) VALUES
(11, 3, 'Expert'), (11, 7, 'Expert'), (11, 14, 'Advanced'),
(12, 1, 'Expert'), (12, 6, 'Expert'), (12, 11, 'Advanced'), (12, 14, 'Expert'),
(13, 6, 'Intermediate'), (13, 9, 'Intermediate'), (13, 14, 'Intermediate'),
(14, 1, 'Expert'), (14, 4, 'Expert'), (14, 11, 'Expert'), (14, 12, 'Expert'),
(15, 1, 'Advanced'), (15, 7, 'Advanced'), (15, 12, 'Advanced'),
(16, 2, 'Advanced'), (16, 8, 'Expert'), (16, 15, 'Expert'),
(17, 3, 'Expert'), (17, 4, 'Advanced'), (17, 11, 'Expert'), (17, 14, 'Expert'),
(18, 2, 'Expert'), (18, 10, 'Advanced'), (18, 13, 'Advanced'),
(19, 1, 'Expert'), (19, 2, 'Advanced'), (19, 13, 'Expert'), (19, 11, 'Advanced'),
(20, 8, 'Expert'), (20, 15, 'Expert'), (20, 3, 'Advanced'), (20, 9, 'Expert'),
(21, 2, 'Advanced'), (21, 4, 'Advanced'), (21, 6, 'Advanced'),
(22, 3, 'Intermediate'), (22, 9, 'Intermediate'), (22, 13, 'Intermediate'),
(23, 1, 'Expert'), (23, 4, 'Expert'), (23, 7, 'Expert'), (23, 11, 'Expert'),
(24, 2, 'Intermediate'), (24, 8, 'Intermediate'), (24, 15, 'Advanced'),
(25, 1, 'Expert'), (25, 3, 'Expert'), (25, 4, 'Expert'), (25, 6, 'Advanced'),
(26, 5, 'Expert'), (26, 6, 'Advanced'), (26, 11, 'Advanced'), (26, 14, 'Expert'),
(27, 6, 'Advanced'), (27, 9, 'Advanced'), (27, 14, 'Advanced'),
(28, 2, 'Expert'), (28, 5, 'Expert'), (28, 10, 'Expert'), (28, 12, 'Advanced'),
(29, 3, 'Expert'), (29, 7, 'Expert'), (29, 11, 'Advanced'), (29, 14, 'Expert'),
(30, 1, 'Expert'), (30, 4, 'Expert'), (30, 8, 'Expert'), (30, 11, 'Expert'),
(31, 3, 'Advanced'), (31, 4, 'Advanced'), (31, 13, 'Advanced'),
(32, 2, 'Expert'), (32, 8, 'Advanced'), (32, 15, 'Expert'),
(33, 3, 'Advanced'), (33, 7, 'Advanced'), (33, 14, 'Advanced'),
(34, 1, 'Expert'), (34, 2, 'Expert'), (34, 4, 'Advanced'), (34, 13, 'Expert'),
(35, 3, 'Intermediate'), (35, 6, 'Intermediate'), (35, 9, 'Intermediate'),
(36, 1, 'Expert'), (36, 4, 'Expert'), (36, 6, 'Expert'), (36, 11, 'Expert'),
(37, 8, 'Expert'), (37, 15, 'Expert'), (37, 2, 'Advanced'),
(38, 3, 'Advanced'), (38, 4, 'Expert'), (38, 11, 'Advanced'),
(39, 1, 'Expert'), (39, 4, 'Expert'), (39, 7, 'Expert'), (39, 11, 'Advanced'),
(40, 2, 'Expert'), (40, 5, 'Advanced'), (40, 10, 'Expert'), (40, 13, 'Advanced');

-- ====================================================================
-- INSERT AI EVALUATIONS (Realistic scores 70-100)
-- ====================================================================

INSERT INTO evaluations (candidate_id, crisis_management_score, sustainability_score, team_motivation_score, 
    crisis_management_analysis, sustainability_analysis, team_motivation_analysis, overall_summary) VALUES

(1, 92.5, 88.3, 90.7, 
    'Demonstrates exceptional crisis management with proven track record in high-pressure situations.',
    'Strong sustainability knowledge with implementation experience in green initiatives.',
    'Exemplary team motivation skills with consistent ability to inspire and drive performance.',
    'Outstanding overall candidate with well-rounded leadership capabilities.'),

(2, 85.2, 91.4, 87.9,
    'Strong crisis response capabilities with data-driven decision making approach.',
    'Outstanding sustainability advocate with innovative green program implementations.',
    'Excellent team builder with proven mentorship track record.',
    'High-performing candidate with exceptional sustainability focus.'),

(3, 78.6, 82.1, 89.3,
    'Good crisis management with creative problem-solving under pressure.',
    'Solid sustainability understanding with active participation in eco-initiatives.',
    'Exceptional team motivation through inspiring communication and vision.',
    'Strong candidate with outstanding motivational leadership.'),

(4, 95.8, 94.2, 93.6,
    'Exceptional crisis leadership with strategic planning and rapid response capabilities.',
    'Outstanding sustainability champion with comprehensive program development.',
    'Exemplary team motivation with proven ability to build high-performing cultures.',
    'Exceptional candidate - top-tier across all evaluation criteria.'),

(5, 73.4, 75.8, 71.2,
    'Developing crisis management skills with good analytical foundation.',
    'Foundational sustainability knowledge with growing practical application.',
    'Emerging team motivation capabilities with positive trajectory.',
    'Solid candidate with strong potential for growth.'),

(6, 89.1, 86.7, 92.3,
    'Strong crisis management with excellent emotional intelligence.',
    'Solid sustainability knowledge with HR-focused green initiatives.',
    'Outstanding team motivation with exceptional interpersonal skills.',
    'Excellent candidate with superior people leadership.'),

(7, 81.9, 79.4, 84.6,
    'Good crisis response with customer-focused problem solving.',
    'Solid sustainability awareness with sales-driven eco-approach.',
    'Strong team motivation with competitive spirit and goal orientation.',
    'Strong performer with balanced leadership capabilities.'),

(8, 87.3, 90.1, 88.5,
    'Excellent crisis management with product-focused strategic thinking.',
    'Outstanding sustainability integration in product development.',
    'Excellent team collaboration and cross-functional motivation.',
    'High-quality candidate with product leadership excellence.'),

(9, 76.8, 88.9, 82.4,
    'Good crisis management with user-centered design thinking.',
    'Exceptional sustainability focus in design methodology.',
    'Strong team motivation through creative collaboration.',
    'Strong candidate with outstanding design sustainability.'),

(10, 94.7, 92.8, 95.1,
    'Exceptional crisis leadership with strategic vision and execution.',
    'Outstanding sustainability strategy with long-term planning.',
    'Exemplary team motivation with transformational leadership.',
    'Exceptional candidate - strategic leadership excellence.'),

-- Continue for remaining 30 candidates with varied but realistic scores...

(11, 88.2, 85.6, 83.9,
    'Strong analytical crisis management with data-driven solutions.',
    'Solid sustainability knowledge with technical implementation focus.',
    'Good team motivation with collaborative analytical approach.',
    'Strong technical candidate with balanced skills.'),

(12, 91.4, 89.7, 90.2,
    'Excellent operational crisis management with process optimization.',
    'Strong sustainability operations integration.',
    'Excellent team leadership with operational excellence focus.',
    'Outstanding operations leader with comprehensive skills.'),

(13, 70.5, 72.8, 74.1,
    'Developing crisis management with good learning agility.',
    'Foundational sustainability understanding with growing expertise.',
    'Emerging team motivation with positive energy.',
    'Entry-level candidate with strong growth potential.'),

(14, 97.2, 96.5, 94.8,
    'Exceptional executive crisis leadership with proven track record.',
    'Outstanding sustainability vision with company-wide implementation.',
    'Exemplary team inspiration with transformational culture building.',
    'Top-tier executive candidate - exceptional across all areas.'),

(15, 84.6, 81.3, 86.7,
    'Strong technical crisis management with engineering excellence.',
    'Good sustainability technical implementation.',
    'Strong team motivation with technical mentorship.',
    'Excellent engineering leader with solid all-around skills.'),

(16, 77.9, 83.5, 80.2,
    'Good creative crisis management with content strategy.',
    'Strong sustainability communication and awareness.',
    'Good team motivation through creative collaboration.',
    'Strong creative professional with balanced capabilities.'),

(17, 89.8, 87.4, 85.9,
    'Excellent financial crisis management with risk mitigation.',
    'Strong sustainability in financial planning and ESG.',
    'Strong team motivation with financial leadership.',
    'Excellent finance leader with comprehensive skills.'),

(18, 82.7, 86.1, 91.4,
    'Good customer-focused crisis management.',
    'Strong sustainability in customer experience.',
    'Outstanding team motivation with customer success focus.',
    'Strong candidate with exceptional customer leadership.'),

(19, 93.6, 88.9, 92.1,
    'Exceptional sales crisis management with revenue recovery.',
    'Strong sustainability in sales operations.',
    'Excellent team motivation with sales leadership.',
    'Outstanding sales leader with executive potential.'),

(20, 79.3, 91.7, 84.8,
    'Good innovation crisis management with creative solutions.',
    'Exceptional sustainability innovation leadership.',
    'Strong team motivation through innovation culture.',
    'Strong candidate with outstanding innovation focus.'),

(21, 85.9, 84.2, 87.3,
    'Strong product marketing crisis management.',
    'Good sustainability in marketing strategy.',
    'Excellent team motivation with marketing leadership.',
    'Strong marketing professional with solid skills.'),

(22, 71.8, 74.5, 73.9,
    'Developing business development crisis skills.',
    'Foundational sustainability business knowledge.',
    'Emerging team collaboration capabilities.',
    'Entry-level candidate with good potential.'),

(23, 96.1, 93.4, 91.7,
    'Exceptional technical crisis leadership.',
    'Outstanding sustainability technology implementation.',
    'Excellent team motivation with technical vision.',
    'Exceptional CTO candidate with comprehensive expertise.'),

(24, 72.6, 78.2, 75.4,
    'Developing marketing crisis management.',
    'Good sustainability marketing awareness.',
    'Emerging team motivation skills.',
    'Junior candidate with growing capabilities.'),

(25, 94.3, 91.8, 93.2,
    'Exceptional product crisis management and strategy.',
    'Outstanding sustainability product integration.',
    'Excellent team motivation with product vision.',
    'Exceptional product leader - top performer.'),

(26, 86.4, 88.7, 85.1,
    'Strong operations crisis management.',
    'Excellent sustainability operations focus.',
    'Strong team motivation with operational leadership.',
    'Strong operations professional with solid skills.'),

(27, 80.1, 82.9, 84.3,
    'Good program crisis management.',
    'Good sustainability program integration.',
    'Strong team motivation with program leadership.',
    'Good program manager with balanced skills.'),

(28, 90.7, 89.3, 92.8,
    'Excellent HR crisis management and people leadership.',
    'Strong sustainability HR initiatives.',
    'Outstanding team motivation with people excellence.',
    'Excellent HR leader with superior people skills.'),

(29, 87.5, 93.1, 86.2,
    'Strong analytics crisis management.',
    'Exceptional sustainability data and analytics.',
    'Strong team motivation with analytical leadership.',
    'Strong analytics leader with outstanding sustainability.'),

(30, 95.4, 94.7, 96.3,
    'Exceptional innovation crisis leadership.',
    'Outstanding sustainability innovation strategy.',
    'Exemplary team motivation with innovation culture.',
    'Exceptional innovation leader - top-tier candidate.'),

(31, 83.2, 81.7, 79.8,
    'Good consulting crisis management.',
    'Good sustainability consulting expertise.',
    'Good team motivation with consulting approach.',
    'Strong consultant with solid capabilities.'),

(32, 86.8, 88.4, 90.6,
    'Strong brand crisis management.',
    'Strong sustainability brand integration.',
    'Excellent team motivation with brand leadership.',
    'Strong brand leader with excellent skills.'),

(33, 75.9, 80.3, 77.6,
    'Good analytical crisis management.',
    'Good sustainability product analysis.',
    'Good team collaboration skills.',
    'Solid analyst with balanced capabilities.'),

(34, 92.7, 90.5, 94.1,
    'Excellent marketing crisis leadership.',
    'Outstanding sustainability marketing strategy.',
    'Exemplary team motivation with marketing vision.',
    'Outstanding marketing leader - high performer.'),

(35, 71.2, 73.6, 70.8,
    'Developing product crisis management.',
    'Foundational sustainability product knowledge.',
    'Emerging team motivation capabilities.',
    'Junior candidate with growth potential.'),

(36, 96.8, 95.3, 97.1,
    'Exceptional operational crisis leadership.',
    'Outstanding sustainability operations strategy.',
    'Exemplary team motivation with operational excellence.',
    'Exceptional COO candidate - top-tier executive.'),

(37, 85.3, 89.6, 87.2,
    'Strong design crisis management.',
    'Excellent sustainability design integration.',
    'Strong team motivation with design leadership.',
    'Strong design leader with excellent skills.'),

(38, 81.4, 87.8, 83.5,
    'Good strategy crisis management.',
    'Strong sustainability strategy development.',
    'Good team motivation with strategic thinking.',
    'Good strategy professional with solid skills.'),

(39, 93.9, 91.2, 89.7,
    'Exceptional technology crisis leadership.',
    'Outstanding sustainability technology vision.',
    'Excellent team motivation with technical leadership.',
    'Outstanding technology leader - high performer.'),

(40, 88.6, 90.9, 92.4,
    'Strong customer experience crisis management.',
    'Excellent sustainability customer focus.',
    'Excellent team motivation with CX leadership.',
    'Excellent CX leader with superior skills.');

-- ====================================================================
-- VERIFY DATA
-- ====================================================================

-- Check total candidates
SELECT COUNT(*) AS total_candidates FROM candidates;

-- Check top 10 ranked candidates
SELECT * FROM v_top_performers;

-- Check skills distribution
SELECT 
    s.skill_name,
    COUNT(cs.candidate_id) AS candidate_count
FROM skills s
LEFT JOIN candidate_skills cs ON s.skill_id = cs.skill_id
GROUP BY s.skill_id, s.skill_name
ORDER BY candidate_count DESC;

-- Check average scores
SELECT 
    ROUND(AVG(crisis_management_score), 2) AS avg_crisis,
    ROUND(AVG(sustainability_score), 2) AS avg_sustainability,
    ROUND(AVG(team_motivation_score), 2) AS avg_team_motivation,
    ROUND(AVG(overall_score), 2) AS avg_overall
FROM evaluations;

-- ====================================================================
-- END OF SAMPLE DATA
-- ====================================================================
