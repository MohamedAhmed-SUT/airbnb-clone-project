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