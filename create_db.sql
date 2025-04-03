-- File: create_db.sql

-- Create DB if there is none
CREATE DATABASE IF NOT EXISTS xdemodb;

-- Select db
USE xdemodb;

-- Create table in selected db
CREATE TABLE IF NOT EXISTS Schedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    hour TIME NOT NULL,
    shared BOOLEAN DEFAULT FALSE,
    reserved BOOLEAN DEFAULT FALSE,
    reserved_by VARCHAR(100),
    reserved_note VARCHAR(255)
);
