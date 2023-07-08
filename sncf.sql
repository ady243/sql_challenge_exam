1. Table `Stations` :

CREATE TABLE Stations (
    StationID INT PRIMARY KEY,
    Nom VARCHAR(100),
    Adresse VARCHAR(200)
);


2 Table `ligne` :

CREATE TABLE Lignes (
    LigneID INT PRIMARY KEY,
    Nom VARCHAR(50)
);

3 Table `Horaires` :

CREATE TABLE Horaires (
    HoraireID INT PRIMARY KEY,
    LigneID INT,
    StationID INT,
    HeureDepart TIME,
    FOREIGN KEY (LigneID) REFERENCES Lignes(LigneID),
    FOREIGN KEY (StationID) REFERENCES Stations(StationID)
);


# Pour ajouter 
INSERT INTO Stations (StationID, Nom, Adresse) VALUES (1, 'Station A', '123 rue ABC');


# Pour modifier

UPDATE Stations SET Adresse = '456 rue DEF' WHERE StationID = 1;

# Pour supprimer

DELETE FROM Stations WHERE StationID = 1;

# Pour afficher

SELECT * FROM Stations;

# Créons une vue qui donne les horaires de départ pour une ligne donnée.

CREATE VIEW VueHoraires AS
SELECT L.Nom AS Ligne, S.Nom AS Station, H.HeureDepart
FROM Horaires H
JOIN Lignes L ON H.LigneID = L.LigneID
JOIN Stations S ON H.StationID = S.StationID;


# Créons une fonction qui compte le nombre de stations pour une ligne donnée.

CREATE FUNCTION NombreStations(@LigneID INT)
RETURNS INT AS
BEGIN
    RETURN (SELECT COUNT(DISTINCT StationID) FROM Horaires WHERE LigneID =
@LigneID)
END;

# Créons un déclencheur qui empêche la suppression d'une station s'il y a des horaires de départ associés.

CREATE TRIGGER EmpêcherSuppressionStation
ON Stations
FOR DELETE AS
BEGIN
    IF EXISTS (SELECT 1 FROM Horaires WHERE StationID = DELETED.StationID)
    BEGIN
        RAISERROR ('Une station avec des horaires associés ne peut pas être supprimée', 16,
        1);
        ROLLBACK TRANSACTION;
   END
END; 