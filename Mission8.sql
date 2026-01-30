/*Étape 1 — Créer un cas “paiement”
START TRANSACTION*/
INSERT INTO payments (user_id, amount)
VALUES (1, 19.99);

-- Simulation opération métier (ex: corriger le nom / ou autre update)
UPDATE users
SET nom = CONCAT(nom, ' (client)')
WHERE id = 1;

COMMIT;

/*Étape 2 — Forcer une erreur de rollback

Ici on fait une requête invalide (par ex un email en double → viole UNIQUE).*/

START TRANSACTION;

SAVEPOINT sp1;

-- Action OK
INSERT INTO payments (user_id, amount)
VALUES (2, 29.99);

-- Requête invalide (email déjà existant -> erreur UNIQUE)
UPDATE users
SET email = 'awa@test.com'
WHERE id = 2;

-- Si erreur : on annule jusqu’au savepoint
ROLLBACK TO sp1;

-- On peut continuer après rollback
INSERT INTO payments (user_id, amount)
VALUES (2, 9.99);

COMMIT;

/*Ce que je comprends :

SAVEPOINT = “point de sauvegarde”

ROLLBACK TO sp1 annule seulement ce qui s’est passé après le savepoint

COMMIT valide ce qui reste

Si tu veux, envoie-moi une capture de tes résultats EXPLAIN (avant/après) et je te dis si c’est parfait.*/