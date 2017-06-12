DROP TABLE IF EXISTS `chronos_db_version`;
CREATE TABLE `chronos_db_version` (
  `LastUpdate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET FOREIGN_KEY_CHECKS=1;

INSERT INTO `chronos_db_version` (`LastUpdate`) VALUES ('06_12_2017_chronos_db_version');