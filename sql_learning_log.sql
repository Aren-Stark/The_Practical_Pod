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