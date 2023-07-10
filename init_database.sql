-- Création de la table lignes
CREATE TABLE lignes (
  id INT PRIMARY KEY,
  nom VARCHAR(50),
  couleur VARCHAR(20)
);


CREATE TABLE stations (
  id INT PRIMARY KEY,
  nom VARCHAR(50),
  adresse VARCHAR(100),
  zone_id INT,
  FOREIGN KEY (zone_id) REFERENCES zones(id)
);

CREATE TABLE zones (
  id INT PRIMARY KEY,
  nom VARCHAR(50)
);
CREATE TABLE utilisateurs (
  id INT PRIMARY KEY,
  nom VARCHAR(50),
  adresse VARCHAR(100),
  type_abonnement VARCHAR(20)
);

ALTER TABLE utilisateurs
ADD COLUMN nom VARCHAR(32),
ADD COLUMN email VARCHAR(128),
 type_abonnement VARCHAR(20)
;



CREATE TABLE deplacements (
  id INT PRIMARY KEY,
  utilisateur_id INT,
  moyen_transport_id INT,
  station_depart_id INT,
  station_arrivee_id INT,
  date_depart DATETIME,
  date_arrivee DATETIME,
  FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id),
  FOREIGN KEY (moyen_transport_id) REFERENCES moyens_transport(id),
  FOREIGN KEY (station_depart_id) REFERENCES stations(id),
  FOREIGN KEY (station_arrivee_id) REFERENCES stations(id)
);


CREATE TABLE abonnements (
  id INT PRIMARY KEY,
  utilisateur_id INT,
  type_abonnement VARCHAR(20),
  date_debut DATE,
  date_fin DATE,
  FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id)
);

ALTER TABLE abonnements
ADD COLUMN statut VARCHAR(32);


CREATE TABLE factures (
  id INT PRIMARY KEY,
  utilisateur_id INT,
  montant DECIMAL(10, 2),
  date_facture DATE,
  FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id)
);


COMMIT;

CREATE TABLE employes (
  id INT PRIMARY KEY,
  voyageur_id INT,
  login VARCHAR(20),
  date_embauche DATE,
  date_depart DATE,
  service_nom VARCHAR(32),
  FOREIGN KEY (voyageur_id) REFERENCES voyageurs(id)
);

CREATE TABLE trajets (
  id INT PRIMARY KEY,
  voyageur_id INT,
  date_validation_entree DATETIME,
  station_entree_id INT,
  date_validation_sortie DATETIME,
  station_sortie_id INT,
  FOREIGN KEY (voyageur_id) REFERENCES voyageurs(id),
  FOREIGN KEY (station_entree_id) REFERENCES stations(id),
  FOREIGN KEY (station_sortie_id) REFERENCES stations(id)
);

CREATE TABLE zones_tarifaires (
  id INT PRIMARY KEY,
  numero_ordre INT,
  nom VARCHAR(32),
  prix FLOAT
);

CREATE TABLE forfaits (
  code VARCHAR(5) PRIMARY KEY,
  nom VARCHAR(32),
  prix_mois DECIMAL(10, 2),
  duree INT,
  zone_min INT,
  zone_max INT
);

CREATE TABLE abonnements (
  id INT PRIMARY KEY,
  utilisateur_id INT,
  forfait_code VARCHAR(5),
  statut VARCHAR(32),
  date_abonnement DATE,
  FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id),
  FOREIGN KEY (forfait_code) REFERENCES forfaits(code)
);
