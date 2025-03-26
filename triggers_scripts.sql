DROP TABLE IF EXISTS Notifications;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers
(
    id   INT,
    name VARCHAR(40)
);

INSERT INTO Customers (id, name)
VALUES (10, 'Ivan'),
       (20, 'John'),
       (30, 'Mark'),
       (40, 'Elon'),
       (50, 'Pavel'),
       (60, 'Andrey'),
       (70, 'Peter'),
       (80, 'Ben');

CREATE TABLE Orders
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    store       VARCHAR(40),
    amount      INT,
    status      VARCHAR(40)
);

INSERT INTO Orders (store, customer_id, amount, status)
VALUES ('Ozon', 20, 101, 'Created'),
       ('PCUniverse', 40, 799, 'Shipped'),
       ('PCUniverse', 10, 99, 'Delivered'),
       ('DarkStore', 30, 99, 'Created'),
       ('Ozon', 50, 678, 'Delivered'),
       ('Ozon', 10, 458, 'Created');

CREATE TABLE Notifications
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    order_id    INT,
    message     TEXT,
    FOREIGN KEY (order_id) REFERENCES Orders (id)
);

INSERT INTO Notifications (order_id, message)
VALUES (1, 'John, new status of your delivery on 2024-08-26: Created'),
       (2, 'Elon, new status of your delivery on 2024-08-26: Shipped'),
       (3, 'Ivan, new status of your delivery on 2024-08-26: Delivered'),
       (4, 'Mark, new status of your delivery on 2024-08-26: Created'),
       (5, 'Pavel, new status of your delivery on 2024-08-26: Delivered'),
       (6, 'Ivan, new status of your delivery on 2024-08-26: Created');


DELIMITER //
CREATE TRIGGER mess_for_user
AFTER INSERT
ON Orders
FOR EACH ROW
    BEGIN
        INSERT INTO Notifications (order_id, message)
        VALUES (
            NEW.id, 
            CONCAT(
                (SELECT name FROM Customers
                WHERE NEW.customer_id = id), ', new status of your delivery on ', CURDATE(), ': ', NEW.status
            )
        );
    END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER mess_for_user_update
AFTER UPDATE
ON Orders
FOR EACH ROW
    BEGIN
        UPDATE Notifications 
        SET message = CONCAT(
                (SELECT name FROM Customers
                WHERE NEW.customer_id = id), ', new status of your delivery on ', CURDATE(), ': ', NEW.status
            )
        WHERE NEW.id = Notifications.id;
    END //
DELIMITER ;

UPDATE Orders
SET status = 'Delivered'
WHERE id = 2;