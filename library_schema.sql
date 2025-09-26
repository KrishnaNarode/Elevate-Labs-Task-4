create database LibraryManagement;
use LibraryManagement;

CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    publication_year INT,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE
);


CREATE TABLE Loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    loan_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO Authors (author_name) VALUES
('Krishna'),
('Atharva'),
('Nilesh'),
('Prasad'),
('Omkar');

select * from Authors;
INSERT INTO Books (title, publication_year, author_id) VALUES
('Harry Potter and the Sorcerers Stone', 1947, 1),
('Harry Potter and the Sorcerers Stone Part 2', 1949, 2),
('Harry Potter and the Sorcerers Stone Part 3', 1955, 3),
('I, Robot', 1950, 4),
('The Shining', 1977, 5),
('Animal Farm', 1945, 2),
('The Hitchhiker''s Guide to the Galaxy', 1979, 1);

select * from Books;

INSERT INTO Members (member_name, phone_number) VALUES
('Krissna', '9067419087'),
('Atharva', '8459561890'),
('Nilesh', '7745632871');

select * from Members;

INSERT INTO Loans (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2025-09-01', '2025-09-15'),
(3, 2, '2025-09-05', NULL),
(5, 3, '2025-09-07', '2025-09-20');

select * from Loans;

INSERT INTO Members (member_name, phone_number) VALUES
('Prasad', NULL);

INSERT INTO Books (title, publication_year, author_id) VALUES
('Unknown Tales', NULL, 1);

INSERT INTO Loans (book_id, member_id, loan_date, return_date) VALUES
(2, 1, '2025-09-10', NULL);

UPDATE Books
SET publication_year = 2001
WHERE title = 'Unknown Tales';

UPDATE Loans
SET return_date = '2025-09-25'
WHERE return_date IS NULL;

UPDATE Members
SET phone_number = '9999999999'
WHERE member_name = 'Prasad';

DELETE FROM Members
WHERE phone_number IS NULL;

DELETE FROM Loans
WHERE loan_date < '1950-01-01';

DELETE FROM Books
WHERE title = 'Animal Farm';

SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Loans;

SELECT * FROM Books;

SELECT title, publication_year FROM Books;

SELECT * FROM Books
WHERE publication_year = 1947 OR publication_year = 1977;

SELECT * FROM Books
WHERE publication_year > 1945 AND author_id = 1;

SELECT * FROM Members
WHERE member_name LIKE 'A%';

SELECT * FROM Books
WHERE title LIKE '%Harry%';

SELECT * FROM Books
WHERE publication_year BETWEEN 1945 AND 1960;

SELECT * FROM Loans
WHERE loan_date BETWEEN '2025-09-01' AND '2025-09-10';

SELECT * FROM Books
ORDER BY publication_year ASC;

SELECT * FROM Members
ORDER BY member_name DESC;

SELECT b.title, b.publication_year, a.author_name
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
WHERE b.publication_year BETWEEN 1940 AND 1960
ORDER BY b.title ASC;

-- task 4:
SELECT COUNT(*) AS total_books FROM Books;

SELECT a.author_name, COUNT(b.book_id) AS total_books
FROM Authors a
JOIN Books b ON a.author_id = b.author_id
GROUP BY a.author_name;

SELECT ROUND(AVG(publication_year), 0) AS avg_year FROM Books;

SELECT m.member_name, COUNT(l.loan_id) AS total_loans
FROM Members m
JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.member_name;

SELECT b.publication_year, COUNT(b.book_id) AS books_count
FROM Books b
GROUP BY b.publication_year
HAVING COUNT(b.book_id) > 1;

SELECT m.member_name, COUNT(l.loan_id) AS total_loans, SUM(b.publication_year) AS total_years
FROM Members m
JOIN Loans l ON m.member_id = l.member_id
JOIN Books b ON l.book_id = b.book_id
GROUP BY m.member_name
ORDER BY total_loans DESC;
