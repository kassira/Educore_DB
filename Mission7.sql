/*Étape 1 requêtes  avec EXPLAIN
1) Recherche d’un user par email*/
EXPLAIN
SELECT *
FROM users
WHERE email = 'awa@test.com';
/* commentaire : si email n’est pas indexé, MySQL peut faire un scan de toute la table (type: ALL).

2) Paiements par date (ex: derniers paiements)*/
EXPLAIN
SELECT *
FROM payments
WHERE paid_at >= '2026-01-01'
ORDER BY paid_at DESC;
/*Commentaire: sans index sur paid_at, MySQL peut trier beaucoup de lignes (filesort) et lire énormément de données.

3) Enrollments d’un cours */
EXPLAIN
SELECT *
FROM enrollments
WHERE course_id = 1;
/*Commentaire: sans index sur course_id, MySQL peut lire toute la table enrollments.


Étape 2 — Créer 3 index pertinents*/
CREATE UNIQUE INDEX idx_users_email ON users(email);

CREATE INDEX idx_payments_paid_at ON payments(paid_at);

CREATE INDEX idx_enrollments_course_user ON enrollments(course_id, user_id);



/*Étape 3 — Refaire EXPLAIN et comparer (avant/après)
Remarque: 
Avant MySQL faisait un full scan. Après il utilise l’index et lit beaucoup moins de lignes.*/