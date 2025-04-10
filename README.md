
## Staff Members Analytics Using SQL Window Functions

Welcome to this SQL project that demonstrates the power and flexibility of **window functions** in Oracle SQL. In this walkthrough, we explore real-world business data scenarios by analyzing a fictional company's staff records.

**Project Contributors:**
- **Mutsinzi Brian Heritier 26522**
- **Akize Israel 25883**
- **Lecture: Maniraguha Eric**

---

##Table Structure & Sample Data
We begin by creating a table named `staff_members` with the following attributes:

- `staff_id` (Primary Key)
- `first_name`, `last_name`
- `email`
- `hire_date`
- `role_code` (job title/department)
- `salary`
- `team_id` (used to group staff into teams)

###SQL Script to Create and Populate Table
![create and insert](https://github.com/user-attachments/assets/3f88af70-4ce1-4d00-995b-d53ee7a2ccc0)

##Query 1 – Using `LAG()` and `LEAD()`
**Goal:** Analyze each staff member's salary in comparison to the previous and next employee within the same team (based on hire date).

![using lag and lead](https://github.com/user-attachments/assets/63b25724-0f7c-4521-8b36-b03015df5668)

![using lag and lead table](https://github.com/user-attachments/assets/716fad44-2f1a-4694-8632-a08fadc31537)

We also use a `CASE` statement to label each row as:
- `HIGHER` – if current salary is more than the previous
- `LOWER` – if less
- `EQUAL` – if the same
- `FIRST RECORD` – if no previous record exists

**Use Case:** Track salary progression within teams over time.

---

## Query 2 – `RANK()` vs `DENSE_RANK()`
**Goal:** Rank employees by salary within each team and compare the difference between `RANK()` and `DENSE_RANK()`.

![rank and rank dense](https://github.com/user-attachments/assets/b3a195b6-8b3e-4c84-a167-c7eb36bc23ae)

![rank and dense rank table](https://github.com/user-attachments/assets/70318669-3710-42f7-9cb4-b4c75afba057)

- `RANK()` can skip numbers in case of ties
- `DENSE_RANK()` does not skip numbers

**Use Case:** Fair ranking in bonus distribution and evaluations.

---

## Query 3 – Top 3 Salaries per Team
**Goal:** Identify the top 3 earners in each team.

We use a CTE (`WITH` clause) and `DENSE_RANK()` to extract the top salaries:
![top 3 salaries per team](https://github.com/user-attachments/assets/ac82b3f0-ba01-417f-8e42-56a0417982c4)

![top 3 salaries per team table](https://github.com/user-attachments/assets/55fcdb10-11bc-4401-918c-f0e74c882db1)

**Use Case:** Highlight top performers or allocate leadership roles.

---

## Query 4 – Earliest 2 Hires per Team
**Goal:** Get the first two people hired in each team.

![earliest 2 hires per team](https://github.com/user-attachments/assets/2dc2b65a-1732-4b84-8898-8b866a1caf1c)

![earliest 2 hires per team table](https://github.com/user-attachments/assets/fbfcfc84-8001-4631-bb2b-d5ffea6f9c44)

**Use Case:** Find veterans or potential mentors for new hires.

---

## Query 5 – Aggregations with Window Functions
**Goal:** Perform aggregated salary comparisons both within teams and company-wide.

![aggregation with windows function](https://github.com/user-attachments/assets/e346642b-f200-4954-b89b-e6caf4009668)

![aggregate with windows function table](https://github.com/user-attachments/assets/473b2350-33fa-4077-ba07-721494de4fe0)


We also compute the difference between each individual's salary and their team's or company's max salary.

**Use Case:** Spot pay gaps, plan raises, or identify over/underpaid staff.

---

##Why This Project Matters
This project is a hands-on guide for:
- **Understanding advanced SQL window functions**
- **Performing team-based analysis**
- **Drawing insights from organizational data**

---

