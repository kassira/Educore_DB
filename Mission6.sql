/*Étape 1 — Vue v_active_users Users qui ont au moins 1 enrollment.*/

CREATE VIEW v_active_users AS
SELECT DISTINCT u.id, u.nom, u.email, u.created_at
FROM users u
JOIN enrollments e ON e.user_id = u.id;

/*Test :*/
SELECT * FROM v_active_users;

/*Étape 2 — Vue v_monthly_revenue CA mensuel (paiements groupés par mois) */

CREATE VIEW v_monthly_revenue AS
SELECT DATE_FORMAT(p.paid_at, '%Y-%m') AS month,
       SUM(p.amount) AS monthly_revenue,
       COUNT(*) AS nb_payments
FROM payments p
GROUP BY DATE_FORMAT(p.paid_at, '%Y-%m')
ORDER BY month;

/*Test :*/
SELECT * FROM v_monthly_revenue;

/*Étape 3 — Vue v_popular_courses Cours triés par nombre d’inscriptions :*/

CREATE VIEW v_popular_courses AS
SELECT c.id, c.titre, COUNT(e.id) AS nb_inscrits
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.titre
ORDER BY nb_inscrits DESC;

/*Test :*/
SELECT * FROM v_popular_courses;