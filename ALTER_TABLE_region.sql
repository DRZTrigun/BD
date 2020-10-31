ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `region_id` `id` INT NOT NULL DEFAULT 0000000 ,
ADD PRIMARY KEY (`id`);

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `id` `id` INT NOT NULL AUTO_INCREMENT ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `country_id` `country_id` INT NOT NULL DEFAULT 0 ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_ru` `title_ru` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_ua` `title_ua` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_be` `title_be` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_en` `title_en` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_es` `title_es` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_pt` `title_pt` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_de` `title_de` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_fr` `title_fr` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_it` `title_it` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_pl` `title_pl` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_ja` `title_ja` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_lt` `title_lt` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_lv` `title_lv` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `title_cz` `title_cz` VARCHAR(150) NOT NULL ;

ALTER TABLE `geodata`.`_regions` 
DROP COLUMN `title_cz`,
DROP COLUMN `title_lv`,
DROP COLUMN `title_lt`,
DROP COLUMN `title_ja`,
DROP COLUMN `title_pl`,
DROP COLUMN `title_it`,
DROP COLUMN `title_fr`,
DROP COLUMN `title_de`,
DROP COLUMN `title_pt`,
DROP COLUMN `title_es`,
DROP COLUMN `title_en`,
DROP COLUMN `title_be`,
DROP COLUMN `title_ua`;

ALTER TABLE `geodata`.`_regions` 
ADD INDEX `title_ru_region_index` (`title_ru` ASC) VISIBLE;
;

ALTER TABLE `geodata`.`_regions` 
ADD INDEX `fk_country_id_idx` (`country_id` ASC) VISIBLE;
;
ALTER TABLE `geodata`.`_regions` 
ADD CONSTRAINT `fk_country_id`
  FOREIGN KEY (`country_id`)
  REFERENCES `geodata`.`_countries` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `geodata`.`_regions` 
ADD UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE;
;

ALTER TABLE `geodata`.`_regions` 
DROP FOREIGN KEY `fk_country_id`;
ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `country_id` `country_id` INT NOT NULL ;
ALTER TABLE `geodata`.`_regions` 
ADD CONSTRAINT `fk_country_id`
  FOREIGN KEY (`country_id`)
  REFERENCES `geodata`.`_countries` (`id`);
