
CREATE TABLE staff_members (
    staff_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    hire_date DATE,
    role_code VARCHAR2(50),
    salary NUMBER,
    team_id NUMBER
);

-- Insert sample data
INSERT INTO staff_members VALUES (201, 'Alex', 'Ngabo', 'alex.ngabo@example.com', TO_DATE('2021-06-01', 'YYYY-MM-DD'), 'DEV_ENG', 61000, 1);
INSERT INTO staff_members VALUES (202, 'Bella', 'Mugenzi', 'bella.m@example.com', TO_DATE('2020-04-11', 'YYYY-MM-DD'), 'DEV_ENG', 72000, 1);
INSERT INTO staff_members VALUES (203, 'Chris', 'Habimana', 'chris.h@example.com', TO_DATE('2022-09-15', 'YYYY-MM-DD'), 'FIN_ANALYST', 58000, 2);
INSERT INTO staff_members VALUES (204, 'Diana', 'Uwase', 'diana.u@example.com', TO_DATE('2019-01-10', 'YYYY-MM-DD'), 'FIN_ANALYST', 64000, 2);
INSERT INTO staff_members VALUES (205, 'Eric', 'Kamanzi', 'eric.k@example.com', TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'SALES_REP', 47000, 3);
INSERT INTO staff_members VALUES (206, 'Faith', 'Mukamana', 'faith.m@example.com', TO_DATE('2020-10-20', 'YYYY-MM-DD'), 'SALES_REP', 53000, 3);
INSERT INTO staff_members VALUES (207, 'George', 'Twizeyimana', 'george.t@example.com', TO_DATE('2018-08-15', 'YYYY-MM-DD'), 'SALES_REP', 56000, 3);
INSERT INTO staff_members VALUES (208, 'Hannah', 'Niyonsaba', 'hannah.n@example.com', TO_DATE('2021-11-01', 'YYYY-MM-DD'), 'HR_SPECIAL', 60000, 4);
INSERT INTO staff_members VALUES (209, 'Ian', 'Mugisha', 'ian.m@example.com', TO_DATE('2019-07-22', 'YYYY-MM-DD'), 'HR_SPECIAL', 58000, 4);
INSERT INTO staff_members VALUES (210, 'Joy', 'Umutoni', 'joy.u@example.com', TO_DATE('2022-05-10', 'YYYY-MM-DD'), 'DEV_ENG', 70000, 1);

--QUERY 1 – Using LAG() and LEAD()

SELECT 
    staff_id,
    first_name,
    last_name,
    salary,
    team_id,
    LAG(salary) OVER (PARTITION BY team_id ORDER BY hire_date) AS prev_salary,
    LEAD(salary) OVER (PARTITION BY team_id ORDER BY hire_date) AS next_salary,
    CASE 
        WHEN salary > LAG(salary) OVER (PARTITION BY team_id ORDER BY hire_date) THEN 'HIGHER'
        WHEN salary < LAG(salary) OVER (PARTITION BY team_id ORDER BY hire_date) THEN 'LOWER'
        WHEN salary = LAG(salary) OVER (PARTITION BY team_id ORDER BY hire_date) THEN 'EQUAL'
        ELSE 'FIRST RECORD'
    END AS compare_with_previous
FROM staff_members
ORDER BY team_id, hire_date;

--QUERY 2 – RANK() vs DENSE_RANK()

SELECT 
    staff_id,
    first_name,
    last_name,
    salary,
    team_id,
    RANK() OVER (PARTITION BY team_id ORDER BY salary DESC) AS rank_salary,
    DENSE_RANK() OVER (PARTITION BY team_id ORDER BY salary DESC) AS dense_rank_salary
FROM staff_members
ORDER BY team_id, rank_salary;

-- QUERY 3 – Top 3 Salaries per Team

WITH top_staff AS (
    SELECT 
        staff_id,
        first_name,
        last_name,
        salary,
        team_id,
        DENSE_RANK() OVER (PARTITION BY team_id ORDER BY salary DESC) AS rank_salary
    FROM staff_members
)
SELECT *
FROM top_staff
WHERE rank_salary <= 3
ORDER BY team_id, rank_salary;

-- QUERY 4 – Earliest 2 Hires per Team

WITH earliest_staff AS (
    SELECT 
        staff_id,
        first_name,
        last_name,
        hire_date,
        team_id,
        ROW_NUMBER() OVER (PARTITION BY team_id ORDER BY hire_date) AS hire_rank
    FROM staff_members
)
SELECT *
FROM earliest_staff
WHERE hire_rank <= 2
ORDER BY team_id, hire_rank;

-- QUERY 5 – Aggregations with Window Functions

SELECT 
    staff_id,
    first_name,
    last_name,
    salary,
    team_id,
    MAX(salary) OVER (PARTITION BY team_id) AS max_in_team,
    MAX(salary) OVER () AS overall_max,
    salary - MAX(salary) OVER (PARTITION BY team_id) AS diff_team_max,
    salary - MAX(salary) OVER () AS diff_overall_max
FROM staff_members
ORDER BY team_id, salary DESC;
commit;
