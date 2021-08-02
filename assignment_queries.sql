#use Rent_A_Room_House;


#---------------FROM OWNER-------------

#1. Sign Up

INSERT INTO USER (FName, LName, Email, Password)
VALUES('Nick','Shaw','nickshaw@gmail.com','nick123');


#2. Login

INSERT INTO USER (Email, Password)
VALUES ('nickshaw@gmail.com','nick123');



#3. Initizlize OWNER Profile with OwnerID = 1

INSERT INTO OWNER (FName, LName, BirthDate, Email, Password, PhoneNumber, BankName, AccountType, AccountNumber)
VALUES ('Nick', 'Shaw', '1992-02-04', 'nickshaw@gmail.com', 'nick123', 9837728932, 'Bank Of America', 'Savings', 01882991882);



#4 Modify OWNER detail with OwnerID = 1

UPDATE OWNER
SET FName = 'Harry' , AccountNumber = '019827738928', BirthDate = '1992-02-14'
WHERE OwnerID = 1;



#5 InnerJoin Three Tables USER, OWNER and LOCATION Tables Into One Table To Get All Profile Information Of Owner

SELECT OWNER.OwnerID,OWNER.BankName,OWNER.AccountType,OWNER.AccountNumber,USER.FName,USER.LName,USER.BirthDate,
	   USER.Email,USER.Password,USER.PhoneNumber,USER.Gender,LOCATION.Country,LOCATION.City,LOCATION.ZipCode
FROM 
OWNER INNER JOIN USER
ON OWNER.USER_userID = USER.userID
INNER JOIN LOCATION 
ON OWNER.LOCATION_LocationID = LOCATION.LocationID;



#6 Search records of first Ten Thousnd OWNER Whose Bank AccountType is 'checking Account'

SELECT * FROM OWNER
WHERE
AccountType = "checking account"
AND 
OwnerID <= 10000;



#7 Now Owner Inserts Records Of The Room Or House That Is To Be Rented with UnitID = 1

INSERT INTO UNIT (StreetName, StreetNumber, CostPerMonth, Availability, UnitType,
			      LOCATION_LocationID, OWNER_OwnerID, FACILITY_FacilityID)
			VALUES ('Westland Avenue', 12, 800, 'YES', 'Room', 1, 1, 1);

INSERT INTO FACILITIES ( BedCount, BathCount, FloorCount, RoomCount, OtherDetails)
VALUES (2,1,1,2,'Near to the train station and public library.');



#8 Search Records Of UNIT Whose Availability is YES And Rent Per Month Is Less Than 500

SELECT UnitID, Availability, StreetName, StreetNumber, CostPerMonth, FACILITY_FacilityID FROM UNIT
WHERE
Availability = "YES"
AND
CostPerMonth <= 400;
 

#9 Count The Total Number Of Unit Which Is Available To Rent.

SELECT COUNT(Availability)  FROM UNIT
WHERE
Availability = "YES";



#10 Find Out Which Room Or House Has The Highest Rent. (Using MAX)

SELECT MAX(CostPerMonth) AS HighestRent, UnitID, UnitType 
FROM UNIT;



#11 Find Out WHich Room Or House Has The Lowest Rent. (Using MIN)

SELECT MIN(CostPerMonth) AS LowestRent, UnitID, UnitType 
FROM UNIT;



#12 What Is The Avarage Rent Of A House in Toronto city?

SELECT AVG(CostPerMonth) AS AvgRent
FROM UNIT
WHERE
UnitType = "House"
AND 
City = "Toronto";



#13 Join Two Tables (LOCATION + UNIT) and count the number of unit available to rent in different cities. 
# (Using Count and Group By)

SELECT LOCATION.City, COUNT(UNIT.Availability) AS Total
FROM LOCATION INNER JOIN UNIT
ON UNIT.LOCATION_LocaionID = LOCATION.LocationID
WHERE UNIT.Availability = "YES"
Group By City;



#14 Search and Display All the Units to rent which is in the city Toronto.
# (Using Subquery or Nested Query)

SELECT * FROM UNIT 
WHERE City = (SELECT LocationID FROM LOCATION WHERE City = "Toronto");



#15 Search and Display All the Units to rent which are in the cities Toronto, Brampton and Oakville.
# (Using Subquery or Nested Query, this includes IN Operator)

SELECT * FROM UNIT 
WHERE City IN (SELECT LocationID FROM LOCATION WHERE City IN ("Toronto","Brampton","Oakville"));






#---------------------FROM RENTER---------------------

#16 Sign Up

INSERT INTO RENTER(FName, LName, Email, Password)
VALUES('Brad','Pitt','bradpitt@gmail.com','brad123');


#17. Login

INSERT INTO RENTER(Email, Password)
VALUES ('bradpitt@gmail.com','brad123');



#18. Initizlize RENTER Profile with RenterID = 1

INSERT INTO RENTER (FName, LName, BirthDate, Email, Password, PhoneNumber, CardNumber, SecurityCode, NameOnCard)
VALUES ('Brad','Pitt','1992-02-04','bradpitt@gmail.com','brad123', 9837728932, 648837729, 433,'Brad W. Pitt');



#19 Modify RENTER detail with RenterID = 1
# (Use Commit and rollback)

UPDATE RENTER
SET FName = 'Harry' , AccountNumber = '442227738928', BirthDate = '1991-02-14'
WHERE RenterID = 1;


INSERT INTO RENTER (Gender)
VALUES ('Male');


COMMIT;

UPDATE RENTER
SET AccountNumber = '8878838827664'
WHERE RenterID = 1;

ROLLBACK;  #Deletes previous one step only.



#20. InnerJoin Three Tables USER, RENTER and LOCATION Tables Into One Table To Get All Profile Information Of Renter

SELECT  RENTER.OwnerID, RENTER.CardNumber, RENTER.SecurityCode, RENTER.NameOnCard, USER.FName,USER.LName,
		USER.BirthDate,	USER.Email, USER.Password, USER.PhoneNumber, USER.Gender, LOCATION.Country, LOCATION.City,
		LOCATION.ZipCode
FROM 
RENTER INNER JOIN USER
ON RENTER.USER_userID = USER.userID
INNER JOIN LOCATION 
ON RENTER.LOCATION_LocationID = LOCATION.LocationID;



#21. Show All The Booking History of a Renter Whose RenterID is 23 and sort by date.

SELECT * FROM BOOKING 
WHERE RENTER_RenterID = 23
ORDER BY StartDate DESC;


#22. Show ALL The Reviews of the Unit whose UnitID is 15 and sort by date.

SELECT * FROM REVIEWS
WHERE UNIT_UnitID = 15
ORDER BY ReviewDate DESC; 


#23 Initialize A Refund whose TransactionID is 38.

INSERT INTO REFUND (RefundID, TRANSACTION_TransactionID, TimeStamp, RefundDescription, AmountDeducted )
VALUES (1, 38, '2020-03-12.00', 'Donot want to live in this unit anymore.', 400);

 







 
 