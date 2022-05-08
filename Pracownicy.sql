CREATE DATABASE employees COLLATE utf8mb4_polish_ci;

-- 1.Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, 
-- które uznasz za niezbędne.

CREATE TABLE employees (
id BIGINT PRIMARY KEY AUTO_INCREMENT, 
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL, 
salary DECIMAL(9,2) NOT NULL,
birth_date DATE NOT NULL, 
title VARCHAR(50) NOT NULL
);

-- 2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO employees
(first_name, last_name, salary, birth_date, title)
VALUES
('Jan', 'Kowalski', 10000,'1990-10-20', 'senior engineer'), 
('Anna', 'Nowak', 6500, '2000-05-04', 'accountant'), 
('Beata', 'Wiercioch', 7500, '1985-07-20','legal advisor'), 
('Bartek', 'Adamowicz', 4000, '1999-06-11', 'assistant'), 
('Tomasz', 'Sosna', 4500, '2005-04-12', 'junior HR specialist'), 
('Katarzyna', 'Świerk', 20000, '1975-08-22','president');

-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM employees ORDER BY last_name;

-- 4. Pobiera pracowników na wybranym stanowisku
SELECT first_name, last_name, title FROM employees WHERE title = 'assistant';

-- 5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM employees WHERE birth_date < DATE_SUB(CURDATE(), INTERVAL 30 YEAR);

-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE employees SET salary = salary * 1.1  WHERE title = 'assistant';

-- 7. Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)
SELECT * FROM employees WHERE birth_date = (SELECT MAX(birth_date) FROM employees);

-- 8. Usuwa tabelę pracownik
DROP TABLE employees;

-- 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE title (
id BIGINT PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR(50) NOT NULL,
description VARCHAR(2000), 
salary DECIMAL(9,2) NOT NULL
);

-- 10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE address (
id BIGINT PRIMARY KEY AUTO_INCREMENT, 
street VARCHAR(50) NOT NULL,
house_no VARCHAR(10) NOT NULL,
zip_code VARCHAR(10) NOT NULL,
city VARCHAR(50) NOT NULL
);

-- 11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE employee (
id BIGINT PRIMARY KEY AUTO_INCREMENT, 
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL, 
title_id BIGINT NOT NULL, 
address_id BIGINT NOT NULL,
CONSTRAINT fk_title_id FOREIGN KEY (title_id) REFERENCES title (id),
CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES address (id)
);

-- 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO address
(street, house_no, zip_code, city)
VALUES
('Sobieskiego', '15', '00-503', 'Żyrardów'),
('Mickiewicza', '18/90', '96-100', 'Skierniewice'),
('Sebastiana Bacha', '3B', '50-550', 'Grodzisk Mazowiecki'),
('Warzywna', '156', '96-100', 'Skierniewice'),
('Dębowa', '5', '96-200', 'Radziwiłłów Mazowiecki');

INSERT INTO title
(name, description, salary)
VALUES
('Senior engineer', 'responsible for key aerospace projects', 10000),
('Senior accountant', 'in charge of crucial finance processes', 8000), 
('Junior Recruitment specialist', 'mananages rectuitement of entry-level candidates', 4500), 
('President', 'the leader of the executive group', 20000), 
('IT Specialist', 'provides direct technical support to users across the organization', 10000);

INSERT INTO employee
(first_name, last_name, title_id, address_id)
VALUES
('Jan', 'Kowalski', 1 , 5), 
('Anna', 'Nowak', 3 , 4), 
('Beata', 'Wiercioch', 2 , 2), 
('Bartek', 'Adamowicz', 5, 1), 
('Tomasz', 'Sosna', 4 , 3);

-- 13.Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT first_name, last_name, name AS title_name, description AS title_description, salary, street, house_no, zip_code, city
FROM employee e
JOIN title t ON e.title_id = t.id
JOIN address a ON e.address_id = a.id;

-- 14. Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT SUM(salary) 
FROM employee e
JOIN title t ON e.title_id = t.id;

-- 15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210
-- (albo innym, który będzie miał sens dla Twoich danych testowych)
SELECT first_name, last_name, zip_code, city FROM employee e 
JOIN address a ON e.address_id = a.id
WHERE zip_code = '96-100';










