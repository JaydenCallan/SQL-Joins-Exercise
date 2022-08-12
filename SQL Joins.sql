USE bestbuy;

/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */
SELECT products.Name AS ProductName, categories.Name AS CategoryName
FROM Products
INNER JOIN categories ON products.CategoryID=categories.CategoryID;
 
/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT products.Name, products.Price, reviews.Rating
FROM products
INNER JOIN reviews ON products.ProductID=reviews.ProductID
WHERE reviews.Rating = 5;

/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
SELECT FirstName, LastName, ProductsSold AS ProductsSold FROM 

(SELECT employees.FirstName, employees.LastName, SUM(sales.Quantity) AS ProductsSold
FROM employees
INNER JOIN sales ON employees.EmployeeID=sales.EmployeeID
GROUP BY employees.EmployeeID) AS EmployeesSales

WHERE ProductsSold = (SELECT MAX(ProductsSold) FROM 

(SELECT employees.FirstName, employees.LastName, SUM(sales.Quantity) AS ProductsSold
FROM employees
INNER JOIN sales ON employees.EmployeeID=sales.EmployeeID
GROUP BY employees.EmployeeID) AS EmployeesSales);
-- I saw after I finished that there is a simpler way to do this, but there are a few issues with the simpler way
-- The way shown in the video will only work if you know the number of employees tied for first place (2 in this case)
-- This method will show the top employees no matter how many are tied for first place

/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT departments.Name, categories.Name FROM departments
INNER JOIN categories ON departments.DepartmentID=categories.DepartmentID;

/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
 SELECT products.Name, SUM(sales.Quantity) as NumberSold, (sales.Quantity * sales.PricePerUnit) as TotalPrice
 FROM products
 INNER JOIN sales ON products.ProductID=sales.ProductID
 WHERE products.ProductID = 97;

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT products.Name, reviews.Reviewer, MIN(reviews.Rating) as Rating, reviews.Comment
FROM products
INNER JOIN reviews on products.ProductID=reviews.ProductID
WHERE products.Name = 'Visio TV';

-- ------------------------------------------ Extra - May be difficult
/* Your goal is to write a query that serves as an employee sales report.
This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold */
SELECT employees.EmployeeID, employees.FirstName, employees.LastName, products.Name AS ProductName, SUM(sales.Quantity) AS TotalSold
FROM sales
INNER JOIN employees on employees.EmployeeID=sales.EmployeeID
INNER JOIN products on products.ProductID=sales.ProductID
GROUP BY employees.EmployeeID, products.ProductID
ORDER BY employees.EmployeeID;