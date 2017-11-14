DB = Sequel.connect(adapter: :mysql2, user: 'root', host: 'localhost', database: 'guests')
GUESTS = DB[:guest]
CACHE = DB[:cache]


# CREATE TABLE `guest` (
#   `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
#   `name` varchar(80) NOT NULL DEFAULT '',
#   `pax` int(2) NOT NULL,
#   `idx` int(3) NOT NULL,
#   `list` enum('G','V') NOT NULL,
#   PRIMARY KEY (`id`),
#   UNIQUE KEY `name` (`name`),
#   KEY `idx` (`idx`)
# ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
#
# CREATE TABLE `cache` (
#   `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
#   `first` int(11) unsigned NOT NULL,
#   `second` int(11) unsigned NOT NULL,
#   `val` int(2) DEFAULT NULL,
#   PRIMARY KEY (`id`),
#   KEY `comp1` (`first`,`second`),
#   KEY `comp2` (`second`,`first`),
#   CONSTRAINT `cache_ibfk_1` FOREIGN KEY (`first`) REFERENCES `guest` (`id`),
#   CONSTRAINT `cache_ibfk_2` FOREIGN KEY (`second`) REFERENCES `guest` (`id`)
# ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
