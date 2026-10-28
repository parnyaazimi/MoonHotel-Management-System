-- آتنا صادقی / 403521465
-- سارینا عباسی / 403521492
-- پرنیا عظیمی / 403522019

-- CREATE DATABASE MoonHotel;
use MoonHotel;

-- Tables


-- CREATE TABLE `Rating` (
--   `RatingID` INT UNSIGNED NOT NULL,
--   `RatingNum` INT NOT NULL,
--  `Description` TEXT NULL,
--   PRIMARY KEY (`RatingID`),
--   CONSTRAINT `chk_Rating_RatingNum_1_5`
 --    CHECK (`RatingNum` IN (1,2,3,4,5))
 -- ) ENGINE=InnoDB;

 -- CREATE TABLE `Hotel` (
 --  `HotelID` INT UNSIGNED NOT NULL,
 --  `HotelName` VARCHAR(100) NULL,
--   `City` VARCHAR(45) NULL,
--   `Street` VARCHAR(45) NULL,
--   `PostalCode` VARCHAR(20) NULL,
 --  `Phone` VARCHAR(20) NULL,
 --  `Email` VARCHAR(100) NULL,
--   `RatingID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`HotelID`),
--   CONSTRAINT `fk_Hotel_Rating`
--     FOREIGN KEY (`RatingID`)
--     REFERENCES `Rating` (`RatingID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
 -- ) ENGINE=InnoDB;

-- CREATE TABLE `Role` (
--   `RoleID` INT UNSIGNED NOT NULL,
--   `RoleName` VARCHAR(45) NULL,
--   PRIMARY KEY (`RoleID`)
 -- ) ENGINE=InnoDB;

 -- CREATE TABLE `Staff` (
 --  `StaffID` INT UNSIGNED NOT NULL,
 --  `FirstName` VARCHAR(45) NULL,
--   `LastName` VARCHAR(45) NULL,
 --  `UserName` VARCHAR(45) NULL,
--   `Password` VARCHAR(255) NOT NULL,
--   `Salary` INT NULL,
--   `HireDate` DATE NULL,
--   `HotelID` INT UNSIGNED NOT NULL,
--   `RoleID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`StaffID`),
--   CONSTRAINT `fk_Staff_Hotel`
--     FOREIGN KEY (`HotelID`)
--     REFERENCES `Hotel` (`HotelID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Staff_Role`
--     FOREIGN KEY (`RoleID`)
--     REFERENCES `Role` (`RoleID`)
 --    ON DELETE RESTRICT
 --    ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Customer` (
--   `CustomerID` INT UNSIGNED NOT NULL,
--   `NationalID` CHAR(10) NOT NULL,
--   `FirstName` VARCHAR(45) NULL,
--   `LastName` VARCHAR(45) NULL,
--   `BirthDate` DATE NULL,
--   `City` VARCHAR(45) NULL,
--   `Street` VARCHAR(45) NULL,
--   `PostalCode` VARCHAR(45) NULL,
--   PRIMARY KEY (`CustomerID`),
--   UNIQUE (`NationalID`)
-- ) ENGINE=InnoDB;

-- CREATE TABLE `CustomerPhone` (
--  `CustomerID` INT UNSIGNED NOT NULL,
--   `PhoneNumber` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`CustomerID`, `PhoneNumber`),
--   CONSTRAINT `fk_CustomerPhone_Customer`
--     FOREIGN KEY (`CustomerID`)
 --    REFERENCES `Customer` (`CustomerID`)
--     ON DELETE CASCADE
 --    ON UPDATE CASCADE
 -- ) ENGINE=InnoDB;


-- CREATE TABLE `ReservationStatus` (
--   `StatusID` INT UNSIGNED NOT NULL,
--   `StatusName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`StatusID`),
--   CONSTRAINT `chk_ReservationStatus_StatusName`
--     CHECK (`StatusName` IN ('Accept','Cancel','Complete'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `RoomStatus` (
--   `RoomStatusID` INT UNSIGNED NOT NULL,
--   `StatusName` VARCHAR(45) NULL,
--   PRIMARY KEY (`RoomStatusID`),
--   CONSTRAINT `chk_RoomStatus_StatusName`
--     CHECK (`StatusName` IN ('Free','Reserved','Under Repair'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `RoomType` (
--   `RoomTypeID` INT UNSIGNED NOT NULL,
--   `TypeName` VARCHAR(45) NOT NULL,
--   `Description` VARCHAR(200) NULL,
--   PRIMARY KEY (`RoomTypeID`),
--   CONSTRAINT `chk_RoomType_TypeName`
--     CHECK (`TypeName` IN ('VIP','Normal'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Room` (
--   `RoomID` INT UNSIGNED NOT NULL,
--   `RoomNumber` INT UNSIGNED NULL,
--   `Capacity` INT NULL,
--   `PricePerNight` DECIMAL(10,2) NULL,
--   `RoomStatusID` INT UNSIGNED NOT NULL,
--   `RoomTypeID` INT UNSIGNED NOT NULL,
--   `HotelID` INT UNSIGNED NOT NULL,
--   `Description` VARCHAR(255) NULL,
--   PRIMARY KEY (`RoomID`),
--   UNIQUE (`RoomNumber`),
--   CONSTRAINT `fk_Room_RoomStatus`
--     FOREIGN KEY (`RoomStatusID`)
--     REFERENCES `RoomStatus` (`RoomStatusID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Room_RoomType`
--     FOREIGN KEY (`RoomTypeID`)
--     REFERENCES `RoomType` (`RoomTypeID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Room_Hotel`
--     FOREIGN KEY (`HotelID`)
--     REFERENCES `Hotel` (`HotelID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Reservation` (
--   `ReservationID` INT UNSIGNED NOT NULL,
--   `CheckInDate` DATE NULL,
--   `CheckOutDate` DATE NULL,
--   `NumberOfGuests` INT NULL,
--   `CustomerID` INT UNSIGNED NOT NULL,
--   `RoomID` INT UNSIGNED NOT NULL,
--   `StatusID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`ReservationID`),
--   CHECK (`CheckOutDate` > `CheckInDate`),
--   CONSTRAINT `fk_Reservation_Customer`
--     FOREIGN KEY (`CustomerID`)
--     REFERENCES `Customer` (`CustomerID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Reservation_Room`
--     FOREIGN KEY (`RoomID`)
--     REFERENCES `Room` (`RoomID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Reservation_Status`
--     FOREIGN KEY (`StatusID`)
--     REFERENCES `ReservationStatus` (`StatusID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `ServiceStatus` (
--   `ServiceStatusID` INT UNSIGNED NOT NULL,
--   `StatusName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`ServiceStatusID`),
--   CONSTRAINT `chk_ServiceStatus_StatusName`
--     CHECK (`StatusName` IN ('Available','Not Available'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Service` (
--   `ServiceID` INT UNSIGNED NOT NULL,
--   `ServiceName` VARCHAR(45) NULL,
--   `Price` DECIMAL(10,2) NULL,
--   `Description` TEXT NULL,
--   `HotelID` INT UNSIGNED NOT NULL,
--   `ServiceStatusID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`ServiceID`),
--   CONSTRAINT `fk_Service_Hotel`
--     FOREIGN KEY (`HotelID`)
--     REFERENCES `Hotel` (`HotelID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Service_Status`
--     FOREIGN KEY (`ServiceStatusID`)
--     REFERENCES `ServiceStatus` (`ServiceStatusID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `ReservationService` (
--   `ReservationID` INT UNSIGNED NOT NULL,
--   `ServiceID` INT UNSIGNED NOT NULL,
--   `PriceAtTime` DECIMAL(10, 2) NULL, 
--   `quantity` INT UNSIGNED NOT NULL DEFAULT 1,
--   PRIMARY KEY (`ReservationID`, `ServiceID`),
--   CONSTRAINT `fk_ReservationService_Reservation`
--     FOREIGN KEY (`ReservationID`)
--     REFERENCES `Reservation` (`ReservationID`)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_ReservationService_Service`
--     FOREIGN KEY (`ServiceID`)
--     REFERENCES `Service` (`ServiceID`)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `OrderStatus` (
--   `StatusID` INT UNSIGNED NOT NULL,
--   `StatusName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`StatusID`),
--   CONSTRAINT `chk_OrderStatus_StatusName`
--     CHECK (`StatusName` IN ('Preparing','Ready','Cancel'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Order` (
--   `OrderID` INT UNSIGNED NOT NULL,
--   `OrderDate` DATE NULL,
--   `OrderTime` TIME NULL,
--   `CustomerID` INT UNSIGNED NOT NULL,
--   `StatusID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`OrderID`),
--   CONSTRAINT `fk_Order_Customer`
--     FOREIGN KEY (`CustomerID`)
--     REFERENCES `Customer` (`CustomerID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Order_Status`
--     FOREIGN KEY (`StatusID`)
--     REFERENCES `OrderStatus` (`StatusID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `InvoiceStatus` (
--   `StatusID` INT UNSIGNED NOT NULL,
--   `StatusName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`StatusID`),
--   CONSTRAINT `chk_InvoiceStatus_StatusName`
--     CHECK (`StatusName` IN ('Checkout','Not paid'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Invoice` (
--   `InvoiceId` INT UNSIGNED NOT NULL,
--   `InvoiceDate` DATE NULL,
--   `TaxAmount` DECIMAL(10,2) NULL,
--   `TotalAmount` DECIMAL(10,2) NULL,
--   `Discount` DECIMAL(10,2) NULL,
--   `StatusID` INT UNSIGNED NOT NULL,
--   `ReservationID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`InvoiceId`),
--   UNIQUE KEY `uq_Invoice_ReservationID` (`ReservationID`),
--   CONSTRAINT `fk_Invoice_Status`
--     FOREIGN KEY (`StatusID`)
--     REFERENCES `InvoiceStatus` (`StatusID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_invoice_reservation`
--     FOREIGN KEY (`ReservationID`)
--     REFERENCES `Reservation` (`ReservationID`)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `PaymentStatus` (
--   `StatusID` INT UNSIGNED NOT NULL,
--   `StatusName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`StatusID`),
--   CONSTRAINT `chk_PaymentStatus_StatusName`
--     CHECK (`StatusName` IN ('Pending', 'Paid', 'Failed', 'Cancelled'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `PaymentMethod` (
--   `MethodID` INT UNSIGNED NOT NULL,
--   `MethodName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`MethodID`),
--   CONSTRAINT `chk_PaymentMethod_MethodName`
--     CHECK (`MethodName` IN ('CASH','CARD','ONLINE','BANK_TRANSFER'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Payment` (
--   `PaymentID` INT UNSIGNED NOT NULL,
--   `InvoiceID` INT UNSIGNED NOT NULL,
--   `PaymentDate` DATE NULL,
--   `Amount` DECIMAL(10,2) NULL,
--   `StatusID` INT UNSIGNED NOT NULL,
--   `MethodID` INT UNSIGNED NOT NULL,
--   `PaymentType` ENUM('FULL','INSTALLMENT') NOT NULL,
--   `DueDate` DATE NULL,
--   `InstallmentNumber` INT NULL,
--   `TotalInstallments` INT NULL,
--   PRIMARY KEY (`PaymentID`),
--   CHECK (`Amount` > 0),
--   CONSTRAINT `fk_Payment_Invoice`
--     FOREIGN KEY (`InvoiceID`)
--     REFERENCES `Invoice` (`InvoiceId`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Payment_Status`
--     FOREIGN KEY (`StatusID`)
--     REFERENCES `PaymentStatus` (`StatusID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Payment_Method`
--     FOREIGN KEY (`MethodID`)
--     REFERENCES `PaymentMethod` (`MethodID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `chk_Payment_Installment_Fields`
--     CHECK (
--       (`PaymentType` = 'FULL'
--         AND `DueDate` IS NULL
--         AND `InstallmentNumber` IS NULL
--         AND `TotalInstallments` IS NULL
--       )
--       OR
--       (`PaymentType` = 'INSTALLMENT'
--         AND `DueDate` IS NOT NULL
--         AND `InstallmentNumber` IS NOT NULL
--         AND `TotalInstallments` IS NOT NULL
--         AND `InstallmentNumber` >= 1
--         AND `TotalInstallments` >= `InstallmentNumber`
--       )
--     )
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Review` (
--   `ReviewID` INT UNSIGNED NOT NULL,
--   `Comment` TEXT NULL,
--   `ReviewDate` DATE NULL,
--   `CustomerID` INT UNSIGNED NOT NULL,
--   `HotelID` INT UNSIGNED NOT NULL,
--   `RatingID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`ReviewID`),
--   CONSTRAINT `fk_Review_Hotel`
--     FOREIGN KEY (`HotelID`)
--     REFERENCES `Hotel` (`HotelID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Review_Customer`
--     FOREIGN KEY (`CustomerID`)
--     REFERENCES `Customer` (`CustomerID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Review_Rating`
--     FOREIGN KEY (`RatingID`)
--     REFERENCES `Rating` (`RatingID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Author` (
--   `AuthorID` INT UNSIGNED NOT NULL,
--   `AuthorName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`AuthorID`)
-- ) ENGINE=InnoDB;

-- CREATE TABLE `BookCategory` (
--   `BookCategoryID` INT UNSIGNED NOT NULL,
--   `BookCategoryName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`BookCategoryID`)
-- ) ENGINE=InnoDB;

-- CREATE TABLE `BookStatus` (
--   `BookStatusID` INT UNSIGNED NOT NULL,
--   `BookStatusName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`BookStatusID`),
--   CONSTRAINT `chk_BookStatus_StatusName`
--     CHECK (`BookStatusName` IN ('Existing','Not Existing'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `BookLocation` (
--   `LocationID` INT UNSIGNED NOT NULL,
--   `HotelID` INT UNSIGNED NOT NULL,
--   `Floor` INT NULL,
--   `Section` VARCHAR(45) NULL,
--   `ShelfNumber` VARCHAR(45) NULL,
--   PRIMARY KEY (`LocationID`),
--   CONSTRAINT `fk_BookLocation_Hotel`
--     FOREIGN KEY (`HotelID`)
--     REFERENCES `Hotel` (`HotelID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Book` (
--   `BookID` INT UNSIGNED NOT NULL,
--   `Title` VARCHAR(100) NOT NULL,
--   `AuthorID` INT UNSIGNED NOT NULL,
--   `BookCategoryID` INT UNSIGNED NOT NULL,
--   `BookStatusID` INT UNSIGNED NOT NULL,
--   `LocationID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`BookID`),
--   CONSTRAINT `fk_Book_Author`
--     FOREIGN KEY (`AuthorID`)
--     REFERENCES `Author` (`AuthorID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Book_Category`
--     FOREIGN KEY (`BookCategoryID`)
--     REFERENCES `BookCategory` (`BookCategoryID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Book_Status`
--     FOREIGN KEY (`BookStatusID`)
--     REFERENCES `BookStatus` (`BookStatusID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Book_Location`
--     FOREIGN KEY (`LocationID`)
--     REFERENCES `BookLocation` (`LocationID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `FacilityStatus` (
--   `StatusID` INT UNSIGNED NOT NULL,
--   `StatusName` VARCHAR(45) NULL,
--   PRIMARY KEY (`StatusID`),
--   CONSTRAINT `chk_FacilityStatus_StatusName`
--     CHECK (`StatusName` IN ('Available','Not Available'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Facility` (
--   `FacilityID` INT UNSIGNED NOT NULL,
--   `HotelID` INT UNSIGNED NOT NULL,
--   `StatusID` INT UNSIGNED NOT NULL,
--   `Name` VARCHAR(45) NULL,
--   `Description` TEXT NULL,
--   `OpenTime` TIME NULL,
--   `CloseTime` TIME NULL,
--   PRIMARY KEY (`FacilityID`),
--   CONSTRAINT `fk_Facility_Hotel`
--     FOREIGN KEY (`HotelID`)
--     REFERENCES `Hotel` (`HotelID`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION,
--   CONSTRAINT `fk_Facility_Status`
--     FOREIGN KEY (`StatusID`)
--     REFERENCES `FacilityStatus` (`StatusID`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION
-- ) ENGINE=InnoDB;

-- CREATE TABLE `FoodCategory` (
--   `CategoryID` INT UNSIGNED NOT NULL,
--   `CategoryName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`CategoryID`)
-- ) ENGINE=InnoDB;

-- CREATE TABLE `FoodSection` (
--   `SectionID` INT UNSIGNED NOT NULL,
--   `SectionName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`SectionID`),
--   CONSTRAINT `chk_FoodSection_SectionName`
--     CHECK (`SectionName` IN ('Restaurant','Cafe'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `FoodStatus` (
--   `FoodStatusID` INT UNSIGNED NOT NULL,
--   `StatusName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`FoodStatusID`),
--   CONSTRAINT `chk_FoodStatus_StatusName`
--     CHECK (`StatusName` IN ('Existing','Not Existing'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `FoodMenu` (
--   `FoodID` INT UNSIGNED NOT NULL,
--   `FoodName` VARCHAR(45) NOT NULL,
--   `Price` DECIMAL(10,2) NOT NULL,
--   `CategoryID` INT UNSIGNED NOT NULL,
--   `SectionID` INT UNSIGNED NOT NULL,
--   `FoodStatusID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`FoodID`),
--   CONSTRAINT `fk_Food_Category`
--     FOREIGN KEY (`CategoryID`)
--     REFERENCES `FoodCategory` (`CategoryID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Food_Section`
--     FOREIGN KEY (`SectionID`)
--     REFERENCES `FoodSection` (`SectionID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Food_Status`
--     FOREIGN KEY (`FoodStatusID`)
--     REFERENCES `FoodStatus` (`FoodStatusID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `ProductCategory` (
--   `ProductCategoryID` INT UNSIGNED NOT NULL,
--   `CategoryName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`ProductCategoryID`)
-- ) ENGINE=InnoDB;

-- CREATE TABLE `ProductStatus` (
--   `ProductStatusID` INT UNSIGNED NOT NULL,
--   `StatusName` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`ProductStatusID`),
--   CONSTRAINT `chk_ProductStatus_StatusName`
--     CHECK (`StatusName` IN ('Existing','Not Existing'))
-- ) ENGINE=InnoDB;

-- CREATE TABLE `Product` (
--   `ProductID` INT UNSIGNED NOT NULL,
--   `ProductName` VARCHAR(45) NOT NULL,
--   `Price` DECIMAL(10,2) NOT NULL,
--   `ProductCategoryID` INT UNSIGNED NOT NULL,
--   `ProductStatusID` INT UNSIGNED NOT NULL,
--   `Description` TEXT NULL,
--   PRIMARY KEY (`ProductID`),
--   CONSTRAINT `fk_Product_Category`
--     FOREIGN KEY (`ProductCategoryID`)
--     REFERENCES `ProductCategory` (`ProductCategoryID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_Product_Status`
--     FOREIGN KEY (`ProductStatusID`)
--     REFERENCES `ProductStatus` (`ProductStatusID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `OrderItem` (
--   `OrderID` INT UNSIGNED NOT NULL,
--   `ItemID` INT UNSIGNED NOT NULL,
--   `UnitPrice` DECIMAL(10,2) NOT NULL,
--   `Quantity` INT NOT NULL,
--   PRIMARY KEY (`OrderID`, `ItemID`),
--   CONSTRAINT `fk_OrderItem_Order`
--     FOREIGN KEY (`OrderID`)
--     REFERENCES `Order` (`OrderID`)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `OrderItemFood` (
--   `OrderID` INT UNSIGNED NOT NULL,
--   `ItemID` INT UNSIGNED NOT NULL,
--   `FoodID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`OrderID`, `ItemID`),
--   CONSTRAINT `fk_OIF_OrderItem`
--     FOREIGN KEY (`OrderID`, `ItemID`)
--     REFERENCES `OrderItem` (`OrderID`, `ItemID`)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_OIF_Food`
--     FOREIGN KEY (`FoodID`)
--     REFERENCES `FoodMenu` (`FoodID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `OrderItemProduct` (
--   `OrderID` INT UNSIGNED NOT NULL,
--   `ItemID` INT UNSIGNED NOT NULL,
--   `ProductID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`OrderID`, `ItemID`),
--   CONSTRAINT `fk_OIP_OrderItem`
--     FOREIGN KEY (`OrderID`, `ItemID`)
--     REFERENCES `OrderItem` (`OrderID`, `ItemID`)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_OIP_Product`
--     FOREIGN KEY (`ProductID`)
--     REFERENCES `Product` (`ProductID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;

-- CREATE TABLE `OrderItemBook` (
--   `OrderID` INT UNSIGNED NOT NULL,
--   `ItemID` INT UNSIGNED NOT NULL,
--   `BookID` INT UNSIGNED NOT NULL,
--   PRIMARY KEY (`OrderID`, `ItemID`),
--   CONSTRAINT `fk_OIB_OrderItem`
--     FOREIGN KEY (`OrderID`, `ItemID`)
--     REFERENCES `OrderItem` (`OrderID`, `ItemID`)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE,
--   CONSTRAINT `fk_OIB_Book`
--     FOREIGN KEY (`BookID`)
--     REFERENCES `Book` (`BookID`)
--     ON DELETE RESTRICT
--     ON UPDATE CASCADE
-- ) ENGINE=InnoDB;



-- Datas



-- INSERT INTO `Rating` (`RatingID`, `RatingNum`, `Description`) VALUES
-- (1, 1, 'Very bad'),
-- (2, 2, 'Bad'),
-- (3, 3, 'Average'),
-- (4, 4, 'Good'),
-- (5, 5, 'Excellent');


-- INSERT INTO `Hotel` (`HotelID`, `HotelName`, `City`, `Street`, `PostalCode`, `Phone`, `Email`, `RatingID`) VALUES
-- (1, 'Espinas Palace Hotel', 'Tehran', 'Behroud Sq, Saadat Abad', '1998111333', '02175675000', 'info@espinas-palace.com', 5),
-- (2, 'Abbasi Hotel', 'Isfahan', 'Amadgah St, Chaharbagh Abbasi', '8144913131', '03132226010', 'info@abbasihotel.ir', 5),
-- (3, 'Dariush Grand Hotel', 'Kish', 'Dariush Square', '7941711111', '07644444900', 'reservation@dariushgrandhotel.com', 5),
-- (4, 'Parsian Azadi Hotel', 'Tehran', 'Yadegar-e-Emam Expressway', '1997911111', '02129112', 'info@azadihotel.ir', 4),
-- (5, 'Homa Hotel', 'Mashhad', 'Ahmad Abad Blvd', '9173511111', '05137611001', 'mashhad@homahotels.com', 4),
-- (6, 'Shiraz Grand Hotel', 'Shiraz', 'Quran Gateway', '7146811111', '07132274010', 'info@shiraz-hotel.com', 5),
-- (7, 'Laleh Kandovan Rock Hotel', 'Tabriz', 'Kandovan Tourist Village', '5358111111', '04133224951', 'kandovan@lalehhotels.com', 4),
-- (8, 'Ameri House Hotel', 'Kashan', 'Alavi St', '8713711111', '03155240220', 'info@sarayeameriha.com', 5),
-- (9, 'Kowsar Hotel', 'Isfahan', 'Mellat Blvd, Si-o-Se Pol', '8174673331', '03136240230', 'info@kowserhotel.com', 4),
-- (10, 'Ghasr Monshi Boutique Hotel', 'Isfahan', 'Ghasr Monshi Alley, Neshat St', '8143611111', '03132247040', 'info@ghasrmonshihotel.com', 3);


-- INSERT INTO `Role` (`RoleID`, `RoleName`) VALUES
-- (1, 'General Manager'),
-- (2, 'Receptionist'),
-- (3, 'Housekeeping Staff'),
-- (4, 'Chef'),
-- (5, 'Waiter/Waitress'),
-- (6, 'Security Officer'),
-- (7, 'IT Specialist'),
-- (8, 'Accountant'),
-- (9, 'Maintenance Technician'),
-- (10, 'Concierge');


-- INSERT INTO `Staff`
-- (`StaffID`, `FirstName`, `LastName`, `Salary`, `HireDate`, `Username`, `Password`, `HotelID`, `RoleID`)
-- VALUES
-- (1,  'Ali',     'Mohammadi', 85000000.00, '2022-03-15', 'ali.m',     '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', 1,  1),
-- (2,  'Sara',    'Karimi', 42000000.00, '2023-06-01', 'sara.k',    '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 1,  2),
-- (3,  'Reza',    'Ahmadi', 38000000.00, '2021-11-20', 'reza.a',    '2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae', 2,  3),
-- (4,  'Maryam',  'Hosseini', 60000000.00, '2020-09-10', 'maryam.h',  '6b3a55e0261b0304143f805a249b4a7aefbb0f7f6f6f60f5c2e7f9f0d7c0a123', 2,  8),
-- (5,  'Mehdi',   'Ebrahimi', 55000000.00, '2019-05-05', 'mehdi.e',   '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', 3,  4),
-- (6,  'Neda',    'Jafari', 36000000.00, '2024-01-12', 'neda.j',    '3f79bb7b435b05321651daefd374cdc681dc06faa65e374e38337b88ca046dea', 3,  5),
-- (7,  'Hossein', 'Soleimani', 40000000.00, '2022-08-19', 'hossein.s', 'a7f5f35426b927411fc9231b56382173b0f99a89d5f1b0b822cd15d6c15b0abc', 4,  6),
-- (8,  'Zahra',   'Rahimi', 48000000.00, '2021-02-27', 'zahra.r',   '12dada1fff4d4787ade3333147202c3b443e376f2e1e9f9f3f0a3e4b0d0c0f11', 5,  9),
-- (9,  'Amir',    'Nazari', 52000000.00, '2020-12-03', 'amir.n',    '0b1f3c1f9f2a4d6c8e0f1a2b3c4d5e6f708192a3b4c5d6e7f8091a2b3c4d5e6f', 6,  10),
-- (10, 'Fatemeh', 'Gholami', 47000000.00, '2023-04-22', 'fatemeh.g', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 7,  7);

-- INSERT INTO `Customer` (`CustomerID`, `NationalID`, `FirstName`, `LastName`, `BirthDate`, `City`, `Street`, `PostalCode`) VALUES
-- (1, '0011223344', 'Reza', 'Karimi', '1985-05-15', 'Tehran', 'Valiasr St', '1234567890'),
-- (2, '0022334455', 'Sara', 'Alavi', '1992-08-22', 'Shiraz', 'Zand St', '7134567890'),
-- (3, '0033445566', 'Mehdi', 'Fathi', '1978-01-10', 'Isfahan', 'Chaharbagh St', '8144567890'),
-- (4, '0044556677', 'Neda', 'Ranjbar', '1995-12-05', 'Tabriz', 'Imam Khomeini St', '5134567890'),
-- (5, '0055667788', 'Amir', 'Tavakoli', '1988-04-18', 'Mashhad', 'Vakil Abad Blvd', '9134567890'),
-- (6, '0066778899', 'Fatemeh', 'Hashemi', '1990-09-30', 'Tehran', 'Shariati St', '1634567890'),
-- (7, '0077889900', 'Hassan', 'Mohammadi', '1982-11-12', 'Kish', 'Sanayee St', '7944567890'),
-- (8, '0088990011', 'Zahra', 'Razavi', '1998-03-25', 'Yazd', 'Jomhouri St', '8934567890'),
-- (9, '0099001122', 'Ali', 'Shirazi', '1975-07-07', 'Kerman', 'Azadi St', '7634567890'),
-- (10, '0010111213', 'Maryam', 'Esmaili', '1993-02-14', 'Rasht', 'Golsar St', '4134567890');

-- INSERT INTO `CustomerPhone` (`CustomerID`, `PhoneNumber`) VALUES
-- (1, '09121112233'),
-- (1, '02188884444'),
-- (2, '09355556677'),
-- (2, '07132221111'),
-- (3, '09130009988'),
-- (4, '09142223344'),
-- (5, '09154445566'),
-- (6, '09127778899'),
-- (7, '09369990011');


-- INSERT INTO `ReservationStatus` (`StatusID`, `StatusName`) VALUES
-- (1, 'Accept'),
-- (2, 'Cancel'),
-- (3, 'Complete');


-- INSERT INTO `RoomStatus` (`RoomStatusID`, `StatusName`) VALUES
-- (1, 'Free'),
-- (2, 'Reserved'),
-- (3, 'Under Repair');


-- INSERT INTO `RoomType` (`RoomTypeID`, `TypeName`, `Description`) VALUES
-- (1, 'VIP', 'Luxury suites with premium services'),
-- (2, 'Normal', 'Standard rooms with essential amenities');

-- INSERT INTO `Room` 
-- (`RoomID`, `RoomNumber`, `Capacity`, `PricePerNight`, `RoomStatusID`, `RoomTypeID`, `HotelID`, `Description`) 
-- VALUES
-- (1,  101, 2, 15000000.00, 1, 1, 1,  'King size bed, City view'),
-- (2,  201, 3, 12000000.00, 2, 1, 2,  'Garden view, Traditional design'),
-- (3,  305, 1, 8000000.00,  1, 2, 3,  'Single room, Sea view'),
-- (4,  410, 4, 25000000.00, 1, 1, 4,  'Family suite, High floor'),
-- (5,  502, 2, 9500000.00,  3, 2, 5,  'Near elevator, Standard'),
-- (6,  601, 2, 18000000.00, 2, 1, 6,  'Mountain view, Luxury'),
-- (7,  703, 2, 14000000.00, 1, 1, 7,  'Rock carved room, Unique experience'),
-- (8,  110, 3, 11000000.00, 1, 2, 8,  'Historical ambiance'),
-- (9,  220, 2, 13000000.00, 1, 1, 9,  'Riverside view'),
-- (10, 105, 2, 7000000.00,  2, 2, 10, 'Boutique style, Cozy');


-- INSERT INTO `Reservation`
-- (`ReservationID`, `CheckInDate`, `CheckOutDate`, `NumberOfGuests`, `CustomerID`, `RoomID`, `StatusID`)
-- VALUES
-- (1,  '2026-06-10', '2026-06-12', 2, 1,  1, 1), 
-- (2,  '2026-06-15', '2026-06-18', 3, 2,  2, 3), 
-- (3,  '2026-07-01', '2026-07-02', 1, 3,  3, 1), 
-- (4,  '2026-07-05', '2026-07-10', 4, 4,  4, 1),
-- (5,  '2026-07-12', '2026-07-14', 2, 5,  5, 2), 
-- (6,  '2026-08-01', '2026-08-04', 2, 6,  6, 3), 
-- (7,  '2026-08-10', '2026-08-13', 2, 7,  7, 1), 
-- (8,  '2026-09-02', '2026-09-06', 3, 8,  8, 2),  
-- (9,  '2026-09-15', '2026-09-17', 2, 9,  9, 3), 
-- (10, '2026-10-01', '2026-10-03', 2, 10, 10, 1);

-- INSERT INTO `ServiceStatus` (`ServiceStatusID`, `StatusName`) VALUES
-- (1, 'Available'),
-- (2, 'Not Available');
--  

-- INSERT INTO `Service`
-- (`ServiceID`, `ServiceName`, `Price`, `Description`, `HotelID`, `ServiceStatusID`)
-- VALUES
-- (1,  'Airport Transfer', 2500000.00, 'Private airport pickup and drop-off service', 1, 1),
-- (2,  'Spa',              4000000.00, 'Full body massage and wellness service',      2, 1),
-- (3,  'Laundry',           800000.00, 'Washing and ironing clothes',                  3, 1),
-- (4,  'Breakfast Buffet', 1200000.00, 'Open buffet breakfast',                        4, 1),
-- (5,  'Gym Access',       1000000.00, 'Daily access to hotel fitness center',         5, 2),
-- (6,  'City Tour',        3500000.00, 'Half-day city tour with guide',                6, 1),
-- (7,  'Mini Bar',         1500000.00, 'In-room drinks and snacks',                    7, 1),
-- (8,  'Conference Room',  5000000.00, 'Meeting room reservation service',             8, 2),
-- (9,  'Room Decoration',  2200000.00, 'Special decoration for events',                9, 1),
-- (10, 'Extra Bed',        1800000.00, 'Additional bed for guest room',               10, 1);


-- INSERT INTO `ReservationService`
-- (`ReservationID`, `ServiceID`, `PriceAtTime`, `quantity`)
-- VALUES
-- (1,  1, 2500000.00, 1),
-- (2,  2, 4000000.00, 2),
-- (3,  3,  800000.00, 1),
-- (4,  4, 1200000.00, 4),
-- (5,  5, 1000000.00, 1),
-- (6,  6, 3500000.00, 2),
-- (7,  7, 1500000.00, 3),
-- (8,  8, 5000000.00, 1),
-- (9,  9, 2200000.00, 1),
-- (10, 10, 1800000.00, 1);

-- INSERT INTO `OrderStatus` (`StatusID`, `StatusName`) VALUES
-- (1, 'Preparing'),
-- (2, 'Ready'),
-- (3, 'Cancel');

-- INSERT INTO `Order`
-- (`OrderID`, `OrderDate`, `OrderTime`, `CustomerID`, `StatusID`)
-- VALUES
-- (1,  '2026-06-10', '08:30:00', 1, 1),
-- (2,  '2026-06-10', '13:15:00', 2, 2),
-- (3,  '2026-06-11', '19:45:00', 3, 1),
-- (4,  '2026-06-12', '09:20:00', 4, 3),
-- (5,  '2026-06-12', '14:10:00', 5, 2),
-- (6,  '2026-06-13', '20:05:00', 6, 1),
-- (7,  '2026-06-14', '07:50:00', 7, 2),
-- (8,  '2026-06-14', '18:30:00', 8, 3),
-- (9,  '2026-06-15', '12:00:00', 9, 1),
-- (10, '2026-06-16', '21:25:00', 10, 2);

-- INSERT INTO `InvoiceStatus` (`StatusID`, `StatusName`) VALUES
-- (1, 'Checkout'),
-- (2, 'Not paid');

-- INSERT INTO `Invoice`
-- (`InvoiceId`, `InvoiceDate`, `TaxAmount`, `TotalAmount`, `Discount`, `StatusID`, `ReservationID`)
-- VALUES
-- (1,  '2026-06-12',  900000.00,  9900000.00, 500000.00, 1, 1),
-- (2,  '2026-06-18', 1200000.00, 13200000.00,      0.00, 1, 2),
-- (3,  '2026-07-02',  450000.00,  4950000.00, 250000.00, 2, 3),
-- (4,  '2026-07-10', 1800000.00, 19800000.00,      0.00, 2, 4),
-- (5,  '2026-07-14',  600000.00,  6600000.00,      0.00, 1, 5),
-- (6,  '2026-08-04', 1050000.00, 11550000.00, 300000.00, 1, 6),
-- (7,  '2026-08-13',  750000.00,  8250000.00,      0.00, 2, 7),
-- (8,  '2026-09-06', 1500000.00, 16500000.00,      0.00, 1, 8),
-- (9,  '2026-09-17',  840000.00,  9240000.00, 200000.00, 2, 9),
-- (10, '2026-10-03',  960000.00, 10560000.00,      0.00, 1, 10);

-- INSERT INTO `PaymentStatus` (`StatusID`, `StatusName`) VALUES
-- (1, 'Pending'),
-- (2, 'Paid'),
-- (3, 'Failed'),
-- (4, 'Cancelled');

-- INSERT INTO `PaymentMethod` (`MethodID`, `MethodName`) VALUES
-- (1, 'CASH'),
-- (2, 'CARD'),
-- (3, 'ONLINE'),
-- (4, 'BANK_TRANSFER');


-- INSERT INTO `Payment`
-- (`PaymentID`, `InvoiceID`, `PaymentDate`, `Amount`, `StatusID`, `MethodID`,
--  `PaymentType`, `DueDate`, `InstallmentNumber`, `TotalInstallments`)
-- VALUES
-- -- Invoices with Status = Checkout  -> Payments should be Paid

-- (1,  1, '2026-06-12',  9900000.00, 2, 2, 'FULL',        NULL,         NULL, NULL),
-- (2,  2, '2026-06-18', 13200000.00, 2, 3, 'FULL',        NULL,         NULL, NULL),
-- (3,  5, '2026-07-14',  6600000.00, 2, 1, 'FULL',        NULL,         NULL, NULL),
-- (4,  6, '2026-08-04', 11550000.00, 2, 4, 'FULL',        NULL,         NULL, NULL),
-- (5,  8, '2026-09-06', 16500000.00, 2, 2, 'FULL',        NULL,         NULL, NULL),
-- (6, 10, '2026-10-03', 10560000.00, 2, 3, 'FULL',        NULL,         NULL, NULL),

-- -- Invoices with Status = Not paid -> Payments should be Pending / Failed / Cancelled

-- (7,  3, '2026-07-02',  2475000.00, 1, 2, 'INSTALLMENT', '2026-08-02', 1,    2),
-- (8,  4, '2026-07-10',  6600000.00, 3, 3, 'INSTALLMENT', '2026-08-10', 1,    3),
-- (9,  7, '2026-08-13',  4125000.00, 1, 4, 'INSTALLMENT', '2026-09-13', 1,    2),
-- (10, 9, '2026-09-17',  4620000.00, 4, 2, 'INSTALLMENT', '2026-10-17', 1,    2);


-- INSERT INTO `BookStatus` (`BookStatusID`, `BookStatusName`) VALUES
-- (1, 'Existing'),
-- (2, 'Not Existing');

-- INSERT INTO `BookCategory` (`BookCategoryID`, `BookCategoryName`) VALUES
-- (1, 'Novel'),
-- (2, 'History'),
-- (3, 'Psychology'),
-- (4, 'Science'),
-- (5, 'Business'),
-- (6, 'Travel'),
-- (7, 'Poetry'),
-- (8, 'Philosophy');

-- INSERT INTO `Author` (`AuthorID`, `AuthorName`) VALUES
-- (1,  'Sadegh Hedayat'),
-- (2,  'Jalal Al-e-Ahmad'),
-- (3,  'Simin Daneshvar'),
-- (4,  'Nizar Qabbani'),
-- (5,  'Paulo Coelho'),
-- (6,  'Victor Hugo'),
-- (7,  'George Orwell'),
-- (8,  'Fyodor Dostoevsky'),
-- (9,  'Erich Fromm'),
-- (10, 'Rumi');

-- INSERT INTO `BookLocation`
-- (`LocationID`, `HotelID`, `Floor`, `Section`, `ShelfNumber`)
-- VALUES
-- (1,  1, 1, 'Library',        'A1'),
-- (2,  2, 2, 'Reading Hall',   'B2'),
-- (3,  3, 1, 'Lobby Library',  'C1'),
-- (4,  4, 3, 'Cultural Room',  'D4'),
-- (5,  5, 2, 'VIP Lounge',     'E2'),
-- (6,  6, 1, 'Library',        'F1'),
-- (7,  7, 4, 'Book Corner',    'G3'),
-- (8,  8, 2, 'Reading Hall',   'H2'),
-- (9,  9, 1, 'Lobby Library',  'I1'),
-- (10, 10, 3, 'Cultural Room', 'J5');

-- INSERT INTO `Book`
-- (`BookID`, `Title`, `AuthorID`, `BookCategoryID`, `BookStatusID`, `LocationID`)
-- VALUES
-- (1,  'The Blind Owl',                1, 1, 1, 1),
-- (2,  'By the Pen',                   2, 2, 1, 2),
-- (3,  'Savushun',                     3, 1, 1, 3),
-- (4,  'Poems of Love',                4, 7, 1, 4),
-- (5,  'The Alchemist',                5, 1, 1, 5),
-- (6,  'Les Miserables',               6, 1, 1, 6),
-- (7,  'Animal Farm',                  7, 5, 1, 7),
-- (8,  'Crime and Punishment',         8, 8, 1, 8),
-- (9,  'The Art of Loving',            9, 3, 2, 9),
-- (10, 'Selected Poems of Rumi',      10, 7, 1, 10);

-- INSERT INTO `Review`
-- (`ReviewID`, `Comment`, `ReviewDate`, `CustomerID`, `HotelID`, `RatingID`)
-- VALUES
-- (1,  'Very clean room and professional staff.',                       '2026-06-13', 1,  1, 5),
-- (2,  'Breakfast quality was good but service was a little slow.',     '2026-06-19', 2,  2, 4),
-- (3,  'Comfortable stay and great location.',                          '2026-07-03', 3,  3, 4),
-- (4,  'The room was spacious, but the air conditioning had issues.',   '2026-07-11', 4,  4, 3),
-- (5,  'Excellent experience overall and very beautiful environment.',  '2026-07-15', 5,  5, 5),
-- (6,  'Average facilities, but acceptable for the price.',             '2026-08-05', 6,  6, 3),
-- (7,  'Staff were friendly and helpful during the whole stay.',        '2026-08-14', 7,  7, 4),
-- (8,  'The service was disappointing and not worth the cost.',         '2026-09-07', 8,  8, 2),
-- (9,  'Nice atmosphere and clean public areas.',                       '2026-09-18', 9,  9, 4),
-- (10, 'One of the best hotel experiences I have had.',                 '2026-10-04', 10, 10, 5);



-- INSERT INTO `FacilityStatus` (`StatusID`, `StatusName`) VALUES
-- (1, 'Available'),
-- (2, 'Not Available');

-- INSERT INTO `FoodSection` (`SectionID`, `SectionName`) VALUES
-- (1, 'Restaurant'),
-- (2, 'Cafe');

-- INSERT INTO `FoodStatus` (`FoodStatusID`, `StatusName`) VALUES
-- (1, 'Existing'),
-- (2, 'Not Existing');

-- INSERT INTO `FoodCategory` (`CategoryID`, `CategoryName`) VALUES
-- (1, 'Main Course'),
-- (2, 'Appetizer'),
-- (3, 'Dessert'),
-- (4, 'Hot Drinks'),
-- (5, 'Cold Drinks'),
-- (6, 'Fast Food');


-- INSERT INTO `Facility` 
-- (`FacilityID`, `HotelID`, `StatusID`, `Name`, `Description`, `OpenTime`, `CloseTime`)
-- VALUES
-- (1,  1, 1, 'Rooftop Pool',   'Luxury infinity pool with city view', '08:00:00', '22:00:00'),
-- (2,  2, 1, 'Traditional Spa', 'Iranian traditional massage and bath', '10:00:00', '20:00:00'),
-- (3,  3, 1, 'Fitness Center',  'Modern gym equipment',                 '06:00:00', '23:00:00'),
-- (4,  4, 2, 'Tennis Court',    'Outdoor professional tennis court',    '08:00:00', '18:00:00'),
-- (5,  5, 1, 'Business Center', 'Meeting rooms and office services',     '08:00:00', '20:00:00'),
-- (6,  6, 1, 'Kids Play Area',  'Safe indoor playground for children',  '09:00:00', '21:00:00'),
-- (7,  7, 1, 'Billiard Room',   'Entertainment room with pool tables',  '14:00:00', '00:00:00'),
-- (8,  8, 1, 'Sauna & Jacuzzi', 'Steam and dry sauna facilities',       '10:00:00', '22:00:00'),
-- (9,  9, 1, 'Cinema Hall',     'Daily movie screenings for guests',    '18:00:00', '23:00:00'),
-- (10, 10, 2, 'Executive Club', 'Private lounge for VIP guests',        '07:00:00', '23:00:00');

-- INSERT INTO `FoodMenu`
-- (`FoodID`, `FoodName`, `Price`, `CategoryID`, `SectionID`, `FoodStatusID`)
-- VALUES
-- (1,  'Chelow Kabab Koobideh', 3500000.00, 1, 1, 1), 
-- (2,  'Zereshk Polo ba Morgh', 2800000.00, 1, 1, 1), 
-- (3,  'Caesar Salad',           1200000.00, 2, 1, 1), 
-- (4,  'Espresso',                450000.00,  4, 2, 1),
-- (5,  'Caramel Macchiato',       850000.00,  4, 2, 1),
-- (6,  'Chocolate Brownie',       950000.00,  3, 2, 1),
-- (7,  'Pepperoni Pizza',        2200000.00, 6, 1, 1),
-- (8,  'Mojito',                  700000.00,  5, 2, 1),
-- (9,  'Traditional Tea Pot',     600000.00,  4, 2, 1),
-- (10, 'Saffron Ice Cream',       550000.00,  3, 2, 2);

-- INSERT INTO `ProductCategory` (`ProductCategoryID`, `CategoryName`) VALUES
-- (1, 'Personal Care'),
-- (2, 'Beverages'),
-- (3, 'Snacks'),
-- (4, 'Souvenirs'),
-- (5, 'Electronics');

-- INSERT INTO `ProductStatus` (`ProductStatusID`, `StatusName`) VALUES
-- (1, 'Existing'),
-- (2, 'Not Existing');

-- INSERT INTO `Product` (`ProductID`, `ProductName`, `Price`, `ProductCategoryID`, `ProductStatusID`, `Description`) VALUES
-- (1, 'Shampoo & Conditioner Set', 450000.00, 1, 1, 'Travel size premium hair care kit'),
-- (2, 'Mineral Water 500ml', 100000.00, 2, 1, 'Natural spring water'),
-- (3, 'Roasted Pistachios', 1200000.00, 3, 1, 'Premium Iranian saffron roasted pistachios'),
-- (4, 'Mini First Aid Kit', 850000.00, 1, 1, 'Basic medical emergency supplies'),
-- (5, 'Universal Travel Adapter', 1500000.00, 5, 1, 'Compatible with all international outlets'),
-- (6, 'Silk Handwoven Scarf', 4500000.00, 4, 1, 'Traditional Persian silk design'),
-- (7, 'Dark Chocolate Bar', 650000.00, 3, 1, '85% Cocoa premium dark chocolate'),
-- (8, 'Energy Drink', 950000.00, 2, 1, 'Sugar-free 250ml can'),
-- (9, 'Leather Passport Holder', 2200000.00, 4, 1, 'Genuine cow leather handcrafted'),
-- (10, 'Wireless Charging Pad', 3800000.00, 5, 2, 'Fast charging for mobile devices');


-- INSERT INTO `OrderItem` (`OrderID`, `ItemID`, `UnitPrice`, `Quantity`) VALUES
-- (1, 1, 3500000.00, 2),
-- (1, 2, 450000.00, 2),
-- (2, 1, 100000.00, 3),
-- (2, 2, 1200000.00, 1),
-- (3, 1, 2800000.00, 1),
-- (3, 2, 950000.00, 2),
-- (4, 1, 4500000.00, 1),
-- (4, 2, 2200000.00, 1),
-- (5, 1, 2200000.00, 1),
-- (5, 2, 700000.00, 2),
-- (6, 1, 600000.00, 1),
-- (6, 2, 650000.00, 3),
-- (7, 1, 850000.00, 1),
-- (7, 2, 3800000.00, 1),
-- (8, 1, 550000.00, 1),
-- (8, 2, 1500000.00, 1),
-- (9, 1, 3500000.00, 1),
-- (9, 2, 1200000.00, 1),
-- (10, 1, 950000.00, 1),
-- (10, 2, 100000.00, 2);

-- INSERT INTO `OrderItemFood` (`OrderID`, `ItemID`, `FoodID`) VALUES
-- (1, 1, 1),
-- (1, 2, 4),
-- (3, 1, 2),
-- (3, 2, 6),
-- (5, 1, 7),
-- (5, 2, 8),
-- (6, 1, 9),
-- (9, 1, 1),
-- (10, 1, 6);

-- INSERT INTO `OrderItemProduct` (`OrderID`, `ItemID`, `ProductID`) VALUES
-- (2, 1, 2),
-- (2, 2, 3),
-- (6, 2, 7),
-- (7, 1, 4),
-- (7, 2, 10),
-- (8, 2, 5),
-- (10, 2, 2);

-- INSERT INTO `OrderItemBook` (`OrderID`, `ItemID`, `BookID`) VALUES
-- (4, 1, 6),
-- (4, 2, 9),
-- (8, 1, 10),
-- (9, 2, 5);




-- Querys

-- 1 )دمحاسبه مجموع درآمد هر هتل فقط از پرداخت‌های با وضعیت Paid.

-- SELECT h.HotelID,h.HotelName,SUM(p.Amount) AS TotalRevenue
-- FROM Hotel h
-- JOIN Room r ON h.HotelID = r.HotelID
-- JOIN Reservation res ON r.RoomID = res.RoomID
-- JOIN Invoice i ON res.ReservationID = i.ReservationID
-- JOIN Payment p ON i.InvoiceId = p.InvoiceID
-- JOIN PaymentStatus ps ON p.StatusID = ps.StatusID
-- WHERE ps.StatusName = 'Paid'
-- GROUP BY h.HotelID, h.HotelName
-- ORDER BY TotalRevenue DESC;




-- 2)رتبه‌بندی مشتری‌ها بر اساس جمع مبلغ پرداختی‌ (TotalSpent) از روی پرداخت‌های ثبت‌شده

-- SELECT c.CustomerID,c.FirstName,c.LastName,SUM(p.Amount) AS TotalSpent
-- FROM Customer c
-- JOIN Reservation res ON c.CustomerID = res.CustomerID
-- JOIN Invoice i ON res.ReservationID = i.ReservationID
-- JOIN Payment p ON i.InvoiceId = p.InvoiceID
-- GROUP BY c.CustomerID, c.FirstName, c.LastName
-- ORDER BY TotalSpent DESC;



-- 3)استخراج گزارش کامل رزروها (مشتری + هتل + اتاق + نوع اتاق + تاریخ‌ها + وضعیت رزرو).

-- SELECT res.ReservationID,c.FirstName,c.LastName,h.HotelName,r.RoomNumber,rt.TypeName AS RoomType,
--     res.CheckInDate,res.CheckOutDate,res.NumberOfGuests,rst.StatusName AS ReservationStatus
-- FROM Reservation res
-- JOIN Customer c ON res.CustomerID = c.CustomerID
-- JOIN Room r ON res.RoomID = r.RoomID
-- JOIN Hotel h ON r.HotelID = h.HotelID
-- JOIN RoomType rt ON r.RoomTypeID = rt.RoomTypeID
-- JOIN ReservationStatus rst ON res.StatusID = rst.StatusID
-- ORDER BY res.CheckInDate;


-- 4)نمایش خدمات هر رزرو و محاسبه هزینه هر خدمت با فرمول Quantity × PriceAtTime.

-- SELECT res.ReservationID,h.HotelName,s.ServiceName,rs.quantity,rs.PriceAtTime,
--       (rs.quantity * rs.PriceAtTime) AS ServiceTotal
-- FROM ReservationService rs
-- JOIN Reservation res ON rs.ReservationID = res.ReservationID
-- JOIN Service s ON rs.ServiceID = s.ServiceID
-- JOIN Room r ON res.RoomID = r.RoomID
-- JOIN Hotel h ON r.HotelID = h.HotelID
-- ORDER BY res.ReservationID;



-- 5)محاسبه میانگین امتیاز و تعداد Review برای هر هتل و مرتب‌سازی بر اساس امتیاز.

-- SELECT h.HotelID,h.HotelName, ROUND(AVG(rt.RatingNum), 2) AS AverageReviewRating, COUNT(rv.ReviewID) AS ReviewCount
-- FROM Hotel h
-- LEFT JOIN Review rv ON h.HotelID = rv.HotelID
-- LEFT JOIN Rating rt ON rv.RatingID = rt.RatingID
-- GROUP BY h.HotelID, h.HotelName
-- ORDER BY AverageReviewRating DESC, ReviewCount DESC;



-- 6)گزارش پرفروش‌ترین غذاها همراه با تعداد سفارش و مجموع فروش هر غذا.

-- SELECT fm.FoodID,fm.FoodName,fs.SectionName,SUM(oi.Quantity) AS TotalOrdered,
--        SUM(oi.UnitPrice * oi.Quantity) AS TotalSales
-- FROM OrderItemFood oif
-- JOIN OrderItem oi ON oif.OrderID = oi.OrderID AND oif.ItemID = oi.ItemID
-- JOIN FoodMenu fm ON oif.FoodID = fm.FoodID
-- JOIN FoodSection fs ON fm.SectionID = fs.SectionID
-- GROUP BY fm.FoodID, fm.FoodName, fs.SectionName
-- ORDER BY TotalOrdered DESC, TotalSales DESC;



-- 7)نمایش کتاب‌های موجود در هتل‌ها همراه با محل قرارگیری، نویسنده و دسته‌بندی آن‌ها.

-- SELECT h.HotelName,b.Title,a.AuthorName,bc.BookCategoryName,bl.Floor,bl.Section,bl.ShelfNumber
-- FROM Book b
-- JOIN Author a ON b.AuthorID = a.AuthorID
-- JOIN BookCategory bc ON b.BookCategoryID = bc.BookCategoryID
-- JOIN BookStatus bs ON b.BookStatusID = bs.BookStatusID
-- JOIN BookLocation bl ON b.LocationID = bl.LocationID
-- JOIN Hotel h ON bl.HotelID = h.HotelID
-- WHERE bs.BookStatusName = 'Existing'
-- ORDER BY h.HotelName, bl.Section, bl.ShelfNumber;


-- 8)گزارش کارکنان هر هتل به‌همراه سمت، حقوق و تاریخ استخدام.

-- SELECT h.HotelName,s.FirstName,s.LastName,r.RoleName,s.Salary,s.HireDate
-- FROM Staff s
-- JOIN Hotel h ON s.HotelID = h.HotelID
-- JOIN Role r ON s.RoleID = r.RoleID
-- ORDER BY h.HotelName, s.Salary DESC;


-- 9)نمایش لیست سفارش‌ها همراه با مشتری و وضعیت فعلی هر سفارش.

-- SELECT o.OrderID,o.OrderDate,o.OrderTime,c.FirstName,c.LastName,os.StatusName AS OrderStatus
-- FROM `Order` o
-- JOIN Customer c 
--     ON o.CustomerID = c.CustomerID
-- JOIN OrderStatus os 
--     ON o.StatusID = os.StatusID
-- ORDER BY o.OrderDate, o.OrderTime;



-- 10)گزارش فاکتورهای پرداخت‌نشده همراه با مبلغ پرداختی، وضعیت پرداخت و تاریخ سررسید.

-- SELECT i.InvoiceId,c.FirstName,c.LastName,h.HotelName,i.InvoiceDate,i.TotalAmount,ist.StatusName AS InvoiceStatus,
-- 	   p.Amount AS PaidAmount,pst.StatusName AS PaymentStatus,p.PaymentType,p.DueDate
-- FROM Invoice i
-- JOIN Reservation res ON i.ReservationID = res.ReservationID
-- JOIN Customer c ON res.CustomerID = c.CustomerID
-- JOIN Room r ON res.RoomID = r.RoomID
-- JOIN Hotel h ON r.HotelID = h.HotelID
-- JOIN InvoiceStatus ist ON i.StatusID = ist.StatusID
-- LEFT JOIN Payment p ON i.InvoiceId = p.InvoiceID
-- LEFT JOIN PaymentStatus pst ON p.StatusID = pst.StatusID
-- WHERE ist.StatusName = 'Not paid'
-- ORDER BY i.InvoiceDate;
DELIMITER $$

-- CREATE PROCEDURE HotelRevenueCursor()
-- BEGIN

-- DECLARE done INT DEFAULT FALSE;
-- DECLARE v_HotelID INT;
-- DECLARE v_HotelName VARCHAR(100);
-- DECLARE totalRevenue DECIMAL(15,2);

-- DECLARE hotel_cursor CURSOR FOR
-- SELECT HotelID, HotelName
-- FROM Hotel;

-- DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

-- OPEN hotel_cursor;

-- read_loop: LOOP

-- FETCH hotel_cursor INTO v_HotelID, v_HotelName;

-- IF done THEN
-- LEAVE read_loop;
-- END IF;

-- SELECT SUM(p.Amount)
-- INTO totalRevenue
-- FROM Room r
-- JOIN Reservation res ON r.RoomID = res.RoomID
-- JOIN Invoice i ON res.ReservationID = i.ReservationID
-- JOIN Payment p ON i.InvoiceId = p.InvoiceID
-- JOIN PaymentStatus ps ON p.StatusID = ps.StatusID
-- WHERE r.HotelID = v_HotelID
-- AND ps.StatusName = 'Paid';

-- SELECT v_HotelID AS HotelID,
 --      v_HotelName AS HotelName,
 --      totalRevenue AS TotalRevenue;

-- END LOOP;

-- CLOSE hotel_cursor;

-- END$$

-- DELIMITER ;
 -- CALL HotelRevenueCursor();
 -- DELIMITER $$

-- CREATE FUNCTION GetHotelReservationCount(p_HotelID INT)
-- RETURNS INT
-- DETERMINISTIC
-- READS SQL DATA
-- BEGIN
--    DECLARE totalReservations INT;

--    SELECT COUNT(*)
--    INTO totalReservations
--    FROM Reservation r
--    JOIN Room rm ON r.RoomID = rm.RoomID
--    WHERE rm.HotelID = p_HotelID;

--    RETURN totalReservations;
-- END$$

 -- DELIMITER ;
 -- SELECT GetHotelReservationCount(1) AS ReservationCount;

 -- DELIMITER $$

-- CREATE FUNCTION CalculateFinalAmount(p_Amount DECIMAL(15,2))
-- RETURNS DECIMAL(15,2)
-- DETERMINISTIC
-- BEGIN
--    RETURN p_Amount + (p_Amount * 0.10);
-- END$$

-- DELIMITER ;
-- SELECT 
--    PaymentID,
--    Amount,
--    CalculateFinalAmount(Amount) AS FinalAmount
-- FROM Payment;

-- CREATE INDEX idx_room_hotelid
-- ON Room(HotelID);

-- CREATE INDEX idx_reservation_roomid
-- ON Reservation(RoomID);

-- CREATE INDEX idx_reservation_customerid
-- ON Reservation(CustomerID);

-- CREATE INDEX idx_payment_invoiceid
-- ON Payment(InvoiceID);

-- CREATE INDEX idx_invoice_reservationid
-- ON Invoice(ReservationID);
-- DELIMITER $$

START TRANSACTION;

SELECT 
    h.HotelID,
    h.HotelName,
    COALESCE(SUM(p.Amount), 0) AS TotalPaidRevenue,
    COUNT(p.PaymentID) AS PaidPaymentCount
FROM Hotel h
LEFT JOIN Room r 
    ON h.HotelID = r.HotelID
LEFT JOIN Reservation res 
    ON r.RoomID = res.RoomID
LEFT JOIN Invoice i 
    ON res.ReservationID = i.ReservationID
LEFT JOIN Payment p 
    ON i.InvoiceId = p.InvoiceID
LEFT JOIN PaymentStatus ps 
    ON p.StatusID = ps.StatusID
WHERE ps.StatusName = 'Paid'
GROUP BY 
    h.HotelID,
    h.HotelName
ORDER BY TotalPaidRevenue DESC;

COMMIT;



