/* Mission 4
Étape 1 — Progression moyenne par cours*/

SELECT c.titre, AVG(e.progress) AS avg_progress
FROM courses c
JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.titre
ORDER BY avg_progress DESC;

/* Étape 2 — Identifier les “abandons” (progress < 25) */
SELECT u.nom, u.email, c.titre, e.progress
FROM enrollments e
JOIN users u ON u.id = e.user_id
JOIN courses c ON c.id = e.course_id
WHERE e.progress < 25
ORDER BY e.progress ASC;

/*Étape 3 — Cours “à risque” */
SELECT c.titre,
       AVG(e.progress) AS avg_progress,
       COUNT(*) AS nb_inscrits
FROM courses c
JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.titre
HAVING AVG(e.progress) < 50 AND COUNT(*) >= 3
ORDER BY avg_progress ASC;
