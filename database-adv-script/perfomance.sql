-- =================================================================
-- Task 4: Complex Query Optimization
-- =================================================================
-- This script contains an initial complex query and its refactored,
-- optimized version.
-- =================================================================


-- =================================================================
-- Query 1: Initial Complex Query (Less Optimized)
-- =================================================================
-- Objective: Retrieve all details for bookings, including user, property, and payment info.
--
-- Inefficiencies:
-- 1. Using LEFT JOINs when we only want bookings that HAVE associated data.
-- 2. Selecting ALL columns (`*`) from every table, which is inefficient
--    as it retrieves more data than necessary.

SELECT
    *
FROM
    Booking AS b
LEFT JOIN
    "User" AS u ON b.user_id = u.user_id
LEFT JOIN
    Property AS p ON b.property_id = p.property_id
LEFT JOIN
    Payment AS py ON b.booking_id = py.booking_id
WHERE
    b.status = 'confirmed'
ORDER BY
    b.start_date DESC;


-- =================================================================
-- Query 2: Refactored Query (Optimized)
-- =================================================================
-- Objective: Retrieve specific, essential details for confirmed bookings.
--
-- Optimizations:
-- 1. Using INNER JOINs: This is more efficient as it only considers rows
--    that have matches in all joined tables, which is our goal.
-- 2. Selecting Specific Columns: We only select the columns we actually need,
--    reducing data transfer and processing load.

SELECT
    b.booking_id,
    b.start_date,
    b.total_price,
    u.first_name,
    u.email AS user_email,
    p.name AS property_name,
    p.location,
    py.payment_method,
    py.payment_date
FROM
    Booking AS b
INNER JOIN
    "User" AS u ON b.user_id = u.user_id
INNER JOIN
    Property AS p ON b.property_id = p.property_id
INNER JOIN
    Payment AS py ON b.booking_id = py.booking_id
WHERE
    b.status = 'confirmed'
ORDER BY
    b.start_date DESC;

-- =================================================================
Performance Analysis (EXPLAIN)
An analysis of this query reveals two main inefficiencies:
Use of LEFT JOIN: The query uses LEFT JOINs, which instructs the database to keep all records from the Booking table even if there are no matching payment or user records. Since our goal is to get confirmed bookings with their payment and user details, an INNER JOIN is more precise and can be better optimized by the query planner.
Use of SELECT *: Selecting all columns (*) from all tables is highly inefficient. It increases the amount of data the database needs to read from disk and send over the network, even if most of that data is not used by the application.
A simulated EXPLAIN plan for this query on a large dataset might show a higher cost due to the less restrictive joins and the large amount of data being processed.
3. Refactored (Optimized) Query
To address the inefficiencies, the query was refactored as follows:
SELECT
    b.booking_id,
    b.start_date,
    b.total_price,
    u.first_name,
    u.email AS user_email,
    p.name AS property_name,
    p.location,
    py.payment_method,
    py.payment_date
FROM
    Booking AS b
INNER JOIN
    "User" AS u ON b.user_id = u.user_id
INNER JOIN
    Property AS p ON b.property_id = p.property_id
INNER JOIN
    Payment AS py ON b.booking_id = py.booking_id
WHERE
    b.status = 'confirmed'
ORDER BY
    b.start_date DESC;
3.1. Implemented Optimizations
Switched to INNER JOIN: This makes the query more specific and allows the database to create a more efficient execution plan, as it can disregard any rows that don't have matches across all tables.
Selected Specific Columns: Instead of SELECT *, the query now lists only the essential columns needed. This dramatically reduces the data processing and transfer load.
4. Conclusion
By switching from LEFT JOIN to INNER JOIN and selecting only the necessary columns, the query becomes more efficient, specific, and performant. These simple refactoring techniques are fundamental for writing high-quality, scalable SQL that performs well under load.
-- =================================================================
### Task 4: Complex Query Optimization

This task demonstrates the process of analyzing and refactoring a query for better performance.

- **`perfomance.sql`**: Contains two versions of a complex query. The first is an initial, less-optimized version, and the second is a refactored, high-performance version.
- **`optimization_report.md`**: A detailed report explaining the inefficiencies of the initial query (e.g., use of `SELECT *`, unnecessary `LEFT JOIN`s) and how the refactored query addresses them for improved performance.