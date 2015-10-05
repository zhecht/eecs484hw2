-- Homework #2: EECS 484.
-- Your uniquname: zhecht
-- include your teamate's uniqname if you are working in team's of two

-- Your answer should work for any instance of the database, not just the one given.

-- EXAMPLE
-- Q0: "list titles of all books". Answer given below.

SELECT title FROM books;

-- Q1: List the ISBN of all books written by "Frank Herbert"

SELECT E.isbn FROM editions E, books B, authors S 
WHERE E.book_id = B.book_id 
	AND B.author_id = S.author_id 
	AND S.first_name = 'Frank' 
	AND S.last_name = 'Herbert';

-- Q2: List last name and first name of authors who have written both
-- Short Story and Horror books. In general, there could be two different authors
-- with the same name, one who has written a horror book and another
-- who has written short stories. 

SELECT A.last_name, A.first_name FROM authors A, books B1, books B2, subjects S1, subjects S2 WHERE A.author_id = B1.author_id AND A.author_id = B2.author_id AND B1.subject_id = S1.subject_id AND B2.subject_id = S2.subject_id AND S1.subject = 'Horror' AND S2.subject = 'Short Story';

-- Q3: List titles, subjects, author's id, author's last name, and author's first name of all books 
-- by authors who have written Short Story book(s). Note: that this may
-- require a nested query. The answer can include non-Short Story books. You
-- can also use views. But DROP any views at the end of your query. Using
-- a single query is likely to be more efficient in practice.

SELECT B.title, S.subject, A.author_id, A.last_name, A.first_name FROM books B, subjects S, authors A WHERE A.author_id = B.author_id AND B.subject_id = ANY (SELECT S1.subject_id FROM subjects S1 WHERE S1.subject = 'Short Story');


SELECT B.title, S.subject, A.author_id, A.last_name, A.first_name FROM books B, subjects S, authors A WHERE A.author_id = B.author_id AND B.subject_id = (SELECT B2.subject_id FROM books B2, authors A1, subjects S1 WHERE A1.author_id = B2.author_id AND B2.subject_id = S1.subject_id AND S1.subject = 'Short Story') AND B.subject_id = S.subject_id;

-- Q4: Find id, first name, and last name of authors who wrote books for all the 
-- subjects of books written by Edgar Allen Poe.

SELECT A.author_id, A.first_name, A.last_name FROM authors A, books B, subjects S WHERE A.author_id = B.author_id AND B.subject_id = S.subject_id AND S.subject = ANY (SELECT S1.subject FROM subjects S1, books B1, authors A1 WHERE S1.subject_id = B1.subject_id AND A1.author_id = B1.author_id AND A1.first_name = 'Edgar Allen' AND A1.last_name = 'Poe');

SELECT A.author_id, A.first_name, A.last_name FROM authors A, books B, subjects S WHERE A.author_id = B.author_id AND B.subject_id = (SELECT subject_id FROM subjects WHERE subject = (SELECT S1.subject FROM subjects S1, authors A1, books B1 WHERE S1.subject_id = B1.subject_id AND B1.author_id = A1.author_id AND A1.first_name = 'Edgar Allen' AND A1.last_name = 'Poe'));


-- Q5: Find the name and id of all publishers whos have published books for authors
-- who have written more than one book, order by ascending publisher id;

SELECT P.name, P.publisher_id FROM publishers P, editions E WHERE P.publisher_id = E.publisher_id AND  IN (SELECT E.publisher_id FROM editions E WHERE EXISTS (SELECT * FROM authors A, books B WHERE A.author_id = B.author_id AND B.book_id = E.book_id HAVING COUNT(*) > 1));


-- Q6: Find the last name and first name of authors who haven't written any book
SELECT A.last_name, A.first_name FROM authors A WHERE NOT EXISTS (SELECT * FROM books B WHERE B.author_id = A.author_id);


-- Q7: Find the book_id and its corresponding total stock available for all book editions ordered
--     in descending order by the total stock. Name the column for total stock as NUM_STOCK. 
--     NOTE: You do not need to consider editions of books that are not in the Stock Table.

SELECT E.book_id, S.stock FROM stock S, editions E WHERE 


-- Q8: Find id of authors who have written exactly 1 book. Name the column as id. 
-- Order the id in ascending order
SELECT A.author_id AS id FROM authors A WHERE EXISTS (SELECT * FROM books B WHERE A.author_id = B.author_id HAVING COUNT(*) = 1) ORDER BY A.author_id;
