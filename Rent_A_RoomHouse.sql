

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Rent_A_Room_House
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Rent_A_Room_House
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Rent_A_Room_House` DEFAULT CHARACTER SET utf8 ;
USE `Rent_A_Room_House` ;

-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`USER` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `FName` VARCHAR(45) NOT NULL,
  `LName` VARCHAR(45) NULL,
  `BirthDate` DATE NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(20) NOT NULL,
  `Gender` ENUM('Male', 'Female', 'Others') NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`LOCATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`LOCATION` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `Country` VARCHAR(100) NOT NULL,
  `STATE` VARCHAR(100) NULL,
  `City` VARCHAR(100) NULL,
  `ZipCode` VARCHAR(10) NULL,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`RENTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`RENTER` (
  `RenterID` INT NOT NULL AUTO_INCREMENT,
  `CardNumber` VARCHAR(20) NOT NULL,
  `SecurityCode` VARCHAR(5) NOT NULL,
  `NameOnCard` VARCHAR(50) NOT NULL,
  `LOCATION_LocationID` INT NOT NULL,
  `USER_userID` INT NOT NULL,
  PRIMARY KEY (`RenterID`, `LOCATION_LocationID`, `USER_userID`),
  INDEX `fk_RENTER_LOCATION1_idx` (`LOCATION_LocationID` ASC) VISIBLE,
  INDEX `fk_RENTER_USER1_idx` (`USER_userID` ASC) VISIBLE,
  CONSTRAINT `fk_RENTER_LOCATION1`
    FOREIGN KEY (`LOCATION_LocationID`)
    REFERENCES `Rent_A_Room_House`.`LOCATION` (`LocationID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_RENTER_USER1`
    FOREIGN KEY (`USER_userID`)
    REFERENCES `Rent_A_Room_House`.`USER` (`userID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OWNER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`OWNER` (
  `OwnerID` INT NOT NULL AUTO_INCREMENT,
  `BankName` VARCHAR(100) NOT NULL,
  `AccountType` ENUM('checking account', 'savings account') NOT NULL,
  `AccountNumber` VARCHAR(20) NULL,
  `USER_userID` INT NOT NULL,
  `LOCATION_LocationID` INT NOT NULL,
  PRIMARY KEY (`OwnerID`, `USER_userID`, `LOCATION_LocationID`),
  INDEX `fk_OWNER_USER1_idx` (`USER_userID` ASC) VISIBLE,
  INDEX `fk_OWNER_LOCATION1_idx` (`LOCATION_LocationID` ASC) VISIBLE,
  CONSTRAINT `fk_OWNER_USER1`
    FOREIGN KEY (`USER_userID`)
    REFERENCES `Rent_A_Room_House`.`USER` (`userID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_OWNER_LOCATION1`
    FOREIGN KEY (`LOCATION_LocationID`)
    REFERENCES `Rent_A_Room_House`.`LOCATION` (`LocationID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`FACILITIES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`FACILITIES` (
  `FacilityID` INT NOT NULL AUTO_INCREMENT,
  `BedCount` INT NULL,
  `BathCount` INT NULL,
  `FloorCount` INT NULL,
  `RoomCount` INT NULL,
  `OtherDetails` LONGTEXT NULL,
  PRIMARY KEY (`FacilityID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`UNIT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`UNIT` (
  `UnitID` INT NOT NULL AUTO_INCREMENT,
  `StreetName` VARCHAR(100) NOT NULL,
  `StreetNumber` VARCHAR(10) NULL,
  `CostPerMonth` INT NOT NULL,
  `Availability` ENUM('YES', 'NO') NOT NULL,
  `UnitType` ENUM('ROOM', 'HOUSE') NOT NULL,
  `LOCATION_LocationID` INT NOT NULL,
  `OWNER_OwnerID` INT NOT NULL,
  `FACILITIES_FacilityID` INT NOT NULL,
  PRIMARY KEY (`UnitID`, `FACILITIES_FacilityID`),
  INDEX `fk_UNIT_LOCATION1_idx` (`LOCATION_LocationID` ASC) VISIBLE,
  INDEX `fk_UNIT_OWNER1_idx` (`OWNER_OwnerID` ASC) VISIBLE,
  INDEX `fk_UNIT_FACILITIES1_idx` (`FACILITIES_FacilityID` ASC) VISIBLE,
  CONSTRAINT `fk_UNIT_LOCATION1`
    FOREIGN KEY (`LOCATION_LocationID`)
    REFERENCES `Rent_A_Room_House`.`LOCATION` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UNIT_OWNER1`
    FOREIGN KEY (`OWNER_OwnerID`)
    REFERENCES `Rent_A_Room_House`.`OWNER` (`OwnerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UNIT_FACILITIES1`
    FOREIGN KEY (`FACILITIES_FacilityID`)
    REFERENCES `Rent_A_Room_House`.`FACILITIES` (`FacilityID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`BOOKING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`BOOKING` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `BookingStatus` ENUM('Confirmed', 'Tentative', 'Waitlist') NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `TimeStamp` DATETIME(3) NOT NULL,
  `RENTER_RenterID1` INT NOT NULL,
  `UNIT_UnitID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_BOOKING_RENTER1_idx` (`RENTER_RenterID1` ASC) VISIBLE,
  INDEX `fk_BOOKING_UNIT1_idx` (`UNIT_UnitID` ASC) VISIBLE,
  CONSTRAINT `fk_BOOKING_RENTER1`
    FOREIGN KEY (`RENTER_RenterID1`)
    REFERENCES `Rent_A_Room_House`.`RENTER` (`RenterID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_BOOKING_UNIT1`
    FOREIGN KEY (`UNIT_UnitID`)
    REFERENCES `Rent_A_Room_House`.`UNIT` (`UnitID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`IMAGES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`IMAGES` (
  `ImageID` INT NOT NULL AUTO_INCREMENT,
  `Image` LONGBLOB NULL,
  `ImageCaption` MEDIUMTEXT NULL,
  `ImageSize` INT NULL,
  `ImageType` VARCHAR(45) NULL,
  PRIMARY KEY (`ImageID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`TRANSACTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`TRANSACTION` (
  `TransactionID` INT NOT NULL AUTO_INCREMENT,
  `BOOKING_BookingID` INT NOT NULL,
  `TimeStamp` TIMESTAMP(2) NOT NULL,
  `DepositAmount` INT NULL,
  `PaymentDescription` MEDIUMTEXT NULL,
  PRIMARY KEY (`TransactionID`, `BOOKING_BookingID`),
  INDEX `fk_TRANSACTION_BOOKING1_idx` (`BOOKING_BookingID` ASC) VISIBLE,
  CONSTRAINT `fk_TRANSACTION_BOOKING1`
    FOREIGN KEY (`BOOKING_BookingID`)
    REFERENCES `Rent_A_Room_House`.`BOOKING` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`REFUND`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`REFUND` (
  `RefundID` INT NOT NULL AUTO_INCREMENT,
  `TRANSACTION_TransactionID` INT NOT NULL,
  `TimeStamp` TIMESTAMP(2) NULL,
  `RefundDescription` MEDIUMTEXT NULL,
  `AmountDeducted` INT NULL,
  PRIMARY KEY (`RefundID`),
  INDEX `fk_REFUND_TRANSACTION1_idx` (`TRANSACTION_TransactionID` ASC) VISIBLE,
  CONSTRAINT `fk_REFUND_TRANSACTION1`
    FOREIGN KEY (`TRANSACTION_TransactionID`)
    REFERENCES `Rent_A_Room_House`.`TRANSACTION` (`TransactionID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`UNIT_has_IMAGES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`UNIT_has_IMAGES` (
  `UNIT_UnitID` INT NOT NULL,
  `IMAGES_ImageID` INT NOT NULL,
  PRIMARY KEY (`UNIT_UnitID`, `IMAGES_ImageID`),
  INDEX `fk_UNIT_has_IMAGES_IMAGES1_idx` (`IMAGES_ImageID` ASC) VISIBLE,
  INDEX `fk_UNIT_has_IMAGES_UNIT1_idx` (`UNIT_UnitID` ASC) VISIBLE,
  CONSTRAINT `fk_UNIT_has_IMAGES_UNIT1`
    FOREIGN KEY (`UNIT_UnitID`)
    REFERENCES `Rent_A_Room_House`.`UNIT` (`UnitID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_UNIT_has_IMAGES_IMAGES1`
    FOREIGN KEY (`IMAGES_ImageID`)
    REFERENCES `Rent_A_Room_House`.`IMAGES` (`ImageID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent_A_Room_House`.`REVIEWS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent_A_Room_House`.`REVIEWS` (
  `ReviewsID` INT NOT NULL AUTO_INCREMENT,
  `RENTER_RenterID` INT NOT NULL,
  `UNIT_UnitID` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NULL,
  `AmountPaid` INT NULL,
  `RenterReview` MEDIUMTEXT NULL,
  `ReviewDate` TIMESTAMP(2) NULL,
  INDEX `fk_BOOKING_HISTORY_AND_REVIEWS_RENTER1_idx` (`RENTER_RenterID` ASC) VISIBLE,
  INDEX `fk_REVIEWS_UNIT1_idx` (`UNIT_UnitID` ASC) VISIBLE,
  PRIMARY KEY (`ReviewsID`),
  CONSTRAINT `fk_BOOKING_HISTORY_AND_REVIEWS_RENTER1`
    FOREIGN KEY (`RENTER_RenterID`)
    REFERENCES `Rent_A_Room_House`.`RENTER` (`RenterID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_REVIEWS_UNIT1`
    FOREIGN KEY (`UNIT_UnitID`)
    REFERENCES `Rent_A_Room_House`.`UNIT` (`UnitID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
