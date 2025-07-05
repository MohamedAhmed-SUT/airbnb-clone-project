-- =================================================================
-- Task 0: Mastering SQL Joins
-- =================================================================
-- This script contains three queries demonstrating the use of
-- INNER JOIN, LEFT JOIN, and FULL OUTER JOIN on the Airbnb Clone database.
-- =================================================================


-- =================================================================
-- Query 1: INNER JOIN
-- =================================================================
-- Objective: Retrieve all bookings and the respective users who made those bookings.
--
-- An INNER JOIN is used here because we only want to see bookings that are
-- associated with a user. This is the most common type of join, returning
-- only the rows where the join condition is met in both tables.

SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    u.email
FROM
    Booking AS b
INNER JOIN
    "User" AS u ON b.user_id = u.user_id;


-- =================================================================
-- Query 2: LEFT JOIN
-- =================================================================
-- Objective: Retrieve all properties and their reviews, including properties that have no reviews.
--
-- A LEFT JOIN is perfect for this scenario. It ensures that every record
-- from the Property table (the "left" table) is included in the result,
-- regardless of whether it has a matching record in the Review table.
-- For properties with no reviews, the review-related columns will be NULL.

SELECT
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment
FROM
    Property AS p
LEFT JOIN
    Review AS r ON p.property_id = r.property_id;


-- =================================================================
-- Query 3: FULL OUTER JOIN
-- =================================================================
-- Objective: Retrieve all users and all bookings, even if the user has no booking
--            or a booking is not linked to a user (a hypothetical case).
--
-- A FULL OUTER JOIN combines the results of both a LEFT JOIN and a RIGHT JOIN.
-- It will show every user and every booking. If a user has no booking, the booking
-- columns will be NULL. If a booking had no user, the user columns would be NULL.

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.status
FROM
    "User" AS u
FULL OUTER JOIN
    Booking AS b ON u.user_id = b.user_id;

-- =================================================================
-- Script End
-- =================================================================