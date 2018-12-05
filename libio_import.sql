CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(10) unsigned NOT NULL,
  `identifier` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE IF NOT EXISTS `versions` (
  `id` int(10) unsigned NOT NULL,
  `project_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `published_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TEMPORARY TABLE IF NOT EXISTS `versions_raw` (
  `id` int(10) unsigned NOT NULL,
  `platform` varchar(50) NOT NULL,
  `identifier` varchar(200) NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  `version` varchar(100) NOT NULL,
  `published_at` datetime NOT NULL,
  `found_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
);

TRUNCATE TABLE `versions_raw`;
TRUNCATE TABLE `projects`;
TRUNCATE TABLE `versions`;

LOAD DATA LOCAL INFILE '/home/user/versions-maven.csv' 
    INTO TABLE `versions_raw` CHARACTER 
    SET utf8 FIELDS TERMINATED BY ',' 
        OPTIONALLY ENCLOSED BY '"' 
        ESCAPED BY '"' 
        LINES TERMINATED BY '\n' 
        (`id`, 
        `platform`, 
        `identifier`, 
        `project_id`, 
        `version`, 
        `published_at`,
        `found_at`,
        `updated_at`
        );

INSERT INTO projects (id, identifier) 
	SELECT DISTINCT `project_id` as id, `identifier`
	FROM versions_raw;
	
	
INSERT INTO versions (id, project_id, name, published_at)
	SELECT `id`, `project_id`, `version`, `published_at`
	FROM versions_raw;
	
