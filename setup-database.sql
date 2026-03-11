-- ============================================================================
-- Fintech AI System - PostgreSQL Database Setup Script
-- ============================================================================
--
-- Database Name: fintech-ai-system
-- Username: root
-- Password: Samarthk@91
--
-- Usage: psql -U postgres -f setup-database.sql
-- ============================================================================

-- Connect as postgres user first, then run this script

-- Create the database
CREATE DATABASE "fintech-ai-system";

-- Connect to the new database
\c fintech-ai-system

-- Create the user (if not exists)
CREATE USER root WITH PASSWORD 'Samarthk@91';

-- Grant privileges on the database
GRANT ALL PRIVILEGES ON DATABASE "fintech-ai-system" TO root;

-- Grant schema privileges
GRANT ALL ON SCHEMA public TO root;

-- Allow future tables to be created by this user
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO root;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO root;

-- Display confirmation
\echo '======================================'
\echo 'Database Setup Complete!'
\echo '======================================'
\echo 'Database: fintech-ai-system'
\echo 'User: root'
\echo 'Password: Samarthk@91'
\echo 'Host: localhost'
\echo 'Port: 5432'
\echo '======================================'

