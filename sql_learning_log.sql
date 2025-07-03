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