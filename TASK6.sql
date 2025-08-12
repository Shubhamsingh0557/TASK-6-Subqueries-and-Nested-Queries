1. Create Customers Table:

    CREATE TABLE Customers (
        CustomerID INT PRIMARY KEY,
        Name TEXT,
        City TEXT
    );

-- Insert Sample Data:


    INSERT INTO Customers (CustomerID,Name,City)VALUES(1, 'Alice', 'New York');
    INSERT INTO Customers (CustomerID,Name,City)VALUES(2, 'Bob', 'Los Angeles');
    INSERT INTO Customers (CustomerID,Name,City)VALUES(3, 'Charlie', 'Chicago');

2. Subquery in SELECT (Scalar Subquery):

--Show each customer's name along with the total number of customers.
    SELECT 
        Name,
        (SELECT COUNT(*) FROM Customers) AS TotalCustomers
    FROM Customers;

--Scalar subquery returns a single value (total count) for each row.

3. Subquery in WHERE using IN:

--Find customers who live in cities that match a subquery result.
    SELECT Name 
    FROM Customers 
    WHERE City IN (
        SELECT City FROM Customers WHERE City LIKE '%o%'
    );

--Returns customers from cities containing the letter "o".

4. Subquery in WHERE using EXISTS:

--Check if a customer exists in a specific city.
    SELECT Name 
    FROM Customers c 
    WHERE EXISTS (
        SELECT 1 FROM Customers 
        WHERE City = 'Chicago' AND c.City = City
    );

--Returns customers who live in Chicago (if any exist).

5. Subquery in WHERE using = (Scalar Subquery):

--Find the customer from the city that comes first alphabetically.
    SELECT Name 
    FROM Customers 
    WHERE City = (
        SELECT MIN(City) FROM Customers
    );

--Returns the customer from the alphabetically first city.

6. Subquery in FROM (Derived Table):

--List all customers and join with a subquery that counts customers per city.
    SELECT c.Name, c.City, city_count.TotalInCity
    FROM Customers c
    JOIN (
        SELECT City, COUNT(*) AS TotalInCity
        FROM Customers
        GROUP BY City
    ) AS city_count
    ON c.City = city_count.City;

--Shows each customer with the number of customers in their city.

7. Correlated Subquery in WHERE:

--Find customers who live in cities with more than one customer.
    SELECT Name, City 
    FROM Customers c1
    WHERE (
        SELECT COUNT(*) 
        FROM Customers c2 
        WHERE c2.City = c1.City
    ) > 1;

--Returns customers from cities with multiple entries (if any).
