# Partitioning Performance Report

## 1. Introduction

This report details the implementation of table partitioning on the `Booking` table to optimize query performance, particularly for time-range queries. As a table like `Booking` grows to millions or billions of rows, standard indexing can become insufficient. Partitioning provides a way to physically divide the data while maintaining a single logical table.

---

## 2. Partitioning Strategy

### 2.1. The Problem

The `Booking` table is frequently queried by `start_date` to find bookings within a specific week, month, or year. On a very large table, even with an index on `start_date`, these queries can be slow because the database still has to work with a massive index.

### 2.2. The Solution: Range Partitioning

We implemented **Range Partitioning** on the `Booking` table using the `start_date` column as the partitioning key. The table was split into yearly partitions (e.g., `bookings_y2024`, `bookings_y2025`).

The DDL script for creating the partitioned table is available in `partitioning.sql`.

---

## 3. Performance Measurement and Analysis

To measure the impact, we analyze a query that fetches bookings for a specific month using `EXPLAIN ANALYZE`.

**Query Example:**
```sql
EXPLAIN ANALYZE SELECT * FROM Booking_Partitioned WHERE start_date >= '2025-07-01' AND start_date < '2025-08-01';