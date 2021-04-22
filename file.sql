-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 22 avr. 2021 à 21:03
-- Version du serveur :  10.4.14-MariaDB
-- Version de PHP : 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `le.v_stream`
--

-- --------------------------------------------------------

--
-- Structure de la table `entrepot_concess`
--

CREATE TABLE `entrepot_concess` (
  `1` int(11) NOT NULL,
  `nom` longtext DEFAULT NULL,
  `model` longtext DEFAULT NULL,
  `prix` longtext DEFAULT NULL,
  `plaque` longtext DEFAULT NULL,
  `attribuer` int(11) DEFAULT 0,
  `identite` longtext DEFAULT '',
  `color1` longtext DEFAULT '',
  `color2` longtext DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `joueur_vehicules` (
  `license` longtext NOT NULL DEFAULT '',
  `identite` mediumtext NOT NULL DEFAULT '',
  `propriete` longtext NOT NULL,
  `plaque` varchar(50) DEFAULT NULL,
  `etat` int(11) NOT NULL DEFAULT 0,
  `garage` text DEFAULT '',
  `rob` int(11) NOT NULL DEFAULT 0,
  `partage` longtext DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
COMMIT;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `entrepot_concess`
--
ALTER TABLE `entrepot_concess`
  ADD PRIMARY KEY (`1`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `entrepot_concess`
--
ALTER TABLE `entrepot_concess`
  MODIFY `1` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
