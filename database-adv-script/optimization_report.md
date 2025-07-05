# Query Optimization Report

## 1. Introduction

This report documents the process of analyzing and optimizing a complex query designed to retrieve comprehensive details for confirmed bookings. The goal is to improve query performance by refactoring the initial query and applying best practices.

---

## 2. Initial Query and Performance Analysis

### 2.1. The Initial Query

The first version of the query was designed to join four tables (`Booking`, `User`, `Property`, `Payment`) to gather all relevant information for confirmed bookings.

```sql
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