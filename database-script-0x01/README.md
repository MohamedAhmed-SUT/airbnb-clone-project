# Airbnb Clone - Database Schema Script

## Overview

This directory contains the SQL script for creating the database schema for the Airbnb Clone project. The schema is designed to be robust, normalized, and efficient.

## Files

- **`schema.sql`**: This is the main SQL Data Definition Language (DDL) script. It performs the following actions:
  1.  **Creates Custom Types**: Defines `ENUM` types for roles, statuses, and payment methods to ensure data consistency.
  2.  **Creates Tables**: Builds all the necessary tables (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`).
  3.  **Defines Constraints**: Sets up `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, and `CHECK` constraints to maintain data integrity.
  4.  **Creates Indexes**: Adds indexes to key columns to optimize query performance for common search operations.

## How to Use

To set up the database, execute the `schema.sql` script against a PostgreSQL database. For example, using the `psql` command-line tool:

```bash
psql -U your_username -d your_database_name -f schema.sql

# Airbnb Clone - Database Seeding Script

## Overview

This directory contains the SQL script for seeding (populating) the Airbnb Clone database with realistic sample data. This script uses Data Manipulation Language (DML) commands to insert records into the tables created by the `schema.sql` script.

## Files

- **`seed.sql`**: This script populates the database with sample records, including:
  - Users (with different roles)
  - Properties (listed by hosts)
  - Bookings (made by guests)
  - Payments (for confirmed bookings)
  - Reviews (for completed stays)
  - Messages (between users)

## How to Use

This script should be executed **after** the `schema.sql` script has been run successfully. To populate your database, run this script against your PostgreSQL instance.

Example using the `psql` command-line tool:

```bash
psql -U your_username -d your_database_name -f seed.sql