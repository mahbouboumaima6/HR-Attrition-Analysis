-- =========================================
-- HR ATTRITION ANALYSIS PROJECT
-- Author: Oumaima Mahboub
-- Description: SQL queries for HR analytics dashboard
-- =========================================

USE attrition_data;

-- =========================================
-- 1. DATA EXPLORATION
-- =========================================

SELECT COUNT(*) AS headcount 
FROM attrition_data;

SELECT * 
FROM attrition_data 
LIMIT 5;

SELECT DISTINCT Department 
FROM attrition_data;

SELECT DISTINCT JobRole 
FROM attrition_data 
ORDER BY JobRole;

-- =========================================
-- 2. MASTER DATASET (FEATURE ENGINEERING)
-- =========================================

SELECT
  EmployeeNumber,
  Age,
  Gender,
  MaritalStatus,
  Department,
  JobRole,
  JobLevel,
  Education,
  EducationField,
  BusinessTravel,
  MonthlyIncome,
  PercentSalaryHike,
  StockOptionLevel,
  YearsAtCompany,
  YearsInCurrentRole,
  YearsSinceLastPromotion,
  YearsWithCurrManager,
  TotalWorkingYears,
  NumCompaniesWorked,
  JobSatisfaction,
  EnvironmentSatisfaction,
  RelationshipSatisfaction,
  WorkLifeBalance,
  JobInvolvement,
  PerformanceRating,
  TrainingTimesLastYear,
  OverTime,
  DistanceFromHome,
  Attrition,

  -- Age Groups
  CASE
    WHEN Age < 25 THEN 'Under 25'
    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
    WHEN Age BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
  END AS age_group,

  -- Salary Grades
  CASE
    WHEN MonthlyIncome < 3000 THEN 'Grade A'
    WHEN MonthlyIncome < 6000 THEN 'Grade B'
    WHEN MonthlyIncome < 10000 THEN 'Grade C'
    ELSE 'Grade D'
  END AS salary_grade,

  -- Tenure Brackets
  CASE
    WHEN YearsAtCompany = 0 THEN 'Less than 1 year'
    WHEN YearsAtCompany BETWEEN 1 AND 2 THEN '1-2 years'
    WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 years'
    WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 years'
    ELSE 'Over 10 years'
  END AS tenure_bracket,

  -- Satisfaction Levels
  CASE JobSatisfaction
    WHEN 1 THEN 'Low'
    WHEN 2 THEN 'Medium'
    WHEN 3 THEN 'High'
    WHEN 4 THEN 'Very High'
  END AS satisfaction_level,

  -- Work-Life Balance Levels
  CASE WorkLifeBalance
    WHEN 1 THEN 'Bad'
    WHEN 2 THEN 'Good'
    WHEN 3 THEN 'Better'
    WHEN 4 THEN 'Best'
  END AS wlb_level,

  -- Performance Levels
  CASE PerformanceRating
    WHEN 1 THEN 'Low'
    WHEN 2 THEN 'Good'
    WHEN 3 THEN 'Excellent'
    WHEN 4 THEN 'Outstanding'
  END AS performance_level

FROM attrition_data
ORDER BY Department, JobRole, EmployeeNumber;

-- =========================================
-- 3. HEADCOUNT BY DEPARTMENT
-- =========================================

SELECT 
  Department,
  COUNT(*) AS headcount,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM attrition_data),1) AS pct_headcount,
  SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
  SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM attrition_data
GROUP BY Department
ORDER BY headcount DESC;

-- =========================================
-- 4. SALARY ANALYSIS BY ROLE
-- =========================================

SELECT 
  Department,
  JobRole,
  COUNT(*) AS headcount,
  MIN(MonthlyIncome) AS min_salary,
  ROUND(AVG(MonthlyIncome),0) AS avg_salary,
  MAX(MonthlyIncome) AS max_salary,
  SUM(MonthlyIncome) AS salary_mass
FROM attrition_data
GROUP BY Department, JobRole
ORDER BY Department, salary_mass DESC;

-- =========================================
-- 5. ATTRITION BY DEPARTMENT
-- =========================================

SELECT 
  Department,
  COUNT(*) AS headcount,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS exits,
  SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS active_employees,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),1) AS turnover_rate
FROM attrition_data
GROUP BY Department
ORDER BY turnover_rate DESC;

-- =========================================
-- 6. AGE GROUP ANALYSIS
-- =========================================

SELECT 
  CASE 
    WHEN Age < 25 THEN 'Under 25'
    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
    WHEN Age BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
  END AS age_group,
  COUNT(*) AS headcount,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM attrition_data),1) AS percentage
FROM attrition_data
GROUP BY age_group
ORDER BY MIN(Age);

-- =========================================
-- 7. JOB SATISFACTION & ATTRITION
-- =========================================

SELECT 
  JobSatisfaction,
  CASE JobSatisfaction 
    WHEN 1 THEN 'Low' 
    WHEN 2 THEN 'Medium' 
    WHEN 3 THEN 'High' 
    WHEN 4 THEN 'Very High' 
  END AS satisfaction_level,
  COUNT(*) AS headcount,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS exits,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),1) AS turnover_rate_pct
FROM attrition_data
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- =========================================
-- 8. TENURE ANALYSIS
-- =========================================

SELECT 
  CASE 
    WHEN YearsAtCompany = 0 THEN 'Less than 1 year'
    WHEN YearsAtCompany BETWEEN 1 AND 2 THEN '1-2 years'
    WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 years'
    WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 years'
    ELSE 'Over 10 years'
  END AS tenure_bracket,
  COUNT(*) AS headcount,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS exits,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),1) AS turnover_rate_pct
FROM attrition_data
GROUP BY tenure_bracket
ORDER BY MIN(YearsAtCompany);