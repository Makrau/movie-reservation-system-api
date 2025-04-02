#!/bin/bash

# Function to check if PostgreSQL is running
check_postgres() {
    pg_isready -h localhost -p 5432 > /dev/null 2>&1
    return $?
}

# Function to start PostgreSQL
start_postgres() {
    echo "Starting PostgreSQL..."
    sudo service postgresql start
    sleep 3  # Wait for PostgreSQL to start
}

# Function to create database if it doesn't exist
setup_database() {
    echo "Setting up database..."
    rails db:create db:migrate
}

# Function to start Rails server
start_rails() {
    echo "Starting Rails server..."
    rails server -b 0.0.0.0
}

# Main execution
echo "Starting Movie Reservation System..."

# Check if PostgreSQL is running
if ! check_postgres; then
    start_postgres
fi

# Setup database
setup_database

# Start Rails server
start_rails 