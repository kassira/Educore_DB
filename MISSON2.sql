/* Mission2

Etapes1   
 Insertion (10 users, 6 courses, 15 enrollments, 10+ payments)*/
INSERT INTO users (nom, email) VALUES
('Awa', 'awa@test.com'),
('Kassira', 'kassira@test.com'),
('Mariam', 'mariam@test.com'),
('Ibrahim', 'ibrahim@test.com'),
('Sarah', 'sarah@test.com'),
('Yanis', 'yanis@test.com'),
('Fatou', 'fatou@test.com'),
('Nina', 'nina@test.com'),
('Ousmane', 'ousmane@test.com'),
('Lea', 'lea@test.com');

INSERT INTO courses (titre, prix) VALUES
('SQL Débutant', 19.99),
('SQL Avancé', 49.99),
('Python Débutant', 29.99),
('Data Analysis', 59.99),
('Web Basics', 24.99),
('Git & GitHub', 14.99);

INSERT INTO enrollments (user_id, course_id, progress) VALUES
(1, 1, 10),
(1, 2, 0),
(2, 1, 50),
(2, 3, 20),
(3, 4, 80),
(3, 2, 35),
(4, 5, 60),
(4, 6, 100),
(5, 3, 15),
(5, 1, 5),
(6, 2, 90),
(6, 4, 40),
(7, 5, 70),
(8, 6, 25),
(9, 3, 55);

INSERT INTO payments (user_id, amount) VALUES
(1, 19.99),
(2, 49.99),
(2, 29.99),
(3, 59.99),
(4, 24.99),
(4, 14.99),
(5, 29.99),
(6, 49.99),
(7, 24.99),
(9, 29.99);

/* Etapes2  */
/* 1) Compter chaque table */
SELECT 'users' AS table_name, COUNT(*) AS total FROM users
UNION ALL
SELECT 'courses', COUNT(*) FROM courses
UNION ALL
SELECT 'enrollments', COUNT(*) FROM enrollments
UNION ALL
SELECT 'payments', COUNT(*) FROM payments;


/* 2) Vérifier si aucun enrollment avec progress < 0 ou > 100 */
SELECT COUNT(*) AS bad_progress_rows
FROM enrollments
WHERE progress < 0 OR progress > 100;

/* 3)vérifier que chaque enrollment pointe un user ET un course existants*/
SELECT COUNT(*) AS broken_enrollments
FROM enrollments e
LEFT JOIN users u ON u.id = e.user_id
LEFT JOIN courses c ON c.id = e.course_id
WHERE u.id IS NULL OR c.id IS NULL;


/* 4)vérifier que les Montants sont positifs*/
SELECT COUNT(*) AS non_positive_payments
FROM payments
WHERE amount <= 0;
