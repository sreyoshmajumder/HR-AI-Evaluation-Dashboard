# HR AI EVALUATION SYSTEM - AI PROMPTS & RUBRICS

**Document Version:** 1.0  
**Created:** February 04, 2026  
**Purpose:** Comprehensive AI evaluation prompts for candidate assessment across three key dimensions

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Evaluation Framework](#evaluation-framework)
3. [Prompt 1: Crisis Management Evaluation](#prompt-1-crisis-management-evaluation)
4. [Prompt 2: Sustainability Knowledge & Implementation](#prompt-2-sustainability-knowledge--implementation)
5. [Prompt 3: Team Motivation & Leadership](#prompt-3-team-motivation--leadership)
6. [Scoring Guidelines](#scoring-guidelines)
7. [Implementation Guide](#implementation-guide)

---

## 🎯 Overview

This document provides three specialized AI evaluation prompts designed to assess candidates across critical competency areas. Each prompt is engineered to:

- Extract meaningful insights from candidate profiles
- Generate quantifiable scores (0-100 scale)
- Produce detailed narrative analysis
- Support consistent evaluation across all candidates
- Enable data-driven hiring decisions

**Target Audience:** HR professionals, hiring managers, recruitment specialists  
**Evaluation Scope:** All candidates regardless of role or experience level  
**Output Format:** Numeric score + detailed written analysis

---

## 🏗️ Evaluation Framework

### Three-Pillar Competency Model

```
┌─────────────────────────────────────────────────────────┐
│         CANDIDATE EVALUATION FRAMEWORK                  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. CRISIS MANAGEMENT (30%)                            │
│     └─ Decision-making under pressure                  │
│     └─ Problem-solving capability                      │
│     └─ Resilience & adaptability                       │
│                                                         │
│  2. SUSTAINABILITY (35%)                               │
│     └─ Environmental awareness                         │
│     └─ Long-term strategic thinking                    │
│     └─ ESG implementation experience                   │
│                                                         │
│  3. TEAM MOTIVATION (35%)                              │
│     └─ Leadership & inspiration                        │
│     └─ People management                               │
│     └─ Culture building capability                     │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Evaluation Criteria

| Criterion | Weight | Measurement |
|-----------|--------|-------------|
| Crisis Management | 30% | Score 0-100 |
| Sustainability | 35% | Score 0-100 |
| Team Motivation | 35% | Score 0-100 |
| **Overall Score** | 100% | Average of three scores |

---

## 📌 Prompt 1: Crisis Management Evaluation

### **System Prompt (Context Setting)**

```
You are an expert HR evaluation specialist with 20+ years of experience 
in assessing leadership capabilities during high-pressure situations. 
Your role is to evaluate candidates' crisis management capabilities 
based on their professional background, experience, skills, and any 
available assessments or interviews.

Evaluate based on:
- Decision-making speed and quality under pressure
- Problem-solving approach in ambiguous situations
- Ability to remain calm and focused during crises
- Track record of handling difficult situations
- Resilience and adaptability
- Communication effectiveness during emergencies
```

### **Evaluation Prompt 1**

```
CRISIS MANAGEMENT COMPETENCY ASSESSMENT

Candidate Information:
- Name: {CANDIDATE_NAME}
- Years of Experience: {YEARS_EXPERIENCE}
- Current Position: {CURRENT_POSITION}
- Education Level: {EDUCATION_LEVEL}
- Skills: {CANDIDATE_SKILLS}
- Background Summary: {RESUME_OR_BIO}

EVALUATION TASK:
Assess this candidate's crisis management capabilities on a scale of 0-100 
based on the following dimensions:

1. **Decision-Making Under Pressure (25 points)**
   - Evidence of rapid, effective decisions during emergencies
   - Quality of decision outcomes
   - Risk assessment and mitigation
   - Ability to prioritize critical actions

2. **Problem-Solving Approach (25 points)**
   - Creative and practical solution generation
   - Root cause analysis capability
   - Resource optimization during crises
   - Innovative thinking under constraints

3. **Emotional Resilience & Composure (25 points)**
   - Maintains focus during high-stress situations
   - Demonstrates calm leadership presence
   - Manages own stress effectively
   - Supports team stability during turbulence

4. **Communication & Coordination (25 points)**
   - Clear, timely communication during emergencies
   - Ability to align teams toward crisis resolution
   - Stakeholder management
   - Transparency and authenticity

SCORING GUIDELINES:
- 90-100: Exceptional crisis leader with proven track record
- 80-89: Strong crisis management with solid experience
- 70-79: Good crisis management capabilities
- 60-69: Developing crisis management skills
- Below 60: Limited evidence of crisis management capability

REQUIRED OUTPUT FORMAT:
{
  "score": [NUMERIC_SCORE_0_100],
  "dimensions": {
    "decision_making_score": [0-25],
    "problem_solving_score": [0-25],
    "emotional_resilience_score": [0-25],
    "communication_score": [0-25]
  },
  "analysis": "[DETAILED_ANALYSIS_PARAGRAPH]",
  "key_strengths": "[LIST_2_3_STRENGTHS]",
  "development_areas": "[LIST_1_2_DEVELOPMENT_AREAS]",
  "example_evidence": "[SPECIFIC_EXAMPLE_FROM_BACKGROUND]"
}

Provide a thorough, objective assessment that would be useful for 
hiring decisions. Be specific and cite evidence from the candidate's 
background where possible.
```

### **Example Output**

```json
{
  "score": 85,
  "dimensions": {
    "decision_making_score": 22,
    "problem_solving_score": 21,
    "emotional_resilience_score": 21,
    "communication_score": 21
  },
  "analysis": "James demonstrates strong crisis management capabilities with 12 years of experience in senior product roles. He shows excellent decision-making speed backed by analytical frameworks learned through his Master's education. His problem-solving approach is systematic, drawing on technical background and data analysis skills. Resilience is evidenced through his progression to increasingly senior roles managing complex cross-functional teams. Communication strengths are reflected in his negotiation and team building capabilities. His sustainability knowledge suggests forward-thinking mindset valuable during strategic crises.",
  "key_strengths": [
    "Systematic, data-driven decision-making approach",
    "Strong communication and stakeholder alignment capabilities",
    "Proven ability to lead through complexity and change"
  ],
  "development_areas": [
    "Limited explicit crisis management examples in background",
    "Could benefit from formal crisis leadership training"
  ],
  "example_evidence": "12 years in senior product management suggests regular exposure to market crises, product failures, and competitive pressures requiring rapid decision-making and team stability maintenance."
}
```

---

## 🌱 Prompt 2: Sustainability Knowledge & Implementation

### **System Prompt (Context Setting)**

```
You are a sustainability and ESG (Environmental, Social, Governance) 
expert with credentials in corporate sustainability and circular economy. 
Your expertise includes assessing candidates' understanding of and commitment 
to sustainable business practices, environmental responsibility, and long-term 
value creation.

Evaluate based on:
- Understanding of sustainability concepts and frameworks
- Experience with environmental and social initiatives
- Knowledge of ESG metrics and reporting
- Commitment to sustainable practices
- Ability to balance short-term performance with long-term sustainability
- Integration of sustainability into decision-making
```

### **Evaluation Prompt 2**

```
SUSTAINABILITY KNOWLEDGE & IMPLEMENTATION ASSESSMENT

Candidate Information:
- Name: {CANDIDATE_NAME}
- Years of Experience: {YEARS_EXPERIENCE}
- Current Position: {CURRENT_POSITION}
- Education Level: {EDUCATION_LEVEL}
- Skills: {CANDIDATE_SKILLS}
- Background Summary: {RESUME_OR_BIO}
- Location: {LOCATION}

EVALUATION TASK:
Assess this candidate's sustainability knowledge and capability to 
implement sustainable practices on a scale of 0-100 based on:

1. **Sustainability Conceptual Knowledge (20 points)**
   - Understanding of sustainability frameworks (SDGs, ESG, circular economy)
   - Knowledge of environmental impact and metrics
   - Social responsibility awareness
   - Governance and ethics understanding

2. **Environmental Initiative Experience (20 points)**
   - Demonstrated experience with green/eco initiatives
   - Carbon footprint reduction involvement
   - Waste reduction or circular economy projects
   - Renewable energy or sustainable resource management

3. **Social & Governance Implementation (20 points)**
   - Experience with diversity, equity, and inclusion programs
   - Community engagement or social impact initiatives
   - Ethical governance and compliance knowledge
   - Stakeholder engagement on social issues

4. **Strategic Integration & Future Focus (20 points)**
   - Ability to integrate sustainability into business strategy
   - Long-term thinking and planning horizon
   - Innovation in sustainable solutions
   - Advocacy and cultural transformation capability

5. **Demonstrated Commitment (20 points)**
   - Personal commitment beyond job requirements
   - Participation in sustainability initiatives
   - Professional development in sustainability
   - Track record of sustainable decision-making

SCORING GUIDELINES:
- 90-100: Outstanding sustainability champion with strategic implementation
- 80-89: Strong sustainability knowledge and active engagement
- 70-79: Solid understanding with meaningful initiatives
- 60-69: Foundational knowledge with some implementation experience
- Below 60: Limited sustainability knowledge or experience

REQUIRED OUTPUT FORMAT:
{
  "score": [NUMERIC_SCORE_0_100],
  "dimensions": {
    "conceptual_knowledge_score": [0-20],
    "environmental_experience_score": [0-20],
    "social_governance_score": [0-20],
    "strategic_integration_score": [0-20],
    "commitment_score": [0-20]
  },
  "analysis": "[DETAILED_ANALYSIS_PARAGRAPH]",
  "sustainability_focus_areas": "[AREAS_OF_EXPERTISE]",
  "implementation_capability": "[ASSESSMENT_OF_ABILITY_TO_DRIVE_CHANGE]",
  "potential_contributions": "[HOW_CANDIDATE_COULD_ADVANCE_SUSTAINABILITY]",
  "growth_opportunities": "[AREAS_FOR_DEVELOPMENT]"
}

Assess both explicit sustainability experience and indicators of 
sustainable thinking patterns (e.g., long-term focus, systems thinking, 
stakeholder consideration). Look for evidence even if not formally labeled 
as "sustainability."
```

### **Example Output**

```json
{
  "score": 88,
  "dimensions": {
    "conceptual_knowledge_score": 18,
    "environmental_experience_score": 17,
    "social_governance_score": 19,
    "strategic_integration_score": 18,
    "commitment_score": 16
  },
  "analysis": "Emma demonstrates strong sustainability knowledge and implementation capability with 8 years of operations leadership. Her HR director role positions her as a champion of social responsibility through diversity and culture initiatives. Her operations background suggests exposure to efficiency, resource optimization, and waste reduction - core sustainability concepts. Educational background (Master's level) indicates foundational knowledge of strategic frameworks. Team building and conflict resolution skills suggest social governance awareness. Operations management directly involves lifecycle thinking and resource optimization.",
  "sustainability_focus_areas": [
    "Social governance through HR and organizational development",
    "Operational efficiency and resource optimization",
    "Stakeholder engagement and culture transformation"
  ],
  "implementation_capability": "High capability to drive sustainability initiatives through organizational culture and people systems. Could effectively champion social responsibility and governance aspects. Would benefit from deeper environmental sustainability technical knowledge.",
  "potential_contributions": [
    "ESG reporting and governance frameworks",
    "Diversity and inclusion strategy",
    "Sustainable workplace practices",
    "Supply chain social responsibility through vendor management"
  ],
  "growth_opportunities": [
    "Environmental sustainability and carbon metrics knowledge",
    "Scientific understanding of climate impact",
    "Circular economy and product lifecycle thinking"
  ]
}
```

---

## 💪 Prompt 3: Team Motivation & Leadership

### **System Prompt (Context Setting)**

```
You are an organizational psychology expert and leadership development 
specialist with 25+ years of experience in team dynamics, motivation, 
and organizational culture. Your expertise includes assessing candidates' 
ability to inspire, motivate, and lead high-performing teams.

Evaluate based on:
- Demonstrated leadership experience
- Ability to inspire and motivate others
- Team building and culture creation
- Mentorship and development of talent
- Emotional intelligence and interpersonal skills
- Communication and vision articulation
- Track record of team performance
```

### **Evaluation Prompt 3**

```
TEAM MOTIVATION & LEADERSHIP ASSESSMENT

Candidate Information:
- Name: {CANDIDATE_NAME}
- Years of Experience: {YEARS_EXPERIENCE}
- Current Position: {CURRENT_POSITION}
- Education Level: {EDUCATION_LEVEL}
- Skills: {CANDIDATE_SKILLS}
- Background Summary: {RESUME_OR_BIO}

EVALUATION TASK:
Assess this candidate's ability to motivate teams and provide effective 
leadership on a scale of 0-100 based on:

1. **Leadership Experience & Track Record (20 points)**
   - Years and scope of leadership responsibility
   - Team size and complexity managed
   - Evidence of team success and performance
   - Progression into increasingly senior roles
   - Ability to build and scale teams

2. **Inspirational Communication (20 points)**
   - Ability to articulate vision and purpose
   - Clarity and effectiveness of communication
   - Storytelling and narrative capability
   - Authenticity and credibility as leader
   - Motivation through compelling messaging

3. **Team Development & Mentorship (20 points)**
   - History of developing talent
   - Mentoring and coaching capability
   - Career advancement of direct reports
   - Investment in team member growth
   - Feedback and performance management approach

4. **Emotional Intelligence & Empathy (20 points)**
   - Self-awareness and emotional regulation
   - Empathy and understanding of others
   - Ability to read and respond to team emotions
   - Conflict resolution and difficult conversations
   - Psychological safety cultivation

5. **Culture & Team Cohesion (20 points)**
   - Ability to create positive team culture
   - Collaboration and cross-functional work
   - Celebration of wins and learning from failures
   - Diversity and inclusion in team building
   - Long-term team commitment and retention

SCORING GUIDELINES:
- 90-100: Exceptional leader with transformational impact on teams
- 80-89: Strong leadership with proven team success
- 70-79: Good leadership capability with positive team outcomes
- 60-69: Developing leadership skills with mixed results
- Below 60: Limited evidence of effective team leadership

REQUIRED OUTPUT FORMAT:
{
  "score": [NUMERIC_SCORE_0_100],
  "dimensions": {
    "leadership_experience_score": [0-20],
    "inspirational_communication_score": [0-20],
    "team_development_score": [0-20],
    "emotional_intelligence_score": [0-20],
    "culture_cohesion_score": [0-20]
  },
  "analysis": "[DETAILED_ANALYSIS_PARAGRAPH]",
  "leadership_style": "[DESCRIPTION_OF_APPARENT_LEADERSHIP_STYLE]",
  "team_impact": "[ASSESSMENT_OF_POSITIVE_IMPACT_ON_TEAMS]",
  "motivation_strengths": "[KEY_WAYS_CANDIDATE_MOTIVATES_OTHERS]",
  "leadership_philosophy": "[INFERRED_VALUES_AND_APPROACH]",
  "development_recommendations": "[AREAS_TO_STRENGTHEN_LEADERSHIP]"
}

Consider both explicit leadership roles and evidence of leadership 
qualities in individual contributor or specialized roles. Look for 
influence, mentorship, and positive team impact even outside formal 
leadership titles.
```

### **Example Output**

```json
{
  "score": 92,
  "dimensions": {
    "leadership_experience_score": 19,
    "inspirational_communication_score": 19,
    "team_development_score": 19,
    "emotional_intelligence_score": 19,
    "culture_cohesion_score": 16
  },
  "analysis": "Sophia demonstrates exceptional leadership capability with 14 years in senior engineering and executive roles. Her VP of Engineering position indicates responsibility for large, complex technical teams. PhD education suggests deep expertise and intellectual leadership. Strategic thinking and leadership skills are primary competencies. Communication, team building, and conflict resolution skills indicate high emotional intelligence. Adaptability and innovation suggest forward-thinking, inspirational leadership. Her progression to VP level demonstrates consistent success in motivating and scaling teams. The combination of technical depth, strategic vision, and people skills positions her as a transformational leader.",
  "leadership_style": "Strategic, visionary leader with strong technical credibility. Appears to combine hands-on technical understanding with big-picture strategic thinking. Creates confidence through expertise while inspiring teams toward ambitious goals.",
  "team_impact": "Extensive positive impact demonstrated through progression to VP level, management of large teams, and emphasis on team building and mentoring skills. Teams likely experience strong technical direction combined with clear communication and development opportunities.",
  "motivation_strengths": [
    "Technical credibility and expertise inspire confidence",
    "Strategic vision articulation motivates alignment",
    "Team building focus creates cohesive, collaborative environments",
    "Mentoring capability enables team member growth"
  ],
  "leadership_philosophy": "Values expertise balanced with people development. Likely believes in earning team trust through competence, then inspiring through shared vision and opportunity for growth.",
  "development_recommendations": [
    "Continue developing executive presence and stakeholder communication",
    "Expand diversity and inclusion leadership initiatives",
    "Deepen understanding of organizational psychology and culture building"
  ]
}
```

---

## 📊 Scoring Guidelines

### **Overall Score Calculation**

```
OVERALL_SCORE = (CRISIS_SCORE + SUSTAINABILITY_SCORE + TEAM_MOTIVATION_SCORE) / 3
```

### **Score Interpretation Framework**

| Score Range | Rating | Description | Recommendation |
|-------------|--------|-------------|-----------------|
| 95-100 | ⭐⭐⭐⭐⭐ Exceptional | Top-tier exceptional performer | Fast-track candidate, senior roles |
| 85-94 | ⭐⭐⭐⭐ Excellent | Strong across all dimensions | Executive track, immediate hire |
| 75-84 | ⭐⭐⭐ Good | Solid candidate, some areas strong | Standard promotion path, hire |
| 70-74 | ⭐⭐ Fair | Adequate but with gaps | Senior role: not ready; entry/mid role: hire with development |
| 65-69 | ⭐ Developing | Significant development areas | Junior roles, high-touch development |
| Below 65 | ⚠️ Limited | Major capability gaps | Not recommended unless significant growth potential |

### **Dimension-Specific Benchmarks**

**Crisis Management:**
- Executive roles: 85+
- Mid-level roles: 75+
- Entry roles: 65+

**Sustainability:**
- Strategy roles: 80+
- Operations roles: 70+
- All roles: 60+

**Team Motivation:**
- Leadership roles: 85+
- Individual contributor roles: 70+
- All roles: 65+

---

## 🔧 Implementation Guide

### **Step 1: Data Preparation**

Gather candidate information:
```
✓ Full name and contact info
✓ Years of experience
✓ Current position/title
✓ Education level and institutions
✓ Key skills (from resume/tests)
✓ Resume or biography summary
✓ Interview notes (if available)
✓ Location/geographic context
```

### **Step 2: API Integration (Example with Claude)**

```python
import anthropic
import json

def evaluate_candidate_crisis_management(candidate_data):
    """
    Evaluate candidate's crisis management capabilities using Claude API
    """
    client = anthropic.Anthropic()
    
    prompt = f"""
    CRISIS MANAGEMENT COMPETENCY ASSESSMENT

    Candidate Information:
    - Name: {candidate_data['name']}
    - Years of Experience: {candidate_data['years_experience']}
    - Current Position: {candidate_data['position']}
    - Education Level: {candidate_data['education']}
    - Skills: {', '.join(candidate_data['skills'])}
    - Background Summary: {candidate_data['background']}

    [Insert Prompt 1 here...]
    """
    
    response = client.messages.create(
        model="claude-3-5-sonnet-20241022",
        max_tokens=1500,
        messages=[
            {"role": "user", "content": prompt}
        ]
    )
    
    return response.content[0].text

# Usage
candidate = {
    'name': 'James Smith',
    'years_experience': 12,
    'position': 'Senior Product Manager',
    'education': 'Master',
    'skills': ['Leadership', 'Communication', 'Strategic Thinking'],
    'background': 'James has 12 years...'
}

result = evaluate_candidate_crisis_management(candidate)
print(result)
```

### **Step 3: Output Processing**

```python
import json

def parse_ai_evaluation(ai_response):
    """
    Parse AI response and extract structured data
    """
    # Extract JSON from response
    json_start = ai_response.find('{')
    json_end = ai_response.rfind('}') + 1
    json_str = ai_response[json_start:json_end]
    
    # Parse and store
    evaluation = json.loads(json_str)
    
    return {
        'score': evaluation['score'],
        'analysis': evaluation['analysis'],
        'strengths': evaluation['key_strengths'],
        'development_areas': evaluation['development_areas']
    }
```

### **Step 4: Database Storage**

```sql
INSERT INTO evaluations (
    candidate_id,
    crisis_management_score,
    sustainability_score,
    team_motivation_score,
    crisis_management_analysis,
    sustainability_analysis,
    team_motivation_analysis,
    overall_summary
) VALUES (
    1,
    85,
    88,
    92,
    'Detailed analysis text...',
    'Detailed analysis text...',
    'Detailed analysis text...',
    'Overall summary text...'
);
```

---

## 🎯 Best Practices

### **For AI Model Usage:**
1. **Use consistent formatting** - Same structure for all candidates
2. **Provide rich context** - Include resume, interview notes, assessments
3. **Multiple evaluators** - Consider averaging multiple AI runs
4. **Human review** - Always have HR review AI recommendations
5. **Benchmark against** - Compare scores to similar-level candidates

### **Quality Assurance:**
- ✅ Scores should vary reasonably (not all 80-90)
- ✅ Analysis should cite specific evidence
- ✅ Reasoning should be transparent
- ✅ Recommendations should be actionable
- ✅ Consistency across similar candidates

### **Bias Mitigation:**
- Remove identifying information (age, gender, nationality)
- Focus on competencies, not demographics
- Use multiple dimensions to avoid single-dimension bias
- Regular audit of scoring patterns
- Human review for outliers

---

## 📞 Support & Questions

**For implementation questions:**
- Consult your AI provider's documentation
- Test with pilot candidates first
- Iterate based on feedback
- Adjust prompts based on role requirements

**For evaluation questions:**
- Refer to scoring guidelines
- Review example outputs
- Calibrate with hiring team
- Establish organizational benchmarks

---

## 📄 Document Metadata

| Field | Value |
|-------|-------|
| **Document Type** | AI Evaluation Prompts & Rubrics |
| **Version** | 1.0 |
| **Created** | February 04, 2026 |
| **Last Updated** | February 04, 2026 |
| **Audience** | HR Professionals, Hiring Managers, Recruiters |
| **Total Prompts** | 3 (Crisis Management, Sustainability, Team Motivation) |
| **Scoring Scale** | 0-100 |
| **Evaluation Dimensions** | 5 per prompt |

---

**END OF DOCUMENT**

---

## 🔄 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | Feb 04, 2026 | Initial release with 3 evaluation prompts |

---

**© 2026 HR AI Evaluation System. All rights reserved.**
