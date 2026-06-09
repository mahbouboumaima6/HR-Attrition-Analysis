# HR Attrition Analysis Dashboard — Identifying Key Drivers of Employee Turnover

## Project Overview

This project analyzes employee attrition patterns across 1,470 employees using MySQL, Excel, and Power BI.

**The business question:** Why are employees leaving, and which departments and employee profiles are most at risk?

---

## Key Findings

* Overall attrition rate: **16.12%** (above the healthy 10% benchmark)
* Employees under 25 have the highest attrition rate at **39%**
* Critical exit window: Employees with **1–2 years of tenure account for 86 of 237 total exits**, indicating a major early retention gap
* Laboratory Technicians with low satisfaction account for **28 of 62 departures** in their role
* Employees in lower salary grades (Grade A) experience significantly higher attrition (**28.6%**) compared to higher-paid employees in Grade D (**8.9%**), suggesting compensation as a key driver of turnover

---

## Key Insights

Attrition is primarily driven by early tenure, younger employees, and low job satisfaction.
Employees with frequent business travel and lower salary grades show a higher risk of leaving.

These patterns suggest issues in onboarding, work-life balance, and compensation structure.

---

## Business Impact

This analysis helps HR teams to:

* Identify high-risk employee groups
* Improve retention strategies
* Optimize onboarding and engagement programs

---

## Tools Used

| Tool             | Purpose                                  |
| ---------------- | ---------------------------------------- |
| MySQL Workbench  | Data exploration, cleaning, aggregations |
| Microsoft Excel  | Data validation, calculated columns      |
| Power BI Desktop | Data modeling, DAX measures, dashboard   |

---

## Dashboard Preview



---

## Project Structure

```
hr-attrition-analysis/
├── 01_SQL/          → SQL queries
├── 02_Excel/        → Clean dataset
├── 03_PowerBI/      → Dashboard file
├── 04_Screenshots/  → Dashboard image
└── README.md
```

---

## SQL Analysis Includes

* Headcount and gender breakdown by department
* Salary analysis (min, avg, max, total mass) by role
* Attrition rate by department
* Age group distribution
* Job satisfaction vs attrition correlation
* Tenure-based attrition analysis
* Feature engineering (age group, salary grade, tenure brackets)

---

## DAX Measures Created

* `Total Employees` — COUNT of all employee records
* `Active Employees` — Employees with Attrition = "No"
* `Attrition Count` — Employees with Attrition = "Yes"
* `Attrition Rate` — Exits / Total Employees
* `Avg Monthly Income` — Average salary
* `Average Age` — Mean employee age

---

## Dataset

**Source:** IBM HR Analytics Employee Attrition Dataset
**Available on:** https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset
**Size:** 1,470 employees × 35 variables

---

*Project completed: April 2026*
*Author: Oumaima Mahboub*

