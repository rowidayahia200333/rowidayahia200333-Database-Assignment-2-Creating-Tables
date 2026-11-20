
//Task 3
//3.9

// with check --> عشان بيشوف كل القيم حتي القديمة في الجدول اللي قبل مااعمل ال constraint ده ويشوفها لو بتحقق الشرط ده ليا 








 # BidNile 

## 1. Schemas, Tables, and Why
- **Membership (City, Member, Wallet):** Groups user identity, profile/verification data, referral links, and financial balances in one bounded domain.
- **Operations (Warehouse, Employee):** Separates physical storage facilities, capacity/coordinates, and warehouse staff/management assignments.
- **Catalogue (Category, Item, ItemPhoto):** Organizes product hierarchy, commission rates, item specs (JSON), inspection/warehouse placement, and gallery photos.
- **Auctions (Auction, Bid)** *(plus Marketing.AuctionFollower after schema transfer)*: Isolates live bidding state, schedules with time zones, bid history, and follower engagement.

## 2. Relationship Types in BidNile & How They Were Mapped
- 1:1: Membership.Member to Membership.Wallet — Wallet.MemberId is both PRIMARY KEY and FOREIGN KEY referencing Member(MemberId) (and similarly warehouse-to-manager uniqueness via UNIQUE (ManagerMemberId)).
- 1:N: Membership.City to Membership.Member, Catalogue.Category to Catalogue.Item, Catalogue.Item to Catalogue.ItemPhoto, Auctions.Auction to Auctions.Bid — FOREIGN KEY placed on the child ("many") table.
- M:N: Auctions.Auction and Membership.Member (following auctions) — resolved via associative table AuctionFollower with composite primary key (AuctionId, MemberId) (later moved to Marketing.AuctionFollower).
- Recursive (Self-referencing): Membership.Member.ReferredByMemberId -> Membership.Member.MemberId and Catalogue.Category.ParentCategoryId -> Catalogue.Category.CategoryId — nullable FK pointing to the same table's PK, plus a CHECK constraint preventing self-referral (ReferredByMemberId <> MemberId).
- Circular: Operations.Warehouse.ManagerMemberId -> Operations.Employee.MemberId while Operations.Employee.WarehouseId -> Operations.Warehouse.WarehouseId — modeled with FKs on both sides and resolved during execution/data load by deferring/toggling the constraint or inserting in stages.
- Weak Entity: Catalogue.ItemPhoto — depends on Catalogue.Item (ON DELETE CASCADE) with a composite primary key (ItemId, Position) where Position orders photos within an item.

## 3. Data Type Choices
- **GUID (UNIQUEIDENTIFIER) for MemberId:** Avoids predictable sequential IDs for user accounts and supports safe distributed/client-side ID generation (NEWID()).
- **BIGINT for BidId (and AuctionId):** Bids grow at high volume over time, so BIGINT prevents integer overflow compared to INT.
- **FLOAT for GPS (Latitude) vs. DECIMAL for money (Balance, StartingPrice, BidIncrement, etc.):** FLOAT is suitable for continuous geographic coordinates, whereas DECIMAL(p, s) guarantees exact base-10 precision without floating-point rounding errors on currency and financial amounts.
- **DATETIMEOFFSET for auctions (StartsAt, EndsAt):** Preserves the exact UTC offset (+02:00, +03:00, etc.) across time zones so auction start/end times are unambiguous regardless of server local time.

## 4. Why the Circular Relationship Can't Be Created Inside a Single CREATE TABLE
When Operations.Warehouse references Operations.Employee and Operations.Employee references Operations.Warehouse, neither table exists yet when the first CREATE TABLE runs—so SQL Server cannot bind the foreign key to the target table until the second table is created and the cross-reference is added (via ALTER TABLE or adding one FK after both tables exist).

## 5. Table Population Order & Why
Parent/referenced tables must be populated before dependent child tables so foreign keys always find matching parent keys:
1. Membership.City
2. Membership.Member (root/referrer rows before referred rows)
3. Membership.Wallet
[11/20/2026 8:02 PM] Rowida Yahia: 4. Operations.Warehouse & Operations.Employee (handling the Warehouse <-> Employee circular reference cleanly)
5. Catalogue.Category (parent categories before subcategories)
6. Catalogue.Item
7. Catalogue.ItemPhoto
8. Auctions.Auction
9. Auctions.Bid
10. Marketing.AuctionFollower

## 6. Errors in 3.6 and 3.11 & How They Were Fixed
- **3.6 (MaxItems type change):** Altering column type or constraint on Operations.Warehouse.MaxItems required dropping/recreating dependent check constraints (CK_Warehouse_MaxItems) around the ALTER COLUMN statement so SQL Server wouldn't block the type change due to bound constraints.
- **3.11 (IsVerified removal & VerifiedAt addition):** Dropping IsVerified required dropping its default constraint (DF_Member_IsVerified) first before ALTER TABLE ... DROP COLUMN IsVerified, while adding VerifiedAt DATETIME2(0) NULL.

## 7. Task 5 Hand Trace (nums = [1, 2, 3, 4])
- **Prefix (before i):** i=0 -> 1, i=1 -> 1, i=2 -> 2, i=3 -> 6 ([1, 1, 2, 6])
- **Suffix (after i):** i=3 -> 1, i=2 -> 4, i=1 -> 12, i=0 -> 24 ([24, 12, 4, 1])
- **Result (prefix * suffix):** [24, 12, 8, 6]