## Create database using the following code snippet:

``` sql
CREATE DATABASE IF NOT EXISTS `weight_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE `weight_db`;

CREATE TABLE `users` (
	userID int NOT NULL AUTO_INCREMENT,
    username varchar(256),
    password varchar(256),
    age int,
    PRIMARY KEY(userID)
);

CREATE TABLE `weight` (
	id int NOT NULL AUTO_INCREMENT,
    userID int,
    date DATE DEFAULT CURRENT_DATE,
    value double,
    PRIMARY KEY(id),
    FOREIGN KEY (userID) REFERENCES users(userID)
);
```

## **Getting Started** <br>

```javascript
// Firstly install packages, run:
$ npm install

// To start the server, run:
$ node login.js

```
