CREATE SCHEMA `blog`;

CREATE  TABLE `blog`.`Articles` (
  `idnew_table` INT NOT NULL AUTO_INCREMENT ,
  `Titre` VARCHAR(45) NOT NULL ,
  `Texte` LONGTEXT NOT NULL ,
  `Snippet` LONGTEXT NOT NULL ,
  `Date` DATE NOT NULL ,
  `Iduser` VARCHAR(45) NOT NULL ,
  `Idcategorie` INT NOT NULL ,
  PRIMARY KEY (`idnew_table`) );

  CREATE  TABLE `blog`.`Users` (
  `idUsers` INT NOT NULL AUTO_INCREMENT,
  `Identifiant` VARCHAR(45) NOT NULL ,
  `Email` VARCHAR(100) NOT NULL ,
  `Mot de passe` CHAR(45) CHARACTER SET 'ascii' NOT NULL ,
  `Role` INT NOT NULL ,
  PRIMARY KEY (`idUsers`) );

  CREATE  TABLE `blog`.`Catégorie` (
  `idCatégorie` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL ,
  `Description` VARCHAR(200) NULL ,
  PRIMARY KEY (`idCatégorie`) );

CREATE  TABLE `blog`.`Commentaires` (
  `idCommentaires` INT NOT NULL AUTO_INCREMENT ,
  `Iduser` VARCHAR(45) NOT NULL ,
  `Content` VARCHAR(1000) NOT NULL ,
  `DATE` DATE NOT NULL ,
  `parent_id` INT NOT NULL ,
  PRIMARY KEY (`idCommentaires`) );

  CREATE  TABLE `blog`.`Images` (
  `idImages` INT NOT NULL AUTO_INCREMENT,
  `Url` VARCHAR(500) NOT NULL ,
  `Idarticle` INT NOT NULL ,
  PRIMARY KEY (`idImages`) );

CREATE  TABLE `blog`.`Association` (
  `idAssociation` INT NOT NULL AUTO_INCREMENT,
  `Idarticle` INT NOT NULL ,
  `Idcategorie` INT NOT NULL ,
  PRIMARY KEY (`idAssociation`) );

-- /foreign key
ALTER TABLE `blog`.`Articles` CHANGE COLUMN `Iduser` `Iduser` INT NOT NULL  , 
  ADD CONSTRAINT `Iduser`
  FOREIGN KEY (`Iduser` )
  REFERENCES `blog`.`Users` (`idUsers` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `Iduser_idx` (`Iduser` ASC) ;

ALTER TABLE `blog`.`Articles` 
  ADD CONSTRAINT `Idcategorie`
  FOREIGN KEY (`Idcategorie` )
  REFERENCES `blog`.`Catégorie` (`idCatégorie` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `Idcategorie_idx` (`Idcategorie` ASC) ;

ALTER TABLE `blog`.`Commentaires` CHANGE COLUMN `Iduser` `Iduser` INT NOT NULL  , 
  ADD CONSTRAINT `Idusercom`
  FOREIGN KEY (`Iduser` )
  REFERENCES `blog`.`Users` (`idUsers` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `Iduser_idx` (`Iduser` ASC) ;

ALTER TABLE `blog`.`Images` 
  ADD CONSTRAINT `Idarticle`
  FOREIGN KEY (`Idarticle` )
  REFERENCES `blog`.`Articles` (`idnew_table` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `Idarticle_idx` (`Idarticle` ASC) ;


-- / 
ALTER TABLE `blog`.`Association` 
  ADD CONSTRAINT `Idarticle_ass`
  FOREIGN KEY (`Idarticle` )
  REFERENCES `blog`.`Articles` (`idnew_table` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION, 
  ADD CONSTRAINT `Idcategorie_ass`
  FOREIGN KEY (`Idcategorie` )
  REFERENCES `blog`.`Catégorie` (`idCatégorie` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `Idcategorie_ass_idx` (`Idcategorie` ASC) 
, ADD INDEX `Idarticle_ass_idx` (`Idarticle` ASC) ;

-- /
ALTER TABLE `blog`.`Association` 
ADD INDEX `Idarticle_ass_idx` (`Idarticle` ASC) 
, DROP INDEX `Idarticle_ass_idx` ;

ALTER TABLE `blog`.`Commentaires` ADD COLUMN `article_id` INT NOT NULL  AFTER `parent_id` , 
  ADD CONSTRAINT `article_id`
  FOREIGN KEY (`article_id` )
  REFERENCES `blog`.`Articles` (`idnew_table` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `article_id_idx` (`article_id` ASC) ;