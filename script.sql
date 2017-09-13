CREATE SCHEMA `sales`;
CREATE TABLE `sales`.`items_sold` (
`id` INT NOT NULL AUTO_INCREMENT,
`date` DATE NOT NULL,
`description` VARCHAR(45) NOT NULL,
`total` DOUBLE NOT NULL,
`imported_filename` VARCHAR(45) NOT NULL,
PRIMARY KEY (`id`));
