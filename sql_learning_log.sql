-- Retrieve first name, last name, city, and state by joining Person and Address tables
-- Retrieve first name, last name, city, and state by joining Person and Address tables
SELECT firstName, lastName, city, state
FROM Person
LEFT JOIN Address 
ON Person.personID = Address.personID;

-- Find employees whose salary is greater than their manager's salary
SELECT E1.NAME AS EMPLOYEE 
FROM EMPLOYEE E1 
LEFT JOIN EMPLOYEE E2 
ON E1.MANAGERID = E2.ID 
WHERE E1.SALARY > E2.SALARY;

-- Retrieve duplicate email addresses from the Person table
SELECT email 
FROM (
    SELECT id, email, ROW_NUMBER() OVER (PARTITION BY email) as row_num
    FROM Person 
) T1 
WHERE T1.row_num = 2;

-- Find customers who have not placed any orders
SELECT SB.name as Customers 
FROM (
    SELECT C.name, O.customerId 
    FROM Customers C 
    LEFT JOIN Orders O 
    ON C.id = O.customerId
) SB 
WHERE SB.customerId IS NULL;

-- Delete duplicate records from the Person table, keeping only the one with the smallest ID
DELETE FROM PERSON 
WHERE ID NOT IN (
    SELECT MIN(ID) 
    FROM PERSON 
    GROUP BY EMAIL
);

-- Delete duplicate records from the Person table using a self-join
DELETE P1 
FROM PERSON P1, PERSON P2
WHERE P1.Email = P2.Email 
AND P1.Id > P2.Id;

-- Find weather records where the temperature is higher than the previous day's temperature
SELECT w1.Id
FROM Weather w1, Weather w2
WHERE dateDiff(w1.recordDate, w2.recordDate) = 1 
AND w1.Temperature > w2.Temperature;

-- Find the first login date for each player
SELECT player_id, MIN(event_date) AS first_login
FROM activity
GROUP BY player_id
ORDER BY first_login ASC;

-- Retrieve employees with no bonus or a bonus less than 1000
SELECT E.name, B.bonus 
FROM Employee E 
LEFT JOIN Bonus B 
ON E.empId = B.empId 
WHERE (bonus IS NULL OR bonus < 1000);

-- Retrieve customers who placed the highest number of orders
SELECT SBQ.customer_number 
FROM (
    SELECT customer_number, COUNT(order_number) AS count 
    FROM Orders 
    GROUP BY customer_number 
    ORDER BY count DESC
) SBQ 
HAVING MAX(SBQ.count);

-- Retrieve customer names where the referee ID is null or not equal to 2
SELECT name 
FROM Customer 
WHERE (referee_id IS NULL OR referee_id != 2);

-- Retrieve countries with an area greater than or equal to 3,000,000 or a population greater than or equal to 25,000,000
SELECT name, population, area 
FROM World 
WHERE (area >= 3000000 OR population >= 25000000);

-- Retrieve classes with at least 5 students
SELECT class 
FROM Courses 
GROUP BY class 
HAVING COUNT(student) >= 5;

-- Retrieve salesperson names who have not worked with companies named "RED"
SELECT name 
FROM SalesPerson 
WHERE name NOT IN (
    SELECT SBQ.SP_name 
    FROM (
        SELECT SP.name AS SP_name, C.name AS C_name
        FROM SalesPerson SP 
        LEFT JOIN Orders O ON SP.sales_id = O.sales_id 
        LEFT JOIN Company C ON C.com_id = O.com_id 
    ) SBQ 
    WHERE SBQ.C_name LIKE "RED"
);

-- Determine if three sides form a triangle
SELECT 
  x, y, z,
  CASE 
    WHEN ((x + y > z) AND (y + z > x) AND (z + x > y)) THEN "Yes"
    ELSE "No"
  END AS triangle
FROM Triangle;

-- Retrieve the maximum unique number from MyNumbers
SELECT MAX(num) AS num 
FROM MyNumbers 
WHERE num NOT IN (
    SELECT num 
    FROM (
        SELECT num, 
        ROW_NUMBER() OVER (PARTITION BY num ORDER BY num) AS rn
        FROM MyNumbers
    ) AS SBQ
    WHERE SBQ.rn = 2
);

-- Retrieve non-boring movies with odd IDs, sorted by rating in descending order
SELECT * 
FROM Cinema 
WHERE id % 2 != 0 AND description NOT LIKE "%boring%" 
ORDER BY rating DESC;

-- Swap the values of the "sex" column in the salary table
UPDATE salary
SET sex =
  CASE 
    WHEN sex = "f" THEN "m"
    ELSE "f"
  END;

-- Find actor-director pairs with at least 3 collaborations
Select Actor_id, director_id
from ActorDirector
group by Actor_id, director_id
having count(*) >=3

-- Get product name, year, and price for each sale
select P.product_name, S.year, S.price from Sales S JOIN Product P ON P.product_id=S.product_id group by sale_id,year

-- Get products sold only between 2019-01-01 and 2019-03-31
Select p.product_id, p.product_name
from Product p join Sales s
on p.product_id = s.product_id
group by s.product_id
having min(s.sale_date) >= '2019-01-01' and max(sale_date) <= '2019-03-31'

-- Count daily active users (excluding end_session/open_session) in a date range
select activity_Date as day, count(distinct(user_id)) as active_users from Activity where (activity_type not like "end_session" or activity_type not like "open_session") and activity_date between '2019-06-28' and '2019-07-27' group by activity_Date

-- Find authors who viewed their own articles
select distinct(author_id) as id from Views where author_id=viewer_id group by article_id order by author_id 

-- Pivot monthly revenue by department id
SELECT id,
SUM(IF(month='Jan', revenue, NULL)) AS Jan_Revenue,
SUM(IF(month='Feb', revenue, NULL)) AS Feb_Revenue,
SUM(IF(month='Mar', revenue, NULL)) AS Mar_Revenue,
SUM(IF(month='Apr', revenue, NULL)) AS Apr_Revenue,
SUM(IF(month='May', revenue, NULL)) AS May_Revenue,
SUM(IF(month='Jun', revenue, NULL)) AS Jun_Revenue,
SUM(IF(month='Jul', revenue, NULL)) AS Jul_Revenue,
SUM(IF(month='Aug', revenue, NULL)) AS Aug_Revenue,
SUM(IF(month='Sep', revenue, NULL)) AS Sep_Revenue,
SUM(IF(month='Oct', revenue, NULL)) AS Oct_Revenue,
SUM(IF(month='Nov', revenue, NULL)) AS Nov_Revenue,
SUM(IF(month='Dec', revenue, NULL)) AS Dec_Revenue
FROM Department
Group BY id;

-- Query quality and poor query percentage by query name
select query_name, round(avg(rating/position),2) as quality, round(100*sum(rating < 3)/count(query_name),2) as poor_query_percentage
from Queries
group by query_name order by query_name

-- Calculate average price per product based on units sold and price periods
SELECT 
    p.product_id,
    ROUND(
        IFNULL(SUM(p.price * u.units) * 1.0 / NULLIF(SUM(u.units), 0), 0),
        2
    ) AS average_price
FROM 
    Prices p
    LEFT JOIN UnitsSold u 
        ON p.product_id = u.product_id
        AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY 
    p.product_id;

-- Count attended exams per student and subject
select ST.student_id, ST.student_name, SU.subject_name, count(E.student_id) as attended_exams
from Students ST JOIN Examinations E 
ON ST.student_id=E.student_id 
JOIN Subjects SU ON SU.subject_name=E.subject_name group by E.student_id,E.subject_name order by student_id

-- List all students and subjects with attended exam count (including zero)
with crossJoin as (
select student_id, student_name, subject_name  from students, subjects
)
select  c.student_id, student_name, c.subject_name , ifnull(count(e.subject_name ),0) as attended_exams  from 
crossJoin c 
left join 
Examinations e
on 
c.student_id = e.student_id 
and 
c.subject_name = e.subject_name
group by c.student_id, student_name, c.subject_name
order by c.student_id, c.subject_name

-- Get products with over 99 units sold in Feb 2020
select product_name, sum(unit) as unit from Products P JOIN Orders O ON P.product_id=O.product_id where (order_date between '2020-02-01' and '2020-02-29') group by O.product_id having sum(O.unit)>99 

-- Get employee unique ids and names (right join)
select unique_id, name from EmployeeUNI EU RIGHT JOIN Employees E ON E.id=EU.id

-- Get user names and total travelled distance, sorted by distance and name
select name, ifnull(sum(distance),0) as travelled_distance  from Users U LEFT JOIN Rides R
ON U.id=R.user_id
group by R.user_id
order by travelled_distance desc, name asc

-- List products sold per day with count and product names
SELECT sell_date, COUNT(distinct product) AS num_sold,
GROUP_CONCAT(distinct product ORDER BY product) AS products
FROM Activities
GROUP BY sell_date;

-- Get users with valid leetcode.com emails
SELECT user_id, name, mail
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$'
and mail like '%@leetcode.com'

-- Get patients with DIAB1 in their conditions
select patient_id, patient_name, conditions from Patients
where conditions like "% DIAB1%" or conditions like "DIAB1%"

-- Get user names and balances over 10,000
select U.name, sum(T.amount) as balance from Users U JOIN Transactions T
ON U.account=T.account
group by U.account
having (sum(T.amount)) > 10000

-- Get contest registration percentage per contest
select R.contest_id, 
round(100*(count(*))/(SELECT COUNT(DISTINCT user_id) FROM Users),2) as percentage
from Users U JOIN Register R
ON R.user_id=U.user_id
group by R.contest_id
order by percentage desc, contest_id asc

-- Get average processing time per machine
select machine_id, round(sum(SBQ.end_time-SBQ.start_time)/count(SBQ.process_id),3) as processing_time
from (
select A.machine_id, A.timestamp as start_time, B.timestamp as end_time, A.process_id from Activity A JOIN Activity B ON A.machine_id=B.machine_id and A.process_id=B.process_id and A.activity_type = "start" and B.activity_type = "end" order by A.machine_id, A.process_id, A.timestamp
) SBQ
group by SBQ.machine_id

-- Capitalize first letter of user names
SELECT user_id, CONCAT(
    UPPER(SUBSTRING(name, 1, 1)), 
    LOWER(SUBSTRING(name, 2))
) AS name
FROM Users
order by user_id;

-- Get tweet IDs with content longer than 15 characters
select tweet_id from Tweets
where length(content)>15

-- Get unique leads and partners per day and make
select date_id, make_name, count(distinct(lead_id)) as unique_leads, count(distinct(partner_id)) as unique_partners
from DailySales group by date_id, make_name

-- Get follower count per user
select user_id, count(follower_id) as followers_count from Followers
group by user_id order by user_id

-- Get report count and average age for each employee's reports
select A.employee_id, A.name, count(B.name) as reports_count, round(avg(B.age)) as average_age 
from Employees A, Employees B 
where A.employee_id=B.reports_to
group by A.employee_id 
order by A.employee_id

-- Get total work time per employee per day
select event_day as day, emp_id, sum(out_time-in_time) as total_time from Employees group by event_day, emp_id order by total_time, event_day,emp_id

-- Get product IDs that are low fat and recyclable
select product_id from Products where low_fats='Y' and recyclable='Y'

-- Get employees with primary department or only one department
(select employee_id, department_id from employee where primary_flag="Y")
UNION
(select employee_id, department_id from employee group by employee_id having count(department_id)=1 )

-- Unpivot product prices by store
select * from
(
select product_id, "store1" as store, store1 as price from Products
union 
select product_id, "store2" as store, store2 as price from Products
union 
select product_id, "store3" as store, store3 as price from Products
) SBQ
where SBQ.price is not null
order by SBQ.product_id

-- Get employee bonus if odd ID and name doesn't start with 'M'
select employee_id, case
when
employee_id%2!=0 and name not like "M%" then salary
else
0
end as bonus
from Employees
order by employee_id

-- Get last login timestamp in 2020 per user
select user_id, max(time_stamp) as last_stamp
from Logins
where time_stamp like "%2020%"
group by user_id

-- Get account count by salary category
select * from (
select "Low Salary" as category, count(account_id) as accounts_count from Accounts where income<20000
union
select "Average Salary" as category, count(account_id) as accounts_count from Accounts where income>=20000 and income<=50000
union
select "High Salary" as category, count(account_id) as accounts_count from Accounts where income>50000
) SBQ
order by SBQ.accounts_count desc

-- Get confirmation rate per user
SELECT s.user_id, round(IFNULL(sum(case when action = 'confirmed' then 1 else null end)* 1.0 /
count(action), 0),2) as confirmation_rate
from Signups s
left join Confirmations C
on s.user_id = C.user_id
group by s.user_id
order by confirmation_rate