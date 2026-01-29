/*  
Mission 3
 Étape 1 — Cours les plus suivis */
SELECT c.titre, COUNT(e.id) AS nb_inscrits
FROM courses c
JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.titre
ORDER BY nb_inscrits DESC;

/*   Étape 2 — Cours les plus rentables */
SELECT c.titre, COALESCE(SUM(p.amount), 0) AS revenu_total
FROM courses c
JOIN enrollments e ON e.course_id = c.id
LEFT JOIN payments p ON p.user_id = e.user_id
GROUP BY c.id, c.titre
ORDER BY revenu_total DESC;

/*  Étape 3 — Clients multi-achats */
SELECT u.id, u.nom, COUNT(p.id) AS nb_paiements
FROM users u
JOIN payments p ON p.user_id = u.id
GROUP BY u.id, u.nom
HAVING COUNT(p.id) >= 2
ORDER BY nb_paiements DESC;

/*  Étape 4 — Users qui n’ont jamais payé */
SELECT u.id, u.nom, u.email
FROM users u
LEFT JOIN payments p ON p.user_id = u.id
WHERE p.id IS NULL
ORDER BY u.nom;