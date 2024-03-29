/*RESET AND CREATION SECTION*/
DROP DATABASE IF EXISTS groupomania;
CREATE DATABASE IF NOT EXISTS groupomania;
USE groupomania;

SET NAMES utf8;

DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS thumbs;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `prenom` varchar(128) NOT NULL,
  `nom` varchar(128) NOT NULL,
  `email` varchar(128) UNIQUE NOT NULL,
  `password` varchar(64) NOT NULL,
  `image` varchar(256) NOT NULL DEFAULT 'default-pp.jpg',
  `admin` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

CREATE TABLE `posts` (
  `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` smallint UNSIGNED NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `image` varchar(256),
  `categoryId` smallint UNSIGNED NOT NULL,
  `likes` smallint UNSIGNED NOT NULL DEFAULT 0,
  `dislikes` smallint UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

CREATE TABLE `comments` (
  `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` smallint UNSIGNED NOT NULL,
  `postId` smallint UNSIGNED NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `thumbs`
--

CREATE TABLE `thumbs` (
  `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` SMALLINT UNSIGNED NOT NULL,
  `postId` smallint UNSIGNED NOT NULL,
  `liked` tinyint UNSIGNED DEFAULT 0,
  `disliked` tinyint UNSIGNED DEFAULT 0,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contraintes pour la table `posts`
--
ALTER TABLE `posts` ADD CONSTRAINT `fk_userId_posts` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_postId_comments` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_userId_comments` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `thumbs`
--
ALTER TABLE `thumbs`
  ADD CONSTRAINT `fk_postId_thumbs` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_userId_thumbs` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;
