#Table Struture

CREATE TABLE Branch (
  bCode CHAR(2) NOT NULL,
  libarian VARCHAR(20) NOT NULL,
  address VARCHAR(50) NOT NULL,
  PRIMARY KEY(BCode)
);

CREATE TABLE Titles (
  title VARCHAR(30) NOT NULL,
  author VARCHAR(30) NOT NULL,
  publisher VARCHAR(20) NOT NULL,
  PRIMARY KEY(title)
);

CREATE TABLE Holdings (
  branch CHAR(2) NOT NULL,
  title VARCHAR(30) NOT NULL,
  copies INT
  FOREIGN KEY(branch) REFERENCES Branch(bCode),
  FOREIGN KEY(title) REFERENCES Titles(title)
);

INSERT INTO Branch
VALUES 
('B1', 'John Smith', '2 Anglesea Rd'),
('B2', 'Mary Jones', '34 Pearse St'),
('B3', 'Francis Owens', 'Grange X');

INSERT INTO Holdings 
VALUES 
('B1', 'Susannah', 3),
('B1', 'How to Fish', 2),
('B1', 'A History of Dublin', 1),
('B2', 'How to Fish', 4),
('B2', 'Computers', 2),
('B2', 'The Wife', 3),
('B3', 'A History of Dublin', 1),
('B3', 'Computers', 4),
('B3', 'Susannah', 3),
('B3', 'The Wife', 1);

INSERT INTO Titles 
VALUES 
('Susannah', 'Ann Brown', 'Macmillan'),
('How to Fish', 'Amy Fly', 'Stop Press'),
('A History of Dublin', 'David Little', 'Wiley'),
('Computers', 'Blaise Pascal', 'Applewoods'),
('The Wife', 'Ann Brown', 'Macmillan');

# Write SQL statements to retrieve the following information:

# (i) the names of all library books published by Macmillan.
SELECT titles
FROM Titles
WHERE publisher = 'Macmillan';

# (ii) branches that hold any books by Ann Brown (using a nested subquery).
SELECT DISTINCT branch 
FROM Holdings 
WHERE title IN (
  SELECT title
  FROM Titles
  WHERE author = 'Ann Brown'
);

# (iii) branches that hold any books by Ann Brown (without using a nested subquery).
SELECT DISTINCT branch 
FROM Holdings 
INNER JOIN Titles
ON Holdings.title = Titles.title 
AND Titles.author = 'Ann Brown';

# (iv) the total number of books held at each branch.
SELECT branch AS Branch,
SUM(copies) AS 'Sum Of Copies'
FROM Holdings
GROUP BY branch;