# walmart_sales_analysis-using_SQL

Build a database and insert the data.
This dataset, [Walmart Sales Data], contains sales information for various product lines across different branches and cities. Key columns include Invoice ID, Branch, City, Customer type, Gender, Product line, Unit price, Quantity, Tax 5%, Total, Date, Time, Payment, cogs, gross margin percentage, gross income, and Rating.
Add a new column named "time_of_day" to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
Add a new column named "day_name" that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
Add a new column named "month_name" that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar..). This helps to determine which month of the year has the most sales and profit.
The provided SQL query calculates the average quantity sold for each product line and categorizes each product line as 'Good' or 'Bad' based on whether its average quantity exceeds the overall average quantity across all product lines.
