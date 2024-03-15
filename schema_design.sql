-- Problem questions are described in more detail in the README.md

---- 5) Populating location data table with provided data ----
INSERT INTO location(city, state, country) VALUES
	('Nashville', 'Tennessee', 'United States'),
	('Memphis', 'Tennessee', 'United States'),
	('Phoenix', 'Arizona', 'United States'),
	('Denver', 'Colorado', 'United States');

---- 6) Populating person data table with provided data ----
INSERT INTO person("firstName", "lastName", age, location_id) VALUES
	('Chickie', 'Ourtic', 21, 1),
	('Hilton', 'O"Hanley', 37, 1),
	('Barbe', 'Purver', 50, 3),
	('Reeta', 'Sammons', 34, 2),
	('Abbott', 'Fisbburne', 49, 1),
	('Winnie', 'Whines', 19, 4),
	('Samantha', 'Leese', 35, 2),
	('Edouard', 'Lorimer', 29, 1),
	('Mattheus', 'Shaplin', 27,3),
	('Donnell', 'Corney', 25, 3),
	('Wallis', 'Kauschke', 28, 3),
	('Melva', 'Lanham', 20, 2),
	('Amelina', 'McNirlan', 22, 4),
	('Courtney', 'Holley', 22, 1),
	('Sigismond', 'Vala', 21, 4),
	('Jacquelynn', 'Halfacre', 24, 2),
	('Alanna', 'Spino', 25, 3),
	('Isa', 'Slight', 32, 1),
	('Kakalina', 'Renne', 26, 3);
	
---- 7) Populating interest data table with provided data ----
INSERT INTO interest(title) VALUES
	('Programming'),
	('Gaming'),
	('Computers'),
	('Music'),
	('Movies'),
	('Cooking'),
	('Sports');
	
---- 8) Populating person_interest data table with provided data ----
INSERT INTO person_interest(person_id, interest_id) VALUES
	(1, 1), (1, 2), (1, 6), (2, 1), (2, 7), (2, 4),
	(3, 1), (3, 3), (3, 4), (4, 1), (4, 2), (4, 7),
	(5, 6), (5, 3), (5, 4), (6, 2), (6, 7),	(7, 1),
	(7, 3),	(8, 2),	(8, 4), (9, 5), (9, 6), (10, 7),
	(10, 5), (11, 1), (11, 2), (11, 5), (12, 1), (12, 4),
	(12, 5), (13, 2), (13, 3), (13, 7),	(14, 2), (14, 4),
	(14, 6), (15, 1), (15, 5), (15, 7),	(16, 2), (16, 3),
	(16, 4), (17, 1), (17, 3), (17, 5),	(17, 7), (18, 2),
	(18, 4), (18, 6), (19, 1), (19, 2),	(19, 3), (19, 4),
	(19, 5), (19, 6), (19, 7);

---- 9) Some users had birthdays so we update their age ----
UPDATE person
SET age = age + 1
WHERE ("firstName" = 'Chickie' AND "lastName" = 'Ourtic')
   OR ("firstName" = 'Winnie' AND "lastName" = 'Whines')
   OR ("firstName" = 'Edouard' AND "lastName" = 'Lorimer')
   OR ("firstName" = 'Courtney' AND "lastName" = 'Holley')
   OR ("firstName" = 'Melva' AND "lastName" = 'Lanham')
   OR ("firstName" = 'Isa' AND "lastName" = 'Slight')
   OR ("firstName" = 'Abbott' AND "lastName" = 'Fisbburne')
   OR ("firstName" = 'Reeta' AND "lastName" = 'Sammons');

---- 10) Some users wanted to delete their account ----
DELETE FROM person_interest
WHERE person_id IN (SELECT id FROM person AS p
					WHERE (p."firstName" = 'Hilton' AND p."lastName" = 'O"Hanley') 
   					OR (p."firstName" = 'Alanna' AND p."lastName" = 'Spino'));
DELETE FROM person AS p
WHERE (p."firstName" = 'Hilton' AND p."lastName" = 'O"Hanley') 
    					OR (p."firstName" = 'Alanna' AND p."lastName" = 'Spino');

---- 11) Some SELECT statements ----
-- Get all names of the people using application
SELECT "firstName", "lastName" from person

-- Find all people who live in Nashville, TN
SELECT "firstName", "lastName", city, state 
FROM person JOIN location ON person.location_id = location.id

-- Use COUNT & GROUP BY to figure out how many people live in each of our four cities
SELECT city, COUNT(p.id)
FROM person AS p JOIN location AS l ON p.location_id = l.id
GROUP BY city;

-- Use COUNT & GROUP BY to determine how many people are interested in each of the 7 interests
SELECT title, COUNT(p.id)
FROM person AS p 
JOIN person_interest AS pi ON p.id = pi.person_id
JOIN interest AS i ON i.id = pi.interest_id
GROUP BY title;

-- Names of all people who live in Nashville, TN and are interested in programming
SELECT "firstName", "lastName", city, state, title
FROM person AS p
JOIN person_interest AS pi ON pi.person_id = p.id
JOIN interest AS i ON pi.interest_id = i.id
JOIN location AS l ON p.location_id = l.id
WHERE l.city = 'Nashville' AND l.state = 'Tennessee' AND i.title = 'Programming';

-- BONUS: count of people in age ranges 20-30, 30-40, 40-50
SELECT 
CASE WHEN age >= 20 AND age < 30 THEN '20-30'
     WHEN age >= 30 AND age < 40 THEN '30-40'
     WHEN age >= 40 AND age <= 50 THEN '40-50'
     END AS range,
     COUNT(id)
FROM person
WHERE age >= 20 AND age <= 50
GROUP BY range;



