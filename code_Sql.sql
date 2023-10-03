-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema HOTEL2
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `HOTEL2` ;

-- -----------------------------------------------------
-- Schema HOTEL2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `HOTEL2` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `HOTEL2` ;

-- -----------------------------------------------------
-- Table `HOTEL2`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Employee` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Employee` (
  `ID` INT NOT NULL,
  `Fname` VARCHAR(15) NOT NULL,
  `Minit` CHAR(1) NOT NULL,
  `Lname` VARCHAR(15) NOT NULL,
  `Brith Date` DATE NOT NULL,
  `Phone` VARCHAR(20) NOT NULL,
  `Works_hours` INT NOT NULL,
  `Address` VARCHAR(70) NOT NULL,
  `Sex` ENUM('M', 'F') NULL,
  `Salary` FLOAT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `jop_type` VARCHAR(45) NOT NULL,
  `manager_ID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Employee_Employee1_idx` (`manager_ID` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  CONSTRAINT `fk_Employee_Employee1`
    FOREIGN KEY (`manager_ID`)
    REFERENCES `HOTEL2`.`Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Receptionist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Receptionist` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Receptionist` (
  `Typing_speed` INT NOT NULL,
  `Attitude` ENUM('1', '2', '3', '4', '5') NOT NULL,
  `Employee_ID` INT NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  INDEX `fk_Receptionist_Employee1_idx` (`Employee_ID` ASC),
  CONSTRAINT `fk_Receptionist_Employee1`
    FOREIGN KEY (`Employee_ID`)
    REFERENCES `HOTEL2`.`Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Room_service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Room_service` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Room_service` (
  `Service_jop` VARCHAR(45) NOT NULL,
  `Employee_ID` INT NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  CONSTRAINT `fk_Room_service_Employee1`
    FOREIGN KEY (`Employee_ID`)
    REFERENCES `HOTEL2`.`Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`services` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`services` (
  `no` INT NOT NULL,
  `service_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`no`, `service_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Restaurant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Restaurant` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Restaurant` (
  `services_no` INT NOT NULL,
  `services_service_name` VARCHAR(45) NOT NULL,
  `total_Price` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`services_no`, `services_service_name`),
  CONSTRAINT `fk_Restaurant_services1`
    FOREIGN KEY (`services_no` , `services_service_name`)
    REFERENCES `HOTEL2`.`services` (`no` , `service_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Kitchen_worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Kitchen_worker` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Kitchen_worker` (
  `Position` VARCHAR(45) NOT NULL,
  `Employee_ID` INT NOT NULL,
  `Restaurant_services_no` INT NOT NULL,
  `Restaurant_services_service_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`),
  INDEX `fk_Kitchen_worker_Employee1_idx` (`Employee_ID` ASC),
  INDEX `fk_Kitchen_worker_Restaurant1_idx` (`Restaurant_services_no` ASC, `Restaurant_services_service_name` ASC),
  CONSTRAINT `fk_Kitchen_worker_Employee1`
    FOREIGN KEY (`Employee_ID`)
    REFERENCES `HOTEL2`.`Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kitchen_worker_Restaurant1`
    FOREIGN KEY (`Restaurant_services_no` , `Restaurant_services_service_name`)
    REFERENCES `HOTEL2`.`Restaurant` (`services_no` , `services_service_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Hall` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Hall` (
  `services_no` INT NOT NULL,
  `services_service_name` VARCHAR(45) NOT NULL,
  `No_of_people` INT NOT NULL,
  `Price` DOUBLE NOT NULL,
  `occasion_type` VARCHAR(45) NULL,
  PRIMARY KEY (`services_no`, `services_service_name`),
  INDEX `fk_Hall_services1_idx` (`services_no` ASC, `services_service_name` ASC),
  CONSTRAINT `fk_Hall_services1`
    FOREIGN KEY (`services_no` , `services_service_name`)
    REFERENCES `HOTEL2`.`services` (`no` , `service_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Hall_worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Hall_worker` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Hall_worker` (
  `job_type` VARCHAR(40) NOT NULL,
  `Employee_ID1` INT NOT NULL,
  `Hall_services_no` INT NOT NULL,
  `Hall_services_service_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Employee_ID1`, `Hall_services_no`, `Hall_services_service_name`),
  INDEX `fk_Hall_worker_Employee1_idx` (`Employee_ID1` ASC),
  INDEX `fk_Hall_worker_Hall1_idx` (`Hall_services_no` ASC, `Hall_services_service_name` ASC),
  CONSTRAINT `fk_Hall_worker_Employee1`
    FOREIGN KEY (`Employee_ID1`)
    REFERENCES `HOTEL2`.`Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hall_worker_Hall1`
    FOREIGN KEY (`Hall_services_no` , `Hall_services_service_name`)
    REFERENCES `HOTEL2`.`Hall` (`services_no` , `services_service_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Client` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Client` (
  `SSN` INT NOT NULL,
  `Fname` VARCHAR(15) NOT NULL,
  `Minit` CHAR(1) NOT NULL,
  `Lname` VARCHAR(15) NOT NULL,
  `Brith Date` DATE NOT NULL,
  `Phone` VARCHAR(14) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Sex` ENUM('M', 'F') NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SSN`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Companion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Companion` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Companion` (
  `Name` VARCHAR(45) NOT NULL,
  `Age` INT NOT NULL,
  `Relationship` VARCHAR(45) NOT NULL,
  `Client_SSN` INT NOT NULL,
  PRIMARY KEY (`Client_SSN`, `Name`),
  CONSTRAINT `fk_Companion_Client`
    FOREIGN KEY (`Client_SSN`)
    REFERENCES `HOTEL2`.`Client` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Room` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Room` (
  `services_no` INT NOT NULL,
  `services_service_name` VARCHAR(45) NOT NULL,
  `floor` INT NOT NULL,
  `Phone` VARCHAR(14) NOT NULL,
  `Price` VARCHAR(10) NOT NULL,
  `Statue` TINYINT(1) NOT NULL,
  `Type_by_beds` ENUM('single', 'double') NOT NULL,
  `Type_by_size` ENUM('standard', 'delux', 'suite', 'apartment') NOT NULL,
  PRIMARY KEY (`services_no`, `services_service_name`),
  CONSTRAINT `fk_Room_services1`
    FOREIGN KEY (`services_no` , `services_service_name`)
    REFERENCES `HOTEL2`.`services` (`no` , `service_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '															';


-- -----------------------------------------------------
-- Table `HOTEL2`.`Bill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Bill` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Bill` (
  `No` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Payment_method` VARCHAR(45) NOT NULL,
  `Payed_money` VARCHAR(15) NOT NULL,
  `Total_price` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`No`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`boook_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`boook_info` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`boook_info` (
  `book_no` INT NOT NULL,
  `check_in_date` VARCHAR(45) NOT NULL,
  `check_out_date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`book_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Books` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Books` (
  `Bill_No` INT NOT NULL,
  `Client_SSN` INT NOT NULL,
  `Receptionist_Employee_ID` INT NOT NULL,
  `boook_info_book_no` INT NOT NULL,
  `services_no` INT NOT NULL,
  `services_service_name` VARCHAR(45) NOT NULL,
  INDEX `fk_Books_Bill1_idx` (`Bill_No` ASC),
  INDEX `fk_Books_Client1_idx` (`Client_SSN` ASC),
  INDEX `fk_Books_Receptionist1_idx` (`Receptionist_Employee_ID` ASC),
  PRIMARY KEY (`boook_info_book_no`, `Bill_No`, `services_no`, `services_service_name`),
  INDEX `fk_Books_services1_idx` (`services_no` ASC, `services_service_name` ASC),
  CONSTRAINT `fk_Books_Bill1`
    FOREIGN KEY (`Bill_No`)
    REFERENCES `HOTEL2`.`Bill` (`No`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Books_Client1`
    FOREIGN KEY (`Client_SSN`)
    REFERENCES `HOTEL2`.`Client` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Books_Receptionist1`
    FOREIGN KEY (`Receptionist_Employee_ID`)
    REFERENCES `HOTEL2`.`Receptionist` (`Employee_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Books_boook_info1`
    FOREIGN KEY (`boook_info_book_no`)
    REFERENCES `HOTEL2`.`boook_info` (`book_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Books_services1`
    FOREIGN KEY (`services_no` , `services_service_name`)
    REFERENCES `HOTEL2`.`services` (`no` , `service_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '															';


-- -----------------------------------------------------
-- Table `HOTEL2`.`Language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Language` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Language` (
  `Language` VARCHAR(45) NOT NULL,
  `Receptionist_ID` INT NOT NULL,
  PRIMARY KEY (`Language`, `Receptionist_ID`),
  INDEX `fk_Language_Receptionist1_idx` (`Receptionist_ID` ASC),
  CONSTRAINT `fk_Language_Receptionist1`
    FOREIGN KEY (`Receptionist_ID`)
    REFERENCES `HOTEL2`.`Receptionist` (`Employee_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`menu` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`menu` (
  `Restaurant_services_no` INT NOT NULL,
  `Restaurant_services_service_name` VARCHAR(45) NOT NULL,
  `Main_course` VARCHAR(45) NULL,
  `appetizer` VARCHAR(45) NULL,
  `Drink` VARCHAR(45) NULL,
  `price` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Restaurant_services_no`, `Restaurant_services_service_name`),
  CONSTRAINT `fk_menu_Restaurant1`
    FOREIGN KEY (`Restaurant_services_no` , `Restaurant_services_service_name`)
    REFERENCES `HOTEL2`.`Restaurant` (`services_no` , `services_service_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`Room_service_work_at_Room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`Room_service_work_at_Room` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`Room_service_work_at_Room` (
  `Room_services_no` INT NOT NULL,
  `Room_services_service_name` VARCHAR(45) NOT NULL,
  `Room_service_Employee_ID` INT NOT NULL,
  PRIMARY KEY (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`),
  INDEX `fk_Room_service_has_Room_Room_service1_idx` (`Room_service_Employee_ID` ASC),
  INDEX `fk_Room_service_work_at_Room_Room1_idx` (`Room_services_no` ASC, `Room_services_service_name` ASC),
  CONSTRAINT `fk_Room_service_has_Room_Room_service1`
    FOREIGN KEY (`Room_service_Employee_ID`)
    REFERENCES `HOTEL2`.`Room_service` (`Employee_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_service_work_at_Room_Room1`
    FOREIGN KEY (`Room_services_no` , `Room_services_service_name`)
    REFERENCES `HOTEL2`.`Room` (`services_no` , `services_service_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOTEL2`.`additional_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOTEL2`.`additional_services` ;

CREATE TABLE IF NOT EXISTS `HOTEL2`.`additional_services` (
  `no` INT NOT NULL,
  `price` VARCHAR(45) NOT NULL,
  `Books_Bill_No` INT NOT NULL,
  PRIMARY KEY (`no`),
  INDEX `fk_additional_services_Books1_idx` (`Books_Bill_No` ASC),
  CONSTRAINT `fk_additional_services_Books1`
    FOREIGN KEY (`Books_Bill_No`)
    REFERENCES `HOTEL2`.`Books` (`Bill_No`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122251, 'Rosemaria', 'M', 'Trunkfield', '1985-04-03', '140-408-5130', 8, '71 Del Mar Street', 'F', 5461, 'rtrunkfield0@bashir.com', 'qroICq', 'Receptionist', NULL);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122281, 'Sandor', 'A', 'Nelle', '1981-03-29', '118-118-6531', 8, '862 Schiller Junction', 'M', 5593, 'snelle1@bashir.com', 'VliTrr5', 'Receptionist', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122259, 'Eddie', 'C', 'Berge', '1993-02-15', '140-675-1166', 8, '1361 Becker Court', 'M', 4656, 'eberge2@bashir.com', 'ivqEjxIps', 'Receptionist', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122218, 'Reinwald', 'X', 'Keeler', '1999-07-02', '691-893-3568', 8, '6136 Merchant Avenue', 'M', 4758, 'rkeeler3@bashir.com', '5U2fT1', 'kitchen', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122231, 'Gilbert', 'A', 'Windress', '1999-03-02', '939-862-1018', 8, '23405 Atwood Point', 'M', 5257, 'gwindress4@bashir.com', 'm4BsZoPo5v', 'kitchen', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122236, 'Tiffany', 'G', 'Padilla', '2000-08-14', '344-451-5566', 8, '61 Blue Bill Park Junction', 'F', 6328, 'tpadilla5@bashir.com', '95iqJgBj10t', 'kitchen', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122249, 'Brynna', 'M', 'Courson', '1999-09-25', '235-337-8795', 8, '40251 Redwing Point', 'F', 5685, 'bcourson6@bashir.com', 'UcDRlQ', 'kitchen', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122298, 'Maridel', 'M', 'Linsay', '1985-03-22', '946-301-3578', 8, '9518 Cambridge Avenue', 'F', 4879, 'mlinsay7@bashir.com', 'EkgnRu4M4', 'kitchen', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122295, 'Boniface', 'L', 'Mallender', '1986-12-05', '969-757-5259', 8, '523 Mendota Place', 'M', 5174, 'bmallender8@bashir.com', 'gv7RjgsSr', 'room service', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122297, 'Tabby', 'M', 'Slorance', '1995-02-07', '735-199-1853', 8, '2 Carioca Street', 'M', 6829, 'tslorance9@bashir.com', 'KG645zow', 'room service', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122245, 'Franz', 'M', 'Passingham', '1983-06-10', '243-499-3186', 8, '4 Melvin Place', 'M', 5830, 'fpassinghama@bashir.com', 'aGJPaClCn', 'room service', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122284, 'Delainey', 'X', 'Liggons', '1992-07-06', '562-535-8171', 8, '955 Green Plaza', 'M', 4418, 'dliggonsb@bashir.com', 'qPqOsakeWg', 'room service', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122270, 'Rockwell', 'G', 'Chansonne', '1997-08-20', '310-767-1504', 8, '47685 Old Shore Pass', 'M', 6713, 'rchansonnec@bashir.com', 'dr66mz', 'hall', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122290, 'Morly', 'S', 'Jordan', '1983-04-16', '814-952-6687', 8, '7598 Namekagon Crossing', 'M', 4015, 'mjordand@bashir.com', '1PzkpvSwRd', 'hall', 11122251);
INSERT INTO `HOTEL2`.`Employee` (`ID`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Works_hours`, `Address`, `Sex`, `Salary`, `email`, `password`, `jop_type`, `manager_ID`) VALUES (11122260, 'Elsinore', 'S', 'Tumilson', '1986-06-19', '169-401-2477', 8, '3 Meadow Vale Lane', 'F', 4515, 'etumilsone@bashir.com', 'SjWSzZhyUf', 'hall', 11122251);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Receptionist`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Receptionist` (`Typing_speed`, `Attitude`, `Employee_ID`) VALUES (50, '5', 11122251);
INSERT INTO `HOTEL2`.`Receptionist` (`Typing_speed`, `Attitude`, `Employee_ID`) VALUES (40, '4', 11122281);
INSERT INTO `HOTEL2`.`Receptionist` (`Typing_speed`, `Attitude`, `Employee_ID`) VALUES (30, '3', 11122259);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Room_service`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Room_service` (`Service_jop`, `Employee_ID`) VALUES ('Cleaner', 11122295);
INSERT INTO `HOTEL2`.`Room_service` (`Service_jop`, `Employee_ID`) VALUES ('Cleaner', 11122297);
INSERT INTO `HOTEL2`.`Room_service` (`Service_jop`, `Employee_ID`) VALUES ('cupboard', 11122245);
INSERT INTO `HOTEL2`.`Room_service` (`Service_jop`, `Employee_ID`) VALUES ('bed', 11122284);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`services`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (1, 'hall');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (2, 'hall');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (3, 'hall');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (4, 'hall');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (5, 'hall');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (1, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (2, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (3, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (4, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (5, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (6, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (7, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (8, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (9, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (10, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (11, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (12, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (13, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (14, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (15, 'Restaurant');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (101, 'Room');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (102, 'Room');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (103, 'Room');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (104, 'Room');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (201, 'Room');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (202, 'Room');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (203, 'Room');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (204, 'Room');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (301, 'Room');
INSERT INTO `HOTEL2`.`services` (`no`, `service_name`) VALUES (302, 'Room');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Restaurant`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (1, 'Restaurant', '10$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (2, 'Restaurant', '50$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (3, 'Restaurant', '100$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (4, 'Restaurant', '120$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (5, 'Restaurant', '150$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (6, 'Restaurant', '70$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (7, 'Restaurant', '50$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (8, 'Restaurant', '40$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (9, 'Restaurant', '12$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (10, 'Restaurant', '180$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (11, 'Restaurant', '170$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (12, 'Restaurant', '190$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (13, 'Restaurant', '120$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (14, 'Restaurant', '17$');
INSERT INTO `HOTEL2`.`Restaurant` (`services_no`, `services_service_name`, `total_Price`) VALUES (15, 'Restaurant', '20$');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Kitchen_worker`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122218, 1, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef assisstant', 11122231, 2, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('waiter', 11122236, 3, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 4, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('waiter', 11122298, 5, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('waiter', 11122298, 6, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 7, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 8, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 9, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 10, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 11, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 12, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 13, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 14, 'Restaurant');
INSERT INTO `HOTEL2`.`Kitchen_worker` (`Position`, `Employee_ID`, `Restaurant_services_no`, `Restaurant_services_service_name`) VALUES ('chef', 11122249, 15, 'Restaurant');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Hall`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Hall` (`services_no`, `services_service_name`, `No_of_people`, `Price`, `occasion_type`) VALUES (1, 'hall', 500, 30000, 'Wedding hall');
INSERT INTO `HOTEL2`.`Hall` (`services_no`, `services_service_name`, `No_of_people`, `Price`, `occasion_type`) VALUES (2, 'hall', 200, 3000, 'Birthday Hall');
INSERT INTO `HOTEL2`.`Hall` (`services_no`, `services_service_name`, `No_of_people`, `Price`, `occasion_type`) VALUES (3, 'hall', 500, 3000, 'celebration hall');
INSERT INTO `HOTEL2`.`Hall` (`services_no`, `services_service_name`, `No_of_people`, `Price`, `occasion_type`) VALUES (4, 'hall', 500, 5000, 'Consolation Hall');
INSERT INTO `HOTEL2`.`Hall` (`services_no`, `services_service_name`, `No_of_people`, `Price`, `occasion_type`) VALUES (5, 'hall', 300, 90000, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Hall_worker`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Hall_worker` (`job_type`, `Employee_ID1`, `Hall_services_no`, `Hall_services_service_name`) VALUES ('receptionist', 11122270, 1, 'hall');
INSERT INTO `HOTEL2`.`Hall_worker` (`job_type`, `Employee_ID1`, `Hall_services_no`, `Hall_services_service_name`) VALUES ('manger', 11122290, 2, 'hall');
INSERT INTO `HOTEL2`.`Hall_worker` (`job_type`, `Employee_ID1`, `Hall_services_no`, `Hall_services_service_name`) VALUES ('hall_music', 11122260, 3, 'hall');
INSERT INTO `HOTEL2`.`Hall_worker` (`job_type`, `Employee_ID1`, `Hall_services_no`, `Hall_services_service_name`) VALUES ('receptionist', 11122270, 4, 'hall');
INSERT INTO `HOTEL2`.`Hall_worker` (`job_type`, `Employee_ID1`, `Hall_services_no`, `Hall_services_service_name`) VALUES ('light', 11122290, 5, 'hall');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Client`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522214, 'Berny', 'L', 'Cottell', '1986-06-01', '502-284-4785', '155 Beilfuss Center', 'M', 'bcottell0@bashir.com', 'niwVtH');
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522243, 'Mignonne', 'X', 'Guslon', '1975-05-18', '846-960-9156', '631 Esch Drive', 'F', 'mguslon1@bashir.com', 'r8Gce28');
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522211, 'Tanhya', 'M', 'Lydiate', '1978-02-18', '274-330-9877', '1 Mandrake Plaza', 'F', 'tlydiate2@bashir.com', 'qXk68GVnTv');
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522246, 'Andres', 'A', 'Lavens', '1985-12-13', '617-959-9161', '26 Lakewood Gardens Hill', 'M', 'alavens3@bashir.com', 'jnmrqB1R');
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522223, 'Nickolaus', 'S', 'Shimony', '2001-05-17', '687-392-2747', '5 Esker Way', 'M', 'nshimony4@bashir.com', 'JMh6nX0ou');
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522297, 'Lazaro', 'Y', 'Cantera', '1978-07-28', '743-994-5940', '43 Grover Avenue', 'M', 'lcantera5@bashir.com', '6MgxYNhDM');
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522238, 'Keen', 'M', 'Skillicorn', '1971-01-12', '905-728-6466', '545 Graceland Center', 'M', 'kskillicorn6@bashir.com', '2D10Z2g');
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522224, 'Leonard', 'N', 'Bowcock', '2002-11-15', '621-760-5150', '5 Elmside Parkway', 'M', 'lbowcock7@bashir.com', 'Qj06Ay');
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522274, 'Lisabeth', 'B', 'Finder', '1981-09-17', '480-129-5578', '364 Sugar Crossing', 'F', 'lfinder8@bashir.com', 'FyecWnzk76Tg');
INSERT INTO `HOTEL2`.`Client` (`SSN`, `Fname`, `Minit`, `Lname`, `Brith Date`, `Phone`, `Address`, `Sex`, `email`, `password`) VALUES (55522287, 'Clair', 'M', 'Glasard', '1986-12-01', '933-706-1062', '7 Sugar Court', 'F', 'cglasard9@bashir.com', 'SLsLbE');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Companion`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Ciel Mangeney', 7, 'son', 55522214);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Hermy Tieraney', 15, 'daughter', 55522214);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Daphne Rawe', 20, 'son', 55522243);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Rudolf Piken', 17, 'son', 55522243);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Chevy Whatmough', 33, 'wife', 55522243);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Mair Dinnington', 8, 'son', 55522211);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Flory Lusty', 73, 'wife', 55522246);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Adoree Cawsy', 72, 'son', 55522223);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Aile Benham', 30, 'daughter', 55522223);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Nealy Gabbitas', 11, 'son', 55522223);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Jenna Orpin', 50, 'wife', 55522297);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Ricoriki Bromby', 71, 'son', 55522238);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Gwenore Daubeny', 8, 'daughter', 55522238);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Granger Josefsson', 21, 'son', 55522238);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Claire Hedworth', 68, 'brother', 55522238);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Jaye Collihole', 36, 'wife', 55522224);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Ingunna Coleford', 72, 'brother', 55522274);
INSERT INTO `HOTEL2`.`Companion` (`Name`, `Age`, `Relationship`, `Client_SSN`) VALUES ('Boonie Beardwell', 5, 'daughter', 55522287);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Room`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (101, 'Room', 1, '(110) 3591688', '$86.95', true, 'single', 'delux');
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (102, 'Room', 1, '(341) 1594957', '$140.38', true, 'single', 'standard');
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (103, 'Room', 1, '(820) 9095759', '$80.94', true, 'double', 'delux');
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (104, 'Room', 1, '(760) 4373524', '$87.94', true, 'double', 'standard');
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (201, 'Room', 2, '(705) 7050035', '$102.71', true, 'single', 'standard');
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (202, 'Room', 2, '(540) 9000469', '$78.97', true, 'single', 'delux');
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (203, 'Room', 2, '(226) 5607813', '$126.26', false, 'double', 'standard');
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (204, 'Room', 2, '(243) 6605800', '$76.70', false, 'double', 'delux');
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (301, 'Room', 3, '(334) 2230443', '$96.92', false, 'single', 'suite');
INSERT INTO `HOTEL2`.`Room` (`services_no`, `services_service_name`, `floor`, `Phone`, `Price`, `Statue`, `Type_by_beds`, `Type_by_size`) VALUES (302, 'Room', 2, '(502) 9369017', '$113.63', false, 'double', 'apartment');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Bill`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3001, '2019-03-24', 'jcb', '$739.74', '$4159.33');
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3002, '2019-10-12', 'jcb', '$550.34', '$2019.27');
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3003, '2019-06-15', 'jcb', '$554.81', '$3626.85');
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3004, '2018-12-21', 'bankcard', '$932.10', '$4311.52');
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3005, '2019-09-02', 'jcb', '$514.53', '$1738.26');
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3006, '2019-07-04', 'maestro', '$908.34', '$3970.04');
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3007, '2019-09-07', 'americanexpress', '$927.83', '$2348.70');
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3008, '2019-04-30', 'diners-club-carte-blanche', '$414.09', '$3280.68');
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3009, '2019-10-15', 'visa', '$848.96', '$3275.73');
INSERT INTO `HOTEL2`.`Bill` (`No`, `Date`, `Payment_method`, `Payed_money`, `Total_price`) VALUES (3010, '2019-09-13', 'maestro', '$592.55', '$2027.22');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`boook_info`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (1, '2019-03-21', '2019-11-20');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (2, '2019-05-17', '2019-11-17');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (3, '2019-04-02', '2019-07-15');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (4, '2019-03-29', '2019-07-08');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (5, '2019-05-08', '2019-10-30');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (6, '2019-04-09', '2019-10-01');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (7, '2019-01-03', '2019-08-05');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (8, '2019-05-18', '2019-09-19');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (9, '2019-01-11', '2019-10-02');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (10, '2019-03-09', '2019-07-06');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (11, '2019-05-09', '2019-10-24');
INSERT INTO `HOTEL2`.`boook_info` (`book_no`, `check_in_date`, `check_out_date`) VALUES (12, '2019-05-09', '2019-10-24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Books`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3001, 55522214, 11122251, 1, 202, 'Room');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3002, 55522243, 11122281, 2, 101, 'Room');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3003, 55522211, 11122259, 3, 103, 'Room');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3004, 55522246, 11122251, 4, 104, 'Room');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3005, 55522223, 11122281, 5, 201, 'Room');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3006, 55522297, 11122259, 6, 2, 'hall');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3007, 55522238, 11122251, 7, 1, 'Restaurant');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3008, 55522224, 11122281, 8, 2, 'Restaurant');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3009, 55522274, 11122259, 9, 3, 'Restaurant');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3010, 55522287, 11122270, 10, 4, 'Restaurant');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3001, 55522214, 11122251, 11, 102, 'Room');
INSERT INTO `HOTEL2`.`Books` (`Bill_No`, `Client_SSN`, `Receptionist_Employee_ID`, `boook_info_book_no`, `services_no`, `services_service_name`) VALUES (3001, 55511114, 11122251, 12, 5, 'Restaurant');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Language`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Language` (`Language`, `Receptionist_ID`) VALUES ('Danish', 11122251);
INSERT INTO `HOTEL2`.`Language` (`Language`, `Receptionist_ID`) VALUES ('Bislama', 11122251);
INSERT INTO `HOTEL2`.`Language` (`Language`, `Receptionist_ID`) VALUES ('Macedonian', 11122251);
INSERT INTO `HOTEL2`.`Language` (`Language`, `Receptionist_ID`) VALUES ('Dari', 11122281);
INSERT INTO `HOTEL2`.`Language` (`Language`, `Receptionist_ID`) VALUES ('Hebrew', 11122281);
INSERT INTO `HOTEL2`.`Language` (`Language`, `Receptionist_ID`) VALUES ('Papiamento', 11122281);
INSERT INTO `HOTEL2`.`Language` (`Language`, `Receptionist_ID`) VALUES ('Italian', 11122259);
INSERT INTO `HOTEL2`.`Language` (`Language`, `Receptionist_ID`) VALUES ('Tajik', 11122259);
INSERT INTO `HOTEL2`.`Language` (`Language`, `Receptionist_ID`) VALUES ('Assamese', 11122259);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (1, 'Restaurant', 'Chicken', 'nuts', 'Coal', '$42.46');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (2, 'Restaurant', 'Garden', 'Skylark', 'Loyale', '$20.84');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (3, 'Restaurant', 'Movies', 'Sonoma', 'Rondo', '$98.81');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (4, 'Restaurant', 'Shoes', 'Vegetable', 'Astro', '$149.10');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (5, 'Restaurant', 'Chicken', 'Vantage', 'Firebird', '$131.60');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (6, 'Restaurant', 'Legumes', 'Vegetable', 'Café', '$26.34');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (7, 'Restaurant', 'Electronics', 'Cheese', 'Coal', '$122.03');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (8, 'Restaurant', 'Pancetta', 'fruit', 'Murano', '$124.81');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (9, 'Restaurant', 'Beauty', 'nuts', 'Tea', '$147.62');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (10, 'Restaurant', 'Automotive', 'Vegetable', 'Esperante', '$147.99');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (11, 'Restaurant', 'Legumes', 'fruit', 'Outback', '$127.20');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (12, 'Restaurant', 'Legumes', 'Cheese', 'Café', '$88.10');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (13, 'Restaurant', 'Vegetable', 'Diamante', 'juice', '$117.63');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (14, 'Restaurant', 'Chicken', 'nuts', 'juice', '$90.57');
INSERT INTO `HOTEL2`.`menu` (`Restaurant_services_no`, `Restaurant_services_service_name`, `Main_course`, `appetizer`, `Drink`, `price`) VALUES (15, 'Restaurant', 'Legumes', 'Sebring', 'Tea', '$82.85');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOTEL2`.`Room_service_work_at_Room`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOTEL2`;
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (101, 'Room', 11122295);
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (102, 'Room', 11122297);
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (103, 'Room', 11122245);
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (104, 'Room', 11122284);
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (201, 'Room', 11122295);
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (202, 'Room', 11122284);
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (203, 'Room', 11122245);
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (204, 'Room', 11122284);
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (301, 'Room', 11122295);
INSERT INTO `HOTEL2`.`Room_service_work_at_Room` (`Room_services_no`, `Room_services_service_name`, `Room_service_Employee_ID`) VALUES (202, 'Room', 11122297);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
