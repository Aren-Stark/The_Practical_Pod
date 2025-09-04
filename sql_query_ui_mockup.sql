-- This file contains mock input data and example output for each query in sql_learning_log.sql
-- Use this for UI/testing/documentation purposes

-- Example 1: Retrieve first name, last name, city, and state by joining Person and Address tables
-- Input:
-- Person: | personID | firstName | lastName |
--         | 1        | John      | Doe      |
--         | 2        | Jane      | Smith    |
-- Address:| personID | city        | state |
--         | 1        | New York    | NY    |
--         | 2        | Los Angeles | CA    |
CREATE TABLE Person (personID INT, firstName VARCHAR(50), lastName VARCHAR(50));
CREATE TABLE Address (personID INT, city VARCHAR(50), state VARCHAR(50));
INSERT INTO Person VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO Address VALUES (1, 'New York', 'NY'), (2, 'Los Angeles', 'CA');
-- Output:
-- | firstName | lastName | city      | state |
-- | John      | Doe      | New York  | NY    |
-- | Jane      | Smith    | Los Angeles | CA  |

-- Example 2: Find employees whose salary is greater than their manager's salary
-- Input:
-- Employee: | ID | NAME  | SALARY | MANAGERID |
--           | 1  | Alice | 90000  | NULL      |
--           | 2  | Bob   | 80000  | 1         |
--           | 3  | Carol | 95000  | 1         |
CREATE TABLE Employee (ID INT, NAME VARCHAR(50), SALARY INT, MANAGERID INT);
INSERT INTO Employee VALUES (1, 'Alice', 90000, NULL), (2, 'Bob', 80000, 1), (3, 'Carol', 95000, 1);
-- Output:
-- | EMPLOYEE |
-- | Carol    |

-- Example 3: Retrieve duplicate email addresses from the Person table
-- Input:
-- PersonEmail: | id | email    |
--              | 1  | a@b.com  |
--              | 2  | a@b.com  |
--              | 3  | c@d.com  |
CREATE TABLE PersonEmail (id INT, email VARCHAR(50));
INSERT INTO PersonEmail VALUES (1, 'a@b.com'), (2, 'a@b.com'), (3, 'c@d.com');
-- Output:
-- | email    |
-- | a@b.com  |

-- Example 4: Find customers who have not placed any orders
-- Input:
-- Customers: | id | name |
--            | 1  | Sam  |
--            | 2  | Max  |
-- Orders:    | orderId | customerId |
--            | 1       | 1          |
CREATE TABLE Customers (id INT, name VARCHAR(50));
CREATE TABLE Orders (orderId INT, customerId INT);
INSERT INTO Customers VALUES (1, 'Sam'), (2, 'Max');
INSERT INTO Orders VALUES (1, 1);
-- Output:
-- | Customers |
-- | Max       |

-- Example 5: Delete duplicate records from the Person table, keeping only the one with the smallest ID
-- Input:
-- PersonEmail: | id | email    |
--              | 1  | a@b.com  |
--              | 2  | a@b.com  |
--              | 3  | c@d.com  |
-- Output: Only one row per email remains

-- Example 6: Find weather records where the temperature is higher than the previous day's temperature
-- Input:
-- Weather: | Id | recordDate  | Temperature |
--          | 1  | 2025-09-01  | 70          |
--          | 2  | 2025-09-02  | 75          |
CREATE TABLE Weather (Id INT, recordDate DATE, Temperature INT);
INSERT INTO Weather VALUES (1, '2025-09-01', 70), (2, '2025-09-02', 75);
-- Output:
-- | Id |
-- | 2  |

-- Example 7: Find the first login date for each player
-- Input:
-- Activity: | player_id | event_date  |
--           | 1         | 2025-09-01  |
--           | 1         | 2025-09-03  |
--           | 2         | 2025-09-02  |
CREATE TABLE Activity (player_id INT, event_date DATE);
INSERT INTO Activity VALUES (1, '2025-09-01'), (1, '2025-09-03'), (2, '2025-09-02');
-- Output:
-- | player_id | first_login |
-- | 1         | 2025-09-01  |
-- | 2         | 2025-09-02  |

-- Example 8: Retrieve employees with no bonus or a bonus less than 1000
-- Input:
-- Employee: | ID | NAME  | SALARY | MANAGERID |
--           | 1  | Alice | 90000  | NULL      |
--           | 2  | Bob   | 80000  | 1         |
-- Bonus:    | empId | bonus |
--           | 1     | NULL  |
--           | 2     | 500   |
CREATE TABLE Bonus (empId INT, bonus INT);
INSERT INTO Bonus VALUES (1, NULL), (2, 500);
-- Output:
-- | name | bonus |
-- | Alice| NULL  |
-- | Bob  | 500   |

-- Example 9: Retrieve customers who placed the highest number of orders
-- Input:
-- Orders: | order_number | customer_number |
--         | 1            | 101             |
--         | 2            | 101             |
--         | 3            | 102             |
--         | 4            | 103             |
--         | 5            | 101             |
-- Output:
-- | customer_number |
-- | 101             |

-- Example 10: Retrieve customer names where the referee ID is null or not equal to 2
-- Input:
-- Customer: | id | name | referee_id |
--           | 1  | Sam  | NULL       |
--           | 2  | Max  | 3          |
--           | 3  | Amy  | 2          |
-- Output:
-- | name |
-- | Sam  |
-- | Max  |

-- Example 11: Retrieve countries with an area >= 3,000,000 or population >= 25,000,000
-- Input:
-- World: | name      | population | area     |
--        | CountryA  | 10000000   | 4000000  |
--        | CountryB  | 30000000   | 2000000  |
--        | CountryC  | 5000000    | 1000000  |
-- Output:
-- | name     | population | area    |
-- | CountryA | 10000000   | 4000000 |
-- | CountryB | 30000000   | 2000000 |

-- Example 12: Retrieve classes with at least 5 students
-- Input:
-- Courses: | class | student |
--          | 1     | A       |
--          | 1     | B       |
--          | 1     | C       |
--          | 1     | D       |
--          | 1     | E       |
--          | 2     | F       |
-- Output:
-- | class |
-- | 1     |

-- Example 13: Retrieve salesperson names who have not worked with companies named "RED"
-- Input:
-- SalesPerson: | sales_id | name |
--              | 1        | John |
--              | 2        | Jane |
-- Company:     | com_id | name |
--              | 1      | RED  |
--              | 2      | BLUE |
-- Orders:      | sales_id | com_id |
--              | 1        | 1     |
--              | 2        | 2     |
-- Output:
-- | name |
-- | Jane |

-- Example 14: Determine if three sides form a triangle
-- Input:
-- Triangle: | x | y | z |
--           | 3 | 4 | 5 |
--           | 1 | 2 | 3 |
-- Output:
-- | x | y | z | triangle |
-- | 3 | 4 | 5 | Yes      |
-- | 1 | 2 | 3 | No       |

-- Example 15: Retrieve the maximum unique number from MyNumbers
-- Input:
-- MyNumbers: | num |
--            | 1   |
--            | 2   |
--            | 2   |
--            | 3   |
-- Output:
-- | num |
-- | 3   |

-- Example 16: Retrieve non-boring movies with odd IDs, sorted by rating desc
-- Input:
-- Cinema: | id | description | rating |
--         | 1  | fun movie   | 8      |
--         | 2  | boring film | 5      |
--         | 3  | action      | 9      |
-- Output:
-- | id | description | rating |
-- | 3  | action      | 9      |
-- | 1  | fun movie   | 8      |

-- Example 17: Swap the values of the "sex" column in the salary table
-- Input:
-- salary: | id | sex |
--         | 1  | f   |
--         | 2  | m   |
-- Output:
-- | id | sex |
-- | 1  | m   |
-- | 2  | f   |

-- Example 18: Find actor-director pairs with at least 3 collaborations
-- Input:
-- ActorDirector: | Actor_id | director_id |
--                | 1        | 2           |
--                | 1        | 2           |
--                | 1        | 2           |
--                | 2        | 3           |
-- Output:
-- | Actor_id | director_id |
-- | 1        | 2           |

-- Example 19: Get product name, year, and price for each sale
-- Input:
-- Product: | product_id | product_name |
--          | 1          | Widget       |
-- Sales:   | sale_id | product_id | year | price |
--          | 1      | 1          | 2020 | 10    |
-- Output:
-- | product_name | year | price |
-- | Widget       | 2020 | 10    |

-- Example 20: Get products sold only between 2019-01-01 and 2019-03-31
-- Input:
-- Product: | product_id | product_name |
--          | 1          | Widget       |
-- Sales:   | sale_id | product_id | sale_date |
--          | 1      | 1          | 2019-01-15 |
-- Output:
-- | product_id | product_name |
-- | 1          | Widget       |

-- Example 21: Count daily active users (excluding end_session/open_session) in a date range
-- Input:
-- Activity: | activity_Date | user_id | activity_type |
--           | 2019-06-28    | 1       | click         |
--           | 2019-06-28    | 2       | open_session  |
-- Output:
-- | day        | active_users |
-- | 2019-06-28 | 1            |

-- Example 22: Find authors who viewed their own articles
-- Input:
-- Views: | article_id | author_id | viewer_id |
--        | 1          | 1         | 1         |
--        | 2          | 2         | 2         |
-- Output:
-- | id |
-- | 1  |
-- | 2  |

-- Example 23: Pivot monthly revenue by department id
-- Input:
-- Department: | id | month | revenue |
--             | 1  | Jan   | 100    |
--             | 1  | Feb   | 200    |
-- Output:
-- | id | Jan_Revenue | Feb_Revenue |
-- | 1  | 100         | 200         |

-- Example 24: Query quality and poor query percentage by query name
-- Input:
-- Queries: | query_name | rating | position |
--          | Q1         | 4      | 1       |
--          | Q1         | 2      | 2       |
-- Output:
-- | query_name | quality | poor_query_percentage |
-- | Q1         | 3.00    | 50.00                |

-- Example 25: Calculate average price per product based on units sold and price periods
-- Input:
-- Prices: | product_id | price | start_date | end_date |
--         | 1          | 10    | 2025-09-01 | 2025-09-30 |
-- UnitsSold: | product_id | units | purchase_date |
--            | 1          | 2     | 2025-09-15    |
-- Output:
-- | product_id | average_price |
-- | 1          | 10.00         |

-- Example 26: Count attended exams per student and subject
-- Input:
-- Students: | student_id | student_name |
--           | 1          | Alice        |
-- Subjects: | subject_name |
--           | Math         |
-- Examinations: | student_id | subject_name |
--               | 1          | Math         |
-- Output:
-- | student_id | student_name | subject_name | attended_exams |
-- | 1          | Alice        | Math         | 1              |

-- Example 27: List all students and subjects with attended exam count (including zero)
-- Input:
-- Students: | student_id | student_name |
--           | 1          | Alice        |
-- Subjects: | subject_name |
--           | Math         |
-- Examinations: | student_id | subject_name |
--               | 1          | Math         |
-- Output:
-- | student_id | student_name | subject_name | attended_exams |
-- | 1          | Alice        | Math         | 1              |

-- Example 28: Get products with over 99 units sold in Feb 2020
-- Input:
-- Products: | product_id | product_name |
--           | 1          | Widget       |
-- Orders:   | order_id | product_id | order_date | unit |
--           | 1       | 1          | 2020-02-10 | 100  |
-- Output:
-- | product_name | unit |
-- | Widget       | 100  |

-- Example 29: Get employee unique ids and names (right join)
-- Input:
-- EmployeeUNI: | id | unique_id |
--              | 1  | U1        |
-- Employees:   | id | name      |
--              | 1  | Alice     |
-- Output:
-- | unique_id | name  |
-- | U1        | Alice |

-- Example 30: Get user names and total travelled distance, sorted by distance and name
-- Input:
-- Users: | id | name |
--        | 1  | Alice|
-- Rides: | user_id | distance |
--        | 1       | 50       |
-- Output:
-- | name  | travelled_distance |
-- | Alice | 50                 |

-- Example 31: List products sold per day with count and product names
-- Input:
-- Activities: | sell_date | product |
--             | 2025-09-01 | Widget  |
--             | 2025-09-01 | Gadget  |
-- Output:
-- | sell_date   | num_sold | products        |
-- | 2025-09-01  | 2        | Gadget,Widget   |

-- Example 32: Get users with valid leetcode.com emails
-- Input:
-- Users: | user_id | name | mail              |
--        | 1       | John | john@leetcode.com |
--        | 2       | Jane | jane@gmail.com    |
-- Output:
-- | user_id | name | mail              |
-- | 1       | John | john@leetcode.com |

-- Example 33: Get patients with DIAB1 in their conditions
-- Input:
-- Patients: | patient_id | patient_name | conditions |
--           | 1          | Alice        | DIAB1      |
--           | 2          | Bob          | FLU        |
-- Output:
-- | patient_id | patient_name | conditions |
-- | 1          | Alice        | DIAB1      |

-- Example 34: Get user names and balances over 10,000
-- Input:
-- Users: | account | name |
--        | 1       | John |
-- Transactions: | account | amount |
--               | 1       | 15000  |
-- Output:
-- | name | balance |
-- | John | 15000   |

-- Example 35: Get contest registration percentage per contest
-- Input:
-- Users: | user_id |
--        | 1       |
--        | 2       |
-- Register: | contest_id | user_id |
--           | 1          | 1       |
-- Output:
-- | contest_id | percentage |
-- | 1          | 50.00      |

-- Example 36: Get average processing time per machine
-- Input:
-- Activity: | machine_id | process_id | activity_type | timestamp |
--           | 1          | 1          | start         | 10        |
--           | 1          | 1          | end           | 20        |
-- Output:
-- | machine_id | processing_time |
-- | 1          | 10.000          |

-- Example 37: Capitalize first letter of user names
-- Input:
-- Users: | user_id | name |
--        | 1       | john |
-- Output:
-- | user_id | name |
-- | 1       | John |

-- Example 38: Get tweet IDs with content longer than 15 characters
-- Input:
-- Tweets: | tweet_id | content           |
--         | 1        | short             |
--         | 2        | this is long text |
-- Output:
-- | tweet_id |
-- | 2        |

-- Example 39: Get unique leads and partners per day and make
-- Input:
-- DailySales: | date_id | make_name | lead_id | partner_id |
--             | 2025-09-01 | Ford     | 1      | 2         |
-- Output:
-- | date_id    | make_name | unique_leads | unique_partners |
-- | 2025-09-01 | Ford      | 1            | 1               |

-- Example 40: Get follower count per user
-- Input:
-- Followers: | user_id | follower_id |
--            | 1       | 2           |
--            | 1       | 3           |
-- Output:
-- | user_id | followers_count |
-- | 1       | 2               |

-- Example 41: Get report count and average age for each employee's reports
-- Input:
-- Employees: | employee_id | name | age | reports_to |
--            | 1           | John | 40  | NULL       |
--            | 2           | Jane | 30  | 1          |
-- Output:
-- | employee_id | name | reports_count | average_age |
-- | 1           | John | 1             | 30          |

-- Example 42: Get total work time per employee per day
-- Input:
-- Employees: | event_day | emp_id | in_time | out_time |
--            | 2025-09-01 | 1     | 9       | 17       |
-- Output:
-- | day        | emp_id | total_time |
-- | 2025-09-01 | 1     | 8          |

-- Example 43: Get product IDs that are low fat and recyclable
-- Input:
-- Products: | product_id | low_fats | recyclable |
--           | 1          | Y        | Y          |
--           | 2          | N        | Y          |
-- Output:
-- | product_id |
-- | 1          |

-- Example 44: Get employees with primary department or only one department
-- Input:
-- Employee: | employee_id | department_id | primary_flag |
--           | 1           | 10            | Y            |
--           | 2           | 20            | N            |
-- Output:
-- | employee_id | department_id |
-- | 1           | 10            |

-- Example 45: Unpivot product prices by store
-- Input:
-- Products: | product_id | store1 | store2 | store3 |
--           | 1          | 10     | NULL   | 12     |
-- Output:
-- | product_id | store  | price |
-- | 1          | store1 | 10    |
-- | 1          | store3 | 12    |

-- Example 46: Get employee bonus if odd ID and name doesn't start with 'M'
-- Input:
-- Employees: | employee_id | name | salary |
--            | 1           | John | 1000   |
--            | 2           | Mike | 2000   |
-- Output:
-- | employee_id | bonus |
-- | 1           | 1000  |
-- | 2           | 0     |

-- Example 47: Get last login timestamp in 2020 per user
-- Input:
-- Logins: | user_id | time_stamp |
--         | 1       | 2020-01-01 |
--         | 1       | 2020-02-01 |
-- Output:
-- | user_id | last_stamp |
-- | 1       | 2020-02-01 |

-- Example 48: Get account count by salary category
-- Input:
-- Accounts: | account_id | income |
--           | 1          | 15000  |
--           | 2          | 25000  |
--           | 3          | 60000  |
-- Output:
-- | category       | accounts_count |
-- | Low Salary     | 1              |
-- | Average Salary | 1              |
-- | High Salary    | 1              |

-- Example 49: Get confirmation rate per user
-- Input:
-- Signups: | user_id | action      |
--          | 1       | confirmed   |
--          | 1       | unconfirmed |
-- Output:
-- | user_id | confirmation_rate |
-- | 1       | 0.50              |

-- Example 50: Retrieves a list of active users who have logged in within the last 30 days
-- Input:
-- employees: | employee_id |
--            | 1          |
-- salaries:  | employee_id |
--            | 2          |
-- Output:
-- | employee_id |
-- | 1           |
-- | 2           |

-- Example 51: Finds employees with salary < 30,000 whose manager_id is not null and does not exist in Employees table
-- Input:
-- Employees: | employee_id | salary | manager_id |
--            | 1           | 25000  | 2          |
-- Output:
-- | employee_id |
-- | 1           |

-- Example 52: Counts the number of distinct subjects each teacher teaches
-- Input:
-- Teacher: | teacher_id | subject_id |
--          | 1          | Math       |
--          | 1          | Science    |
-- Output:
-- | teacher_id | cnt |
-- | 1          | 2   |

-- Example 53: Counts customers who visited but did not make any transactions
-- Input:
-- Visits: | visit_id | customer_id |
--         | 1        | 1           |
-- Transactions: | visit_id |
--               | 2        |
-- Output:
-- | customer_id | count_no_trans |
-- | 1           | 1              |

-- Continue this pattern for all queries in sql_learning_log.sql for UI/testing/documentation purposes.
