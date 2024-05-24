 SELECT *
 FROM PUBLIC.WALMARTSALESDATA_CSV 
 
 --------------------------Questions To Answer--------------------------------------------
---------------------------Generic Question-----------------------------------------------
---------------------1.	How many unique cities does the data have?------------------------
 
  SELECT DISTINCT "City"
 FROM PUBLIC.WALMARTSALESDATA_CSV 
 
---------------------2.	In which city is each branch?-------------------------------------
SELECT DISTINCT "Branch", "City" 
FROM PUBLIC.WALMARTSALESDATA_CSV 
 
 
--------------------------Product---------------------------------------------------------
--------------1.	How many unique product lines does the data have?---------------------

SELECT COUNT(DISTINCT "Product line") AS unique_product_lines
FROM PUBLIC.WALMARTSALESDATA_CSV 

--------------2.	What is the most common payment method?-------------------------------
SELECT "Payment", COUNT("Payment") AS payment_count
FROM PUBLIC.WALMARTSALESDATA_CSV 
GROUP BY "Payment"
ORDER BY payment_count DESC
--------------3.	What is the most selling product line?--------------------------------

SELECT "Product line", SUM("Quantity") AS total_quantity
FROM PUBLIC.WALMARTSALESDATA_CSV 
GROUP BY "Product line"
ORDER BY total_quantity DESC
LIMIT 1;
--------------4.	What is the total revenue by month?-----------------------------------

SELECT "MONTH_NAME", SUM("Total") AS total_revenue
FROM PUBLIC.WALMARTSALESDATA_CSV 
GROUP BY "MONTH_NAME";

--------------5.Which product had the largest revenue ?-----------------------------------

SELECT "Product line", SUM("Total") AS total_revenue
FROM PUBLIC.WALMARTSALESDATA_CSV
GROUP BY "Product line"
ORDER BY total_revenue DESC 

--------------6.Fetch each product line and add a column to those product lines showing "Good", and "Bad". Good if it's greater than average sales.

SELECT "Product line", SUM("Quantity") AS total_quantity,
       CASE 
           WHEN SUM("Quantity") > (
               SELECT AVG(total_quantity) 
               FROM (
                   SELECT SUM("Quantity") AS total_quantity 
                   FROM PUBLIC.WALMARTSALESDATA_CSV 
                   GROUP BY "Product line"
               ) AS subquery
           ) THEN 'Good' 
           ELSE 'Bad' 
       END AS quality
FROM PUBLIC.WALMARTSALESDATA_CSV 
GROUP BY "Product line";


--------------------------------------------------------Sales----------------------------------------------------------
-----------------------------1.	Number of sales made each time of the day per weekday----------------------------------
SELECT "DAY_NAME", "TIME_OF_DAY", COUNT(*) AS sales_count
FROM PUBLIC.WALMARTSALESDATA_CSV 
GROUP BY "DAY_NAME", "TIME_OF_DAY";

-----------------------------2.	Which of the customer types brings the most revenue?-----------------------------------
SELECT "Customer type", SUM("Total") AS total_revenue
FROM PUBLIC.WALMARTSALESDATA_CSV
GROUP BY "Customer type"
ORDER BY total_revenue DESC


-----------------------------3.	Which city has the largest tax percentage/ VAT (Value Added Tax)?----------------------
SELECT "City", AVG("Tax 5%" / ("Total" - "Tax 5%")) * 100 AS Avg_Tax_Percentage
FROM PUBLIC.WALMARTSALESDATA_CSV
GROUP BY "City"
ORDER BY Avg_Tax_Percentage DESC


-----------------------------4.	Which customer type pays the most in VAT?----------------------------------------------
SELECT "Customer type", SUM("Tax 5%") AS total_tax_paid
FROM PUBLIC.WALMARTSALESDATA_CSV
GROUP BY "Customer type"
ORDER BY total_tax_paid DESC
LIMIT 1;

----------------------------------------------------Customer-----------------------------------------------------------
----------------------------1.	How many unique customer types does the data have?-------------------------------------
SELECT COUNT(DISTINCT "Customer type") AS unique_customer_types
FROM PUBLIC.WALMARTSALESDATA_CSV;

----------------------------2.	How many unique payment methods does the data have?------------------------------------

SELECT COUNT(DISTINCT "Payment") AS unique_payment_methods
FROM PUBLIC.WALMARTSALESDATA_CSV;

----------------------------3.	What is the most common customer type?-------------------------------------------------
SELECT "Customer type", COUNT("Customer type") AS frequency
FROM PUBLIC.WALMARTSALESDATA_CSV
GROUP BY "Customer type"
ORDER BY frequency DESC
LIMIT 1;


----------------------------4.	Which customer type buys the most?-----------------------------------------------------
SELECT "Customer type", SUM("Total") AS total_revenue
FROM PUBLIC.WALMARTSALESDATA_CSV
GROUP BY "Customer type"
ORDER BY total_revenue DESC

----------------------------5.	What is the gender of most of the customers?-------------------------------------------
SELECT "Gender", COUNT(*) AS count
FROM PUBLIC.WALMARTSALESDATA_CSV
GROUP BY "Gender"
ORDER BY count DESC
LIMIT 1;


