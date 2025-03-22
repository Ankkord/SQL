	
-- CREATE DATABASE usersdb;

-- USE usersdb;
-- SELECT * FROM songs;
/*
SELECT DISTINCT artist as 'Artist', trackname as 'music'  -- DISTINCT уникальные
FROM songs
LIMIT 5
OFFSET 2;


-- фильтряция данных

       
SELECT title, director
FROM Films
WHERE NOT title LIKE CONVERT('%_ %_', BINARY)
ORDER BY 1;

SELECT title, director, release_year
FROM Films
WHERE release_year NOT IN (2004, 2008, 2012)
ORDER BY 2, 3 DESC;

--Создание вычесляемых полей

SELECT  CONCAT(id, '. ', title) AS movie, 
        CONCAT('€', (price * 1.1)) AS price_in_eur,  
        CONCAT((rating * 10), '%') AS score
FROM Films
WHERE rating > 7
ORDER BY rating DESC;


Функции
Функция CHAR_LENGTH()
Функция LOWER()
Функция UPPER()
Функции LTRIM() и RTRIM()
Функция REVERSE()
Функция REPEAT()
Функции LPAD() и RPAD()
SELECT CHAR_LENGTH(123),
       REVERSE(123),
       REPEAT(123, 2),
       LPAD(123, 4, '-');
--LPAD - left padding - дополнение слева, LTRIM - left trimming - обрезка слева
*/