<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:6C63FF,100:48C9B0&height=200&section=header&text=HR%20AI%20Evaluation%20Dashboard&fontSize=36&fontColor=ffffff&fontAlignY=35&desc=Intelligent%20Candidate%20Ranking%20for%20Production%20Line%20Management&descAlignY=55&descColor=e0e0e0" width="100%"/>

<br/>

[![Made with HTML](https://img.shields.io/badge/Made%20with-HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)](https://developer.mozilla.org/en-US/docs/Web/HTML)
[![MySQL](https://img.shields.io/badge/Database-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![AI Powered](https://img.shields.io/badge/AI-Powered-6C63FF?style=for-the-badge&logo=openai&logoColor=white)](https://openai.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Stars](https://img.shields.io/github/stars/sreyoshmajumder/HR-AI-Evaluation-Dashboard?style=for-the-badge&color=FFD700)](https://github.com/sreyoshmajumder/HR-AI-Evaluation-Dashboard/stargazers)
[![Status](https://img.shields.io/badge/Status-Active-48C9B0?style=for-the-badge)](https://github.com/sreyoshmajumder/HR-AI-Evaluation-Dashboard)

<br/>

> ### 🤖 A minimal, standalone AI-powered system for intelligently ranking candidates for a **Recycling Production Line Manager** role — featuring a MySQL backend, smart AI evaluation prompts, and a stunning React-powered dashboard UI.

<br/>

[🚀 Live Demo](#-quick-start) • [📐 Architecture](#-system-architecture) • [📦 Features](#-features) • [🗄️ Database](#-database-design) • [🤖 AI Prompts](#-ai-evaluation-engine) • [📊 Dashboard](#-dashboard-ui) • [🛠️ Setup](#-installation)

</div>

---

## 📌 Table of Contents

- [✨ Features](#-features)
- [🏗️ System Architecture](#-system-architecture)
- [📐 High-Level Design](#-high-level-design)
- [🔄 Data Flow Diagram](#-data-flow-diagram)
- [🗄️ Database Design](#-database-design)
- [🤖 AI Evaluation Engine](#-ai-evaluation-engine)
- [📊 Dashboard UI](#-dashboard-ui)
- [🧩 Component Architecture](#-component-architecture)
- [🛠️ Installation & Setup](#-installation--setup)
- [📁 Project Structure](#-project-structure)
- [🔑 Key Algorithms](#-key-algorithms)
- [🚀 Quick Start](#-quick-start)
- [🤝 Contributing](#-contributing)

---

## ✨ Features

<div align="center">

| 🎯 Feature | 📄 Description |
|:---|:---|
| 🧠 **AI-Powered Ranking** | Intelligent evaluation using structured AI prompts for unbiased candidate scoring |
| 👥 **40 Sample Candidates** | Pre-loaded realistic candidate dataset for immediate testing and demo |
| 🗄️ **MySQL Backend** | Robust relational database with normalized schema and optimized queries |
| 📊 **Interactive Dashboard** | React-based premium UI with real-time filtering, sorting, and visual analytics |
| ⚡ **Automated Scoring** | Multi-dimensional scoring across skills, experience, and role-fit criteria |
| 🏆 **Smart Ranking System** | Weighted composite score calculation with transparent reasoning |
| 🎨 **Premium UI Design** | Clean, modern interface designed for HR professionals |
| 🔍 **Advanced Filtering** | Multi-criteria filter engine for targeted candidate discovery |

</div>

---

## 🏗️ System Architecture

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                    HR AI EVALUATION DASHBOARD — SYSTEM ARCHITECTURE         ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║   ┌─────────────────────────────────────────────────────────────────────┐   ║
║   │                        PRESENTATION LAYER                           │   ║
║   │   ┌──────────────┐   ┌──────────────┐   ┌───────────────────────┐  │   ║
║   │   │  Candidate   │   │  Analytics   │   │   Ranking & Filters   │  │   ║
║   │   │   List View  │   │   Dashboard  │   │       Panel           │  │   ║
║   │   └──────┬───────┘   └──────┬───────┘   └──────────┬────────────┘  │   ║
║   └──────────┼────────────────── ┼──────────────────────┼──────────────┘   ║
║              │         HTML5 / CSS3 / React             │                  ║
║   ┌──────────▼─────────────────── ▼──────────────────────▼──────────────┐   ║
║   │                        BUSINESS LOGIC LAYER                         │   ║
║   │   ┌──────────────┐   ┌──────────────┐   ┌───────────────────────┐  │   ║
║   │   │   Scoring    │   │  Ranking     │   │    Filter & Sort      │  │   ║
║   │   │   Engine     │   │  Algorithm   │   │       Engine          │  │   ║
║   │   └──────┬───────┘   └──────┬───────┘   └──────────┬────────────┘  │   ║
║   │          │                  │                       │               │   ║
║   │   ┌──────▼───────────────────▼──────────────────────▼────────────┐  │   ║
║   │   │                   AI Evaluation Engine                        │  │   ║
║   │   │           (Structured Prompts → Score Generation)            │  │   ║
║   │   └─────────────────────────────────────────────────────────────┘  │   ║
║   └────────────────────────────────────────────────────────────────────┘   ║
║                                                                              ║
║   ┌────────────────────────────────────────────────────────────────────┐    ║
║   │                          DATA LAYER                                │    ║
║   │   ┌──────────────┐   ┌──────────────┐   ┌───────────────────────┐ │    ║
║   │   │  candidates  │   │   scores     │   │   sample_data.sql     │ │    ║
║   │   │   (table)    │◄──│   (table)    │   │   (40 candidates)     │ │    ║
║   │   └──────────────┘   └──────────────┘   └───────────────────────┘ │    ║
║   │                        MySQL Database                              │    ║
║   └────────────────────────────────────────────────────────────────────┘    ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

---

## 📐 High-Level Design

```
┌──────────────────────────────────────────────────────────────────────────┐
│                         HIGH-LEVEL SYSTEM DESIGN                         │
└──────────────────────────────────────────────────────────────────────────┘

  HR Manager                                                  AI Engine
     │                                                           │
     │  1. Upload / Input Candidate Data                         │
     ▼                                                           │
  ┌──────────┐    2. Fetch from DB    ┌──────────────────────┐  │
  │  Browser │ ──────────────────── ► │   MySQL Database     │  │
  │  (UI)    │ ◄────────────────────  │  - candidates table  │  │
  └──────────┘    3. Return Records   │  - scores table      │  │
       │                              └──────────────────────┘  │
       │  4. Send to AI Evaluation                              │
       │ ──────────────────────────────────────────────────────►│
       │                                                         │
       │  5. Receive Structured Scores                          │
       │ ◄──────────────────────────────────────────────────────│
       │                                                         │
       │  6. Render Ranked Dashboard
       │
  ┌────▼──────────────────────────────────────────────────────┐
  │                  DASHBOARD OUTPUT                          │
  │  ┌─────────────────┐  ┌──────────────────────────────┐   │
  │  │  Ranked List    │  │   Score Breakdown Chart       │   │
  │  │  #1 Candidate A │  │   ████████░░ Technical  80%  │   │
  │  │  #2 Candidate B │  │   ██████░░░░ Experience 65%  │   │
  │  │  #3 Candidate C │  │   █████████░ Leadership 88%  │   │
  │  └─────────────────┘  └──────────────────────────────┘   │
  └───────────────────────────────────────────────────────────┘
```

---

## 🔄 Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         DATA FLOW DIAGRAM                        │
└─────────────────────────────────────────────────────────────────┘

  ┌───────────────┐
  │  Input Source │
  │  (SQL / Form) │
  └───────┬───────┘
          │
          ▼
  ┌───────────────────────────────────────────────────┐
  │                  schema.sql                       │
  │   CREATE TABLE candidates (                       │
  │     id INT PRIMARY KEY AUTO_INCREMENT,            │
  │     name VARCHAR(255),                            │
  │     experience_years INT,                         │
  │     technical_score FLOAT,                        │
  │     leadership_score FLOAT,                       │
  │     ...                                           │
  │   )                                               │
  └───────────────────┬───────────────────────────────┘
                      │
                      ▼
  ┌───────────────────────────────────────────────────┐
  │               sample_data.sql                     │
  │   INSERT INTO candidates (40 rows)                │
  │   Pre-seeded realistic profiles                   │
  └───────────────────┬───────────────────────────────┘
                      │
                      ▼
  ┌───────────────────────────────────────────────────┐
  │              AI-Prompts.md                        │
  │   Prompt 1: Extract skills from resume text       │
  │   Prompt 2: Rate technical competency (0-100)     │
  │   Prompt 3: Assess leadership indicators          │
  │   Prompt 4: Calculate composite rank score        │
  └───────────────────┬───────────────────────────────┘
                      │
                      ▼
  ┌───────────────────────────────────────────────────┐
  │              index.html (React UI)                │
  │   - Reads from DB / mock JSON                     │
  │   - Computes weighted ranking                     │
  │   - Renders interactive table & charts            │
  └───────────────────────────────────────────────────┘
```

---

## 🗄️ Database Design

```sql
╔══════════════════════════════════════════════════════════════╗
║                    DATABASE SCHEMA (ERD)                     ║
╠══════════════════════════════════════════════════════════════╣
║                                                              ║
║  ┌─────────────────────────────────┐                        ║
║  │           candidates            │                        ║
║  ├─────────────────────────────────┤                        ║
║  │ PK  id               INT        │                        ║
║  │     name             VARCHAR    │                        ║
║  │     email            VARCHAR    │                        ║
║  │     experience_years INT        │                        ║
║  │     education        VARCHAR    │                        ║
║  │     technical_score  FLOAT      │────────────┐           ║
║  │     leadership_score FLOAT      │            │           ║
║  │     safety_score     FLOAT      │            │           ║
║  │     communication    FLOAT      │            │           ║
║  │     created_at       TIMESTAMP  │            │           ║
║  └─────────────────────────────────┘            │           ║
║                                                 │           ║
║  ┌─────────────────────────────────┐            │           ║
║  │           rankings              │            │           ║
║  ├─────────────────────────────────┤            │           ║
║  │ PK  id               INT        │            │           ║
║  │ FK  candidate_id     INT        │◄───────────┘           ║
║  │     composite_score  FLOAT      │                        ║
║  │     rank_position    INT        │                        ║
║  │     ai_reasoning     TEXT       │                        ║
║  │     evaluated_at     TIMESTAMP  │                        ║
║  └─────────────────────────────────┘                        ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
```

### 📊 Scoring Weights

```
┌──────────────────────────────────────────────────────────────┐
│                  COMPOSITE SCORE FORMULA                     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Composite Score =                                           │
│    ( Technical Score    × 0.35 )                            │
│  + ( Leadership Score   × 0.25 )                            │
│  + ( Safety Awareness   × 0.20 )                            │
│  + ( Communication      × 0.10 )                            │
│  + ( Experience Bonus   × 0.10 )                            │
│                                                              │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░  Technical     35% ████████████████  │
│  ▓▓▓▓▓▓▓▓▓░░░░░░░░░░░  Leadership    25% ████████████       │
│  ▓▓▓▓▓▓▓░░░░░░░░░░░░░  Safety        20% ██████████         │
│  ▓▓▓░░░░░░░░░░░░░░░░░  Communication 10% █████              │
│  ▓▓▓░░░░░░░░░░░░░░░░░  Experience    10% █████              │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## 🤖 AI Evaluation Engine

The `AI-Prompts.md` file contains carefully engineered prompts used to evaluate candidates consistently and without bias.

```
┌─────────────────────────────────────────────────────────────────┐
│                   AI EVALUATION PIPELINE                        │
└─────────────────────────────────────────────────────────────────┘

  Candidate Resume / Profile Text
           │
           ▼
  ┌────────────────────────────────────────────────────────────┐
  │  PROMPT 1 — Skill Extraction                               │
  │  "Extract all relevant skills from this candidate          │
  │   profile for a recycling production line manager role..." │
  └────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
  ┌────────────────────────────────────────────────────────────┐
  │  PROMPT 2 — Technical Competency Rating                    │
  │  "On a scale of 0-100, rate the candidate's technical      │
  │   competency based on the skills and experience listed..."  │
  └────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
  ┌────────────────────────────────────────────────────────────┐
  │  PROMPT 3 — Leadership & Safety Assessment                 │
  │  "Assess leadership indicators and safety compliance       │
  │   awareness from this profile. Score 0-100..."            │
  └────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
  ┌────────────────────────────────────────────────────────────┐
  │  PROMPT 4 — Composite Rank Calculation                     │
  │  "Using the sub-scores provided, compute a weighted        │
  │   composite rank and provide a one-line reasoning..."      │
  └────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
              ┌────────────────────────┐
              │  Structured JSON Output │
              │  { rank: 1,             │
              │    score: 87.4,         │
              │    reasoning: "..." }   │
              └────────────────────────┘
```

---

## 📊 Dashboard UI

```
╔═══════════════════════════════════════════════════════════════════════════╗
║  🏭  HR AI Evaluation Dashboard         [Filter ▼]  [Sort ▼]  [Export]   ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                           ║
║  Total Candidates: 40    ┊  Evaluated: 40    ┊  Top Score: 94.2          ║
║  ─────────────────────────────────────────────────────────────────────   ║
║                                                                           ║
║  RANK  │  NAME              │ EXP │ TECH │ LEAD │ SAFETY │  SCORE  │ ★  ║
║  ────────────────────────────────────────────────────────────────────    ║
║   #1   │  Candidate Alpha   │  8y │  91  │  88  │   95   │ ██ 94.2 │ ✓  ║
║   #2   │  Candidate Beta    │  6y │  87  │  85  │   90   │ ██ 89.5 │ ✓  ║
║   #3   │  Candidate Gamma   │  5y │  84  │  80  │   88   │ ██ 85.1 │    ║
║   #4   │  Candidate Delta   │  4y │  79  │  75  │   82   │ ██ 79.8 │    ║
║   ...  │  ...               │ ... │ ...  │ ...  │  ...   │  ...    │    ║
║                                                                           ║
║  ─────────────────────────────────────────────────────────────────────   ║
║  Score Distribution                AI Reasoning Preview                  ║
║  90-100 ████████  8 candidates     "Strong technical background          ║
║  80-89  ████████████ 14            in recycling ops, demonstrated        ║
║  70-79  ████████  10               team leadership in prior role..."     ║
║  <70    ██████    8                                                       ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

---

## 🧩 Component Architecture

```
index.html
│
├── 🎨 Styles (Inline CSS / Tailwind-style classes)
│   ├── Theme Variables (colors, spacing, typography)
│   ├── Card Components
│   ├── Table Styles
│   └── Chart Styles
│
├── 📦 React Components (via CDN)
│   ├── <App />                         — Root component
│   │   ├── <Header />                  — Logo + title + controls
│   │   ├── <StatsBar />                — Summary KPIs
│   │   ├── <FilterPanel />             — Multi-criteria filters
│   │   ├── <CandidateTable />          — Ranked sortable table
│   │   │   └── <CandidateRow />        — Single candidate row
│   │   ├── <ScoreChart />              — Distribution bar chart
│   │   └── <ReasoningModal />          — AI reasoning popup
│
├── 🗄️ Data Layer
│   ├── candidateData[]                 — In-memory sample data
│   ├── computeCompositeScore()         — Weighted score formula
│   └── rankCandidates()               — Sort + assign ranks
│
└── 🤖 AI Evaluation (via AI-Prompts.md)
    ├── skillExtractPrompt
    ├── technicalRatingPrompt
    ├── leadershipPrompt
    └── compositeRankPrompt
```

---

## 🛠️ Installation & Setup

### Prerequisites

```bash
# Required software
✅ MySQL 8.0+
✅ A modern web browser (Chrome, Firefox, Edge, Safari)
✅ Any local web server (optional, for live reload)
```

### Step 1 — Clone the Repository

```bash
git clone https://github.com/sreyoshmajumder/HR-AI-Evaluation-Dashboard.git
cd HR-AI-Evaluation-Dashboard
```

### Step 2 — Set Up the Database

```bash
# Log in to MySQL
mysql -u root -p

# Create the database
CREATE DATABASE hr_eval_db;
USE hr_eval_db;

# Run schema
SOURCE schema.sql;

# Seed with 40 sample candidates
SOURCE sample_data.sql;
```

### Step 3 — Launch the Dashboard

```bash
# Option A: Simply open in browser
open index.html

# Option B: Serve with Python
python3 -m http.server 8000
# → Visit: http://localhost:8000

# Option C: Serve with Node.js
npx serve .
# → Visit: http://localhost:3000
```

### Step 4 — (Optional) Configure AI Prompts

Open `AI-Prompts.md` and integrate the prompts with your preferred LLM API (OpenAI, Claude, etc.) to enable live AI scoring.

---

## 📁 Project Structure

```
HR-AI-Evaluation-Dashboard/
│
├── 📄 index.html           ← Main React dashboard UI (single-file app)
├── 🗄️ schema.sql           ← MySQL database schema definition
├── 📊 sample_data.sql      ← 40 pre-seeded candidate records
├── 🤖 AI-Prompts.md        ← Engineered AI evaluation prompt library
└── 📖 README.md            ← You are here!
```

---

## 🔑 Key Algorithms

### Composite Score Calculation

```javascript
function computeCompositeScore(candidate) {
  const WEIGHTS = {
    technical:     0.35,
    leadership:    0.25,
    safety:        0.20,
    communication: 0.10,
    experience:    0.10,
  };

  const expScore = Math.min(candidate.experience_years * 10, 100);

  return (
    candidate.technical_score    * WEIGHTS.technical     +
    candidate.leadership_score   * WEIGHTS.leadership    +
    candidate.safety_score       * WEIGHTS.safety        +
    candidate.communication      * WEIGHTS.communication +
    expScore                     * WEIGHTS.experience
  ).toFixed(1);
}
```

### Ranking Function

```javascript
function rankCandidates(candidates) {
  return candidates
    .map(c => ({ ...c, score: computeCompositeScore(c) }))
    .sort((a, b) => b.score - a.score)
    .map((c, i) => ({ ...c, rank: i + 1 }));
}
```

---

## 🚀 Quick Start

```
1. Clone repo → 2. Run schema.sql → 3. Run sample_data.sql → 4. Open index.html
       ↓                ↓                       ↓                     ↓
  git clone         mysql < schema          mysql < sample       browser opens
  the project       creates tables          seeds 40 rows         dashboard! 🎉
```

---

## 🤝 Contributing

Contributions are warmly welcome! Here's how:

```bash
# 1. Fork the repository
# 2. Create your feature branch
git checkout -b feature/amazing-feature

# 3. Commit your changes
git commit -m "✨ Add amazing feature"

# 4. Push to the branch
git push origin feature/amazing-feature

# 5. Open a Pull Request
```

---

## 📜 License

```
MIT License — feel free to use, modify, and distribute.
See LICENSE for full details.
```

---

<div align="center">

**Built with ❤️ by [sreyoshmajumder](https://github.com/sreyoshmajumder)**

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:48C9B0,100:6C63FF&height=100&section=footer" width="100%"/>

</div>
