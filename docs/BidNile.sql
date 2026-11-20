go
CREATE DATABASE BidNile;
go
USE BidNile;
go
CREATE SCHEMA Membership;
go

CREATE TABLE Membership.City (
      CityId INT IDENTITY PRIMARY KEY,
      CityName NVARCHAR(60) NOT NULL,
      CountryCode CHAR(2) NOT NULL
          CONSTRAINT CK_City_CountryCode CHECK (CountryCode IN ('EG', 'SA', 'AE')),
      
      CONSTRAINT UQ_City_CountryCode_CityName UNIQUE (CountryCode, CityName)
      );

go

CREATE TABLE Membership.Member (
      MemberId UNIQUEIDENTIFIER PRIMARY KEY
           CONSTRAINT DF_Member_MemberId DEFAULT NEWID(),

      FullName NVARCHAR(100) NOT NULL ,

      Email VARCHAR(254) NOT NULL 
           CONSTRAINT UQ_Member_Email UNIQUE,

      MobileNumber VARCHAR(16) NOT NULL
           CONSTRAINT CK_Member_MobileNumber CHECK (MobileNumber LIKE '+%' AND LEN(MobileNumber) BETWEEN 8 AND 16),

    NationalIdOrPassport VARCHAR(20) NOT NULL 
          CONSTRAINT UQ_Member_NationalIdOrPassport UNIQUE,

      BirthDate DATE NOT NULL,

       IsVerified BIT NOT NULL
               CONSTRAINT DF_Member_IsVerified DEFAULT 0 ,

        CreatedAt DATETIME2(3) NOT NULL
              CONSTRAINT DF_Member_CreatedAt DEFAULT SYSDATETIME() ,

        CityId INT NOT NULL,
    ReferredByMemberId UNIQUEIDENTIFIER NULL
     CONSTRAINT FK_Member_City FOREIGN KEY (CityId) REFERENCES Membership.City (CityId),
    CONSTRAINT FK_Member_Member FOREIGN KEY (ReferredByMemberId) REFERENCES Membership.Member (MemberId),
    CONSTRAINT CK_Member_ReferredByMemberId CHECK (ReferredByMemberId IS NULL OR ReferredByMemberId <> MemberId)

    );

go

--3.5
go

ALTER TABLE Membership.Member
   ALTER COLUMN FullName NVARCHAR(150) NOT NULL;

go

CREATE TABLE Membership.Wallet(
      MemberId UNIQUEIDENTIFIER PRIMARY KEY
            CONSTRAINT FK_Wallet_Member REFERENCES Membership.Member (MemberId),

    Balance DECIMAL(12,2) NOT NULL
           CONSTRAINT  DF_Wallet_Balance DEFAULT 0
            CONSTRAINT  CK_Wallet_Balance CHECK (Balance >= 0),

    HeldAmount DECIMAL(12,2) NOT NULL
           CONSTRAINT  DF_Wallet_HeldAmount DEFAULT 0,
       

    Currency CHAR(3) NOT NULL 
           CONSTRAINT DF_Wallet_Currency DEFAULT 'EGP',

    UpdatedAt DATETIME2(3) NOT NULL
             CONSTRAINT DF_Wallet_UpdatedAt DEFAULT SYSDATETIME(),

    CONSTRAINT  CK_Wallet_HeldAmount  CHECK (HeldAmount >= 0 AND HeldAmount <= Balance)

    );
  
  -- 3.1
  go

  ALTER TABLE Membership.Member
        DROP CONSTRAINT FK_Member_City;

ALTER TABLE Membership.Member
          DROP CONSTRAINT FK_Member_Member;

ALTER TABLE Membership.Wallet
      DROP CONSTRAINT FK_Wallet_Member;


      ALTER TABLE Membership.Member
           ADD CONSTRAINT FK_Member_City
            FOREIGN KEY (CityId) REFERENCES Membership.City (CityId);
   

ALTER TABLE Membership.Member
          ADD CONSTRAINT FK_Member_ReferredBy
            FOREIGN KEY (ReferredByMemberId) REFERENCES Membership.Member (MemberId);
   

ALTER TABLE Membership.Wallet
           ADD CONSTRAINT FK_Wallet_Member
           FOREIGN KEY (MemberId) REFERENCES Membership.Member (MemberId);
  
  go


  -- 3.2

  go

  ALTER TABLE Membership.Member
            ADD PreferredLanguage CHAR(2) NOT NULL
                 CONSTRAINT DF_Member_PreferredLanguage DEFAULT 'ar' WITH VALUES
                 CONSTRAINT CHK_Member_PreferredLanguage CHECK (PreferredLanguage IN ('ar', 'en'));
    go

    --3.10
    go

    ALTER TABLE Membership.Member
            ADD CONSTRAINT UQ_Member_MobileNumber UNIQUE (MobileNumber); 

go

--3.11
go

ALTER TABLE Membership.Member
        ADD VerifiedAt DATETIME2(0) NULL;

ALTER TABLE Membership.Member
          DROP CONSTRAINT DF_Member_IsVerified;

ALTER TABLE Membership.Member
         DROP COLUMN IsVerified;

go

    go 
    CREATE SCHEMA Operations;
    go

    CREATE TABLE Operations.Warehouse(
            WarehouseId INT IDENTITY NOT NULL
                    CONSTRAINT PK_Warehouse PRIMARY KEY,

          WarehouseName NVARCHAR(80) NOT NULL
                    CONSTRAINT UQ_Warehouse_Name UNIQUE,

         Capacity INT NOT NULL,

        CityId INT NOT NULL
                CONSTRAINT FK_Warehouse_City REFERENCES Membership.City (CityId) ,

         Latitude Float NOT NULL,
                
          Longitude DECIMAL(9,6) NOT NULL,

           CONSTRAINT CK_Warehouse_Capacity CHECK (Capacity > 0),
           CONSTRAINT CK_Warehouse_Latitude CHECK (Latitude BETWEEN -90 AND 90),
              CONSTRAINT CK_Warehouse_Longitude CHECK (Longitude BETWEEN -180 AND 180)
);

go

--3.4
go

ALTER TABLE Operations.Warehouse
       DROP CONSTRAINT CK_Warehouse_Capacity;

EXEC sp_rename 
          'Operations.Warehouse.Capacity', 'MaxItems', 'COLUMN';

ALTER TABLE Operations.Warehouse
        ADD CONSTRAINT CK_Warehouse_MaxItems CHECK (MaxItems > 0);

go

--3.6

go

ALTER TABLE Operations.Warehouse
      DROP CONSTRAINT CK_Warehouse_MaxItems;

ALTER TABLE Operations.Warehouse
     ALTER COLUMN MaxItems SMALLINT NOT NULL;

ALTER TABLE Operations.Warehouse
         ADD CONSTRAINT CK_Warehouse_MaxItems CHECK (MaxItems > 0);

go

CREATE TABLE Operations.Employee(

    MemberId UNIQUEIDENTIFIER NOT NULL
             CONSTRAINT PK_Employee PRIMARY KEY 
             CONSTRAINT FK_Employee_Member REFERENCES Membership.Member (MemberId),

    WarehouseId INT NOT NULL
             CONSTRAINT FK_Employee_Warehouse 
              REFERENCES Operations.Warehouse (WarehouseId)
);

go

--  One employee manages each warehouse — a person manages one warehouse at most — and we keep the date he started managing it.

ALTER TABLE Operations.Warehouse
          ADD ManagerMemberId UNIQUEIDENTIFIER NOT NULL,
          ManagerStartDate DATE NOT NULL;

go

ALTER TABLE Operations.Warehouse
        ADD CONSTRAINT FK_Warehouse_Manager FOREIGN KEY (ManagerMemberId) REFERENCES Operations.Employee (MemberId),
      CONSTRAINT UQ_Warehouse_ManagerMemberId UNIQUE (ManagerMemberId);

go

--3.1

go

ALTER TABLE Operations.Warehouse
          DROP CONSTRAINT FK_Warehouse_City;

ALTER TABLE Operations.Warehouse
          DROP CONSTRAINT FK_Warehouse_Manager;

ALTER TABLE Operations.Employee
           DROP CONSTRAINT FK_Employee_Warehouse;

ALTER TABLE Operations.Employee
         DROP CONSTRAINT FK_Employee_Member;


ALTER TABLE Operations.Warehouse
ADD CONSTRAINT FK_Warehouse_City
    FOREIGN KEY (CityId) REFERENCES Membership.City (CityId);

ALTER TABLE Operations.Warehouse
ADD CONSTRAINT FK_Warehouse_Manager
    FOREIGN KEY (ManagerMemberId) REFERENCES Operations.Employee (MemberId);

ALTER TABLE Operations.Employee
ADD CONSTRAINT FK_Employee_Warehouse
    FOREIGN KEY (WarehouseId) REFERENCES Operations.Warehouse (WarehouseId);

ALTER TABLE Operations.Employee
ADD CONSTRAINT FK_Employee_Member
    FOREIGN KEY (MemberId) REFERENCES Membership.Member (MemberId);

go

CREATE SCHEMA Catalogue;

go

CREATE TABLE Catalogue.Category(
          CategoryId INT NOT NULL
                    CONSTRAINT PK_Category PRIMARY KEY,

         ParentCategoryId INT NULL,
                  

         EnglishName VARCHAR(50) NOT NULL
                    CONSTRAINT UQ_Category_EnglishName UNIQUE,

           ArabicName VARCHAR(50) NOT NULL,

        CommissionRate DECIMAL(4,2) NOT NULL,

        CONSTRAINT CK_Category_CommissionRate CHECK (CommissionRate BETWEEN 0 AND 30),
        CONSTRAINT FK_Category_Category FOREIGN KEY (ParentCategoryId) REFERENCES Catalogue.Category (CategoryId)
       
      );

      go

--3.7 
go

ALTER TABLE Catalogue.Category
           DROP CONSTRAINT CK_Category_CommissionRate;

ALTER TABLE Catalogue.Category
         ADD CONSTRAINT CK_Category_Commission CHECK (CommissionRate >= 0 AND CommissionRate <= 25);

  go

CREATE TABLE Catalogue.Item(
           ItemId INT IDENTITY PRIMARY KEY,

           Title NVARCHAR(150) NOT NULL,

           Description NVARCHAR(MAX) NULL,

           ConditionScore TINYINT NOT NULL,

           Specifications NVARCHAR(MAX) NOT NULL,

           SellerId UNIQUEIDENTIFIER NOT NULL,

            CategoryId INT NOT NULL,

            WarehouseId INT NULL,

            InspectorId UNIQUEIDENTIFIER NULL,

            ListedAt DATETIME2(3) NOT NULL
                         CONSTRAINT DF_Item_ListedAt DEFAULT SYSDATETIME() ,

            CONSTRAINT CK_Item_ConditionScore CHECK (ConditionScore BETWEEN 1 AND 10),
              CONSTRAINT CK_Item_Specifications CHECK (ISJSON(Specifications) = 1),       
               CONSTRAINT FK_Item_Seller FOREIGN KEY (SellerId) REFERENCES Membership.Member (MemberId),
              CONSTRAINT FK_Item_Category FOREIGN KEY (CategoryId) REFERENCES Catalogue.Category (CategoryId),
             CONSTRAINT FK_Item_Warehouse FOREIGN KEY (WarehouseId) REFERENCES Operations.Warehouse (WarehouseId),
           CONSTRAINT FK_Item_Inspector FOREIGN KEY (InspectorId) REFERENCES Operations.Employee (MemberId),
              CONSTRAINT CK_Item_Seller_Inspector CHECK (InspectorId IS NULL OR InspectorId <> SellerId)       
            );

    --3.3
    go

    ALTER TABLE Catalogue.Item
          ADD IsFeatured BIT NOT NULL
              CONSTRAINT DF_Item_IsFeatured DEFAULT 0 ;

    go

CREATE TABLE Catalogue.ItemPhoto(
           ItemId INT NOT NULL
                   CONSTRAINT FK_ItemPhoto_Item REFERENCES Catalogue.Item (ItemId) ON DELETE CASCADE,

          Position TINYINT NOT NULL,

           Url VARCHAR(500) NOT NULL,

           IsMain BIT NOT NULL
                    CONSTRAINT DF_ItemPhoto_IsMain DEFAULT 0 ,

           CONSTRAINT PK_ItemPhoto PRIMARY KEY (ItemId, Position),
           CONSTRAINT CK_ItemPhoto_Position CHECK (Position BETWEEN 1 AND 20)
        );
                      
    go 


    --3.1
    go

    ALTER TABLE Catalogue.Category
            DROP CONSTRAINT FK_Category_Category;

ALTER TABLE Catalogue.Item
         DROP CONSTRAINT FK_Item_Category;

ALTER TABLE Catalogue.Item
      DROP CONSTRAINT FK_Item_Seller;

ALTER TABLE Catalogue.Item
        DROP CONSTRAINT FK_Item_Warehouse;

ALTER TABLE Catalogue.Item
        DROP CONSTRAINT FK_Item_Inspector;

ALTER TABLE Catalogue.ItemPhoto
      DROP CONSTRAINT FK_ItemPhoto_Item;


ALTER TABLE Catalogue.Category
ADD CONSTRAINT FK_Category_ParentCategory
    FOREIGN KEY (ParentCategoryId) REFERENCES Catalogue.Category (CategoryId);

ALTER TABLE Catalogue.Item
ADD CONSTRAINT FK_Item_Category
    FOREIGN KEY (CategoryId) REFERENCES Catalogue.Category (CategoryId);

ALTER TABLE Catalogue.Item
ADD CONSTRAINT FK_Item_Seller
    FOREIGN KEY (SellerId) REFERENCES Membership.Member (MemberId);

ALTER TABLE Catalogue.Item
ADD CONSTRAINT FK_Item_Warehouse
    FOREIGN KEY (WarehouseId) REFERENCES Operations.Warehouse (WarehouseId);

ALTER TABLE Catalogue.Item
ADD CONSTRAINT FK_Item_Inspector
    FOREIGN KEY (InspectorId) REFERENCES Operations.Employee (MemberId);

ALTER TABLE Catalogue.ItemPhoto
ADD CONSTRAINT FK_ItemPhoto_Item
    FOREIGN KEY (ItemId) REFERENCES Catalogue.Item (ItemId)
    ON DELETE CASCADE;

go

    CREATE SCHEMA Auctions;

    go

    CREATE TABLE Auctions.Auction(

            AuctionId BIGINT IDENTITY NOT NULL
                         CONSTRAINT PK_Auction PRIMARY KEY,

             ItemId INT NOT NULL
                      CONSTRAINT FK_Auction_Item REFERENCES Catalogue.Item (ItemId),
             
             StartingPrice DECIMAL(12,2) NOT NULL,

              ReservePrice DECIMAL(12,2) NULL, 

           BidIncrement DECIMAL(12,2) NOT NULL
                        CONSTRAINT DF_Auction_BidIncrement DEFAULT 50.00,

           StartsAt DATETIMEOFFSET(3) NOT NULL,

           EndsAt DATETIMEOFFSET(3) NOT NULL,

    Status VARCHAR(10) NOT NULL
        CONSTRAINT DF_Auction_Status DEFAULT 'Draft',

    CONSTRAINT CK_Auction_StartingPrice CHECK (StartingPrice > 0),
    CONSTRAINT CK_Auction_ReservePrice CHECK (ReservePrice IS NULL OR ReservePrice >= StartingPrice),
    CONSTRAINT CK_Auction_BidIncrement CHECK (BidIncrement > 0),
    CONSTRAINT CK_Auction_Dates CHECK (EndsAt > StartsAt),
    CONSTRAINT CK_Auction_Status CHECK (Status IN ('Draft', 'Live', 'Ended', 'Cancelled'))
);

go

--3.8
go

ALTER TABLE Auctions.Auction
       DROP CONSTRAINT CK_Auction_Status; 

ALTER TABLE Auctions.Auction
    ADD CONSTRAINT CK_Auction_Status
         CHECK (Status IN ('PendingReview', 'Draft', 'Live', 'Ended', 'Cancelled'));

ALTER TABLE Auctions.Auction
          DROP CONSTRAINT DF_Auction_Status;
          
ALTER TABLE Auctions.Auction
          ADD CONSTRAINT DF_Auction_Status DEFAULT 'PendingReview' FOR Status;

go

--3.9
go

ALTER TABLE Auctions.Auction
        ADD BuyNowPrice DECIMAL(12, 2) NULL;

-- with check --> عشان بيشوف كل القيم حتي القديمة في الجدول اللي قبل مااعمل ال constraint ده ويشوفها لو بتحقق الشرط ده ليا 
ALTER TABLE Auctions.Auction
        WITH CHECK ADD CONSTRAINT CK_Auction_BuyNowPrice_Gt_Start
                CHECK (BuyNowPrice IS NULL OR BuyNowPrice > StartingPrice); 

go

CREATE TABLE Auctions.Bid(
           BidId BIGINT IDENTITY 
                  CONSTRAINT PK_Bid PRIMARY KEY,

            AuctionId BIGINT NOT NULL
                   CONSTRAINT FK_Bid_Auction REFERENCES Auctions.Auction (AuctionId),

              BidderId UNIQUEIDENTIFIER NOT NULL
                    CONSTRAINT FK_Bid_Member REFERENCES Membership.Member (MemberId),

             Amount DECIMAL(12,2) NOT NULL,

                PlacedAt DATETIME2(3) NOT NULL
                       CONSTRAINT DF_Bid_PlacedAt DEFAULT SYSDATETIME(),

             IpAddress VARCHAR(45) NOT NULL,

             CONSTRAINT CK_Bid_Amount CHECK (Amount > 0),
            CONSTRAINT UQ_Bid_Auction_Amount UNIQUE (AuctionId, Amount)
);

go

-- 3.4
go

EXEC sp_rename 
         'Auctions.Bid.IpAddress', 'DeviceIp', 'COLUMN';



go

CREATE TABLE Auctions.AuctionFollower(
                AuctionId BIGINT NOT NULL
                           CONSTRAINT FK_AuctionFollower_Auction REFERENCES Auctions.Auction (AuctionId),

                MemberId UNIQUEIDENTIFIER NOT NULL
                       CONSTRAINT FK_AuctionFollower_Member REFERENCES Membership.Member (MemberId),

                 FollowedAt DATETIME2(3) NOT NULL
                       CONSTRAINT DF_AuctionFollower_FollowedAt DEFAULT SYSDATETIME(),

                 CONSTRAINT PK_AuctionFollower PRIMARY KEY (AuctionId, MemberId)
);

go

-- 3.1
go

ALTER TABLE Auctions.Auction
          DROP CONSTRAINT FK_Auction_Item;

ALTER TABLE Auctions.Bid
        DROP CONSTRAINT FK_Bid_Auction;

ALTER TABLE Auctions.Bid
        DROP CONSTRAINT FK_Bid_Member;

ALTER TABLE Auctions.AuctionFollower
          DROP CONSTRAINT FK_AuctionFollower_Auction;

ALTER TABLE Auctions.AuctionFollower
         DROP CONSTRAINT FK_AuctionFollower_Member;

ALTER TABLE Auctions.Auction
ADD CONSTRAINT FK_Auction_Item
    FOREIGN KEY (ItemId) REFERENCES Catalogue.Item (ItemId);

ALTER TABLE Auctions.Bid
ADD CONSTRAINT FK_Bid_Auction
    FOREIGN KEY (AuctionId) REFERENCES Auctions.Auction (AuctionId);

ALTER TABLE Auctions.Bid
ADD CONSTRAINT FK_Bid_Bidder
    FOREIGN KEY (BidderId) REFERENCES Membership.Member (MemberId);

ALTER TABLE Auctions.AuctionFollower
ADD CONSTRAINT FK_AuctionFollower_Auction
    FOREIGN KEY (AuctionId) REFERENCES Auctions.Auction (AuctionId);

ALTER TABLE Auctions.AuctionFollower
ADD CONSTRAINT FK_AuctionFollower_Member
    FOREIGN KEY (MemberId) REFERENCES Membership.Member (MemberId);

go

--3.12
go

CREATE SCHEMA Marketing;
go


ALTER SCHEMA Marketing
        TRANSFER Auctions.AuctionFollower; 

go