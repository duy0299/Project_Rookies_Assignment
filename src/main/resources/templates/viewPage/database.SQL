-- create database
CREATE DATABASE IF NOT EXISTS shopdb CHARACTER SET utf8 COLLATE utf8_general_cs;


-- CREATE TABLES
CREATE TABLE product_style(
    id          VARCHAR(20) NOT NULL,
    name        VARCHAR(50) NOT NULL,
    price_root  INT(11) NOT NULL,
    description VARCHAR(200) NOT NULL,
    status      BIT NOT NULL,
    time_create DATETIME NOT NULL,
    time_update DATETIME NOT NULL,
)

CREATE TABLE categories(
    id          VARCHAR(20) NOT NULL,
    name        VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL,
    status      BIT NOT NULL,
    time_create DATETIME NOT NULL,
    time_update DATETIME NOT NULL,
)

CREATE TABLE categories(
    id               VARCHAR(20) NOT NULL,
    product_style_id VARCHAR(20) NOT NULL,
    categories_id    VARCHAR(20) NOT NULL,
    status      BIT NOT NULL,
    time_create DATETIME NOT NULL,
    time_update DATETIME NOT NULL,
)

CREATE TABLE size(
    id          VARCHAR(20) NOT NULL,
    name        VARCHAR(50) NOT NULL,
    status      BIT NOT NULL,
    time_create DATETIME NOT NULL,
    time_update DATETIME NOT NULL,
)

CREATE TABLE product(
    id          VARCHAR(20) NOT NULL,
    size_id     VARCHAR(20) NOT NULL,
    avatar      VARCHAR(50) NOT NULL,
    name        VARCHAR(50) NOT NULL,
    quantity    int(11)     NOT NULL CHECK(quantity>0 OR quantity=0),
    price_root  INT(11) NOT NULL,
    description VARCHAR(200) NOT NULL,
    status      BIT NOT NULL,
    time_create DATETIME NOT NULL,
    time_update DATETIME NOT NULL,
)