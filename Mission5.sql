/*Étape 1 — Dépense totale par user (préparatoire)*/
SELECT u.id AS user_id, u.nom, COALESCE(SUM(p.amount), 0) AS total_spent
FROM users u
LEFT JOIN payments p ON p.user_id = u.id
GROUP BY u.id, u.nom
ORDER BY total_spent DESC;


/*Étape 2 — Users au-dessus de la moyenne */
SELECT t.user_id, t.nom, t.total_spent
FROM (
    SELECT u.id AS user_id, u.nom, COALESCE(SUM(p.amount), 0) AS total_spent
    FROM users u
    LEFT JOIN payments p ON p.user_id = u.id
    GROUP BY u.id, u.nom
) t
WHERE t.total_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT u.id, COALESCE(SUM(p.amount), 0) AS total_spent
        FROM users u
        LEFT JOIN payments p ON p.user_id = u.id
        GROUP BY u.id
    ) x
)
ORDER BY t.total_spent DESC;


/*Étape 3 — Cours plus chers que la moyenne*/
SELECT id, titre, prix
FROM courses
WHERE prix > (SELECT AVG(prix) FROM courses)
ORDER BY prix DESC;


/*Étape 4 — Users inscrits à au moins 2 cours*/
SELECT u.id, u.nom, COUNT(e.course_id) AS nb_cours
FROM users u
JOIN enrollments e ON e.user_id = u.id
GROUP BY u.id, u.nom
HAVING COUNT(e.course_id) >= 2
ORDER BY nb_cours DESC;


/*Étape 5 — Cours “jamais achetés” (approx logique)*/
SELECT c.id, c.titre, COUNT(DISTINCT e.user_id) AS nb_inscrits
FROM courses c
JOIN enrollments e ON e.course_id = c.id
LEFT JOIN payments p ON p.user_id = e.user_id
GROUP BY c.id, c.titre
HAVING COUNT(DISTINCT e.user_id) > 0
   AND COUNT(p.id) = 0
ORDER BY nb_inscrits DESC;

/*Justification métier (approx)

On considère qu’un cours est “jamais acheté” si aucun de ses inscrits n’a effectué de paiement.

Limite : un user peut avoir payé pour autre chose, ou payer un autre cours → on ne sait pas.
La vraie solution en prod : ajouter course_id (ou enrollment_id) dans payments. */