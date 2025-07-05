# Advanced SQL Scripting for Airbnb Clone

## Overview

This directory contains a series of SQL scripts and reports demonstrating advanced querying, indexing, and optimization techniques for the Airbnb Clone database.

### Task 0: Join Queries

The `joins_queries.sql` file contains three SQL queries designed to showcase the practical application of different types of SQL joins:

1.  **INNER JOIN:** Retrieves all bookings along with the details of the user who made each booking.
2.  **LEFT JOIN:** Lists all properties and any associated reviews, ensuring that properties with no reviews are also included in the result.
3.  **FULL OUTER JOIN:** Shows a complete list of all users and all bookings, matching them where possible and showing `NULL` values where no match exists.

These queries are fundamental for retrieving related data from multiple tables in a relational database.

---

### Task 1: Subqueries

The `subqueries.sql` file demonstrates how to use nested queries to perform advanced filtering:

1.  **Non-Correlated Subquery:** A query to find all properties with an average rating above a certain threshold. The inner query runs independently to generate a list of IDs for the outer query.
2.  **Correlated Subquery:** A query to find users who have made more than a specific number of bookings. The inner query depends on the outer query, running once for each user record.