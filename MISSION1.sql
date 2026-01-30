/* Mission1
Etapes1   creation de la base de donne */
DROP DATABASE educore_tp;
CREATE DATABASE educore_tp;
USE educore_tp;

/*Etapes2   creation de la table user*/
CREATE TABLE if not exists users (
id Int AUTO_INCREMENT PRIMARY KEY,
nom VARCHAR(50) NOT NULL ,
email VARCHAR(100) NOT NULL UNIQUE,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

/*Etapes3   creation de la table courses */
CREATE TABLE courses(
id INT AUTO_INCREMENT PRIMARY KEY,
titre VARCHAR(150) NOT NULL,
prix DECIMAL(10,2) NOT NUll,
CHECK (prix > 0)
);

/*Etapes4  creation de la table enrollments */
CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    progress INT DEFAULT 0,
    
    CHECK (progress BETWEEN 0 AND 100),
    
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    FOREIGN KEY (course_id) REFERENCES courses(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/*Etapes5  creation de la table payments */
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    paid_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (amount > 0),
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
/*Etapes6   verificationd rapides */
/*INSERT INTO users (nom, email) VALUES('Awa2', 'awa@gmail.com');
INSERT INTO users (nom, email) VALUES('Awaou', 'awa@gmail.com');
INSERT INTO courses (titre, prix) VALUES('SQL Avancé',49.99);
INSERT INTO enrollments(user_id, course_id,progress) VALUE (1, 1, 20);*/
  
