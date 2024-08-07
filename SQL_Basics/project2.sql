/*
Data cleaning
*/

select top(10) *
from HousingData..NashvileHousing



---------------------------------------------------------------------------------------------------------
-- edit date format (datetime->date)

select top(10) SaleDate
from HousingData..NashvileHousing

-- how it should look
select SaleDate, CONVERT(Date, SaleDate)
from HousingData..NashvileHousing

--apply change
--- "this may or may not work" he says????? (didn't for me)
Update HousingData..NashvileHousing
SET SaleDate = CONVERT(Date, SaleDate)
select top(10) SaleDate
from HousingData..NashvileHousing


-- add column
Alter Table HousingData..NashvileHousing
Add SaleDateConverted Date
-- fill column
Update HousingData..NashvileHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)
-- check
select top(10) SaleDate, SaleDateConverted
from HousingData..NashvileHousing


---------------------------------------------------------------------------------------------------------
-- populate property address
select *
from HousingData..NashvileHousing
where PropertyAddress is NULL
order by ParcelID
--- some values are missing

-- Assumption: if parcelId is the same -> PropertyAddress is the same
--	-> add address from other field with matching parcelId if exists
select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
-- join on self where identical parcelId, assert not same entry with uniqueId
from HousingData..NashvileHousing as a
JOIN HousingData..NashvileHousing as b
	on a.ParcelID  = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is NULL

-- isnull(<if this is null>, <use this>) (TODO check)
-- eg also possible: ISNULL(a.PropertyAddress, 'No Address')
Update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from HousingData..NashvileHousing as a
JOIN HousingData..NashvileHousing as b
	on a.ParcelID  = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is NULL


---------------------------------------------------------------------------------------------------------
-- split address in columns: address, city, state
-- here all entries are "<address>, <city>" with no other commas
select PropertyAddress
from HousingData..NashvileHousing

-- SUBSTRING(<string><startIdx><length>)
-- CHARINDEX(<searched><stringToBeSearched>[<startLoc>])

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)) as AddressInclComma,
CHARINDEX(',', PropertyAddress) as PosOfComma
from HousingData..NashvileHousing

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+2, LEN(PropertyAddress)) as City
from HousingData..NashvileHousing

-- add columns for address-, city-only substrings 
Alter Table HousingData..NashvileHousing
Add PropertySplitAddress nvarchar(255)

Update HousingData..NashvileHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)


Alter Table HousingData..NashvileHousing
Add PropertySplitCity nvarchar(255)

Update HousingData..NashvileHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+2, LEN(PropertyAddress))


select PropertyAddress, PropertySplitAddress, PropertySplitCity
from HousingData..NashvileHousing




-- here all entries are "<address>, <city>, <state>" with no other commas
--PARSENAME(<string>, <idx>) spliting string by "." returning hits, idx starting with last
select
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from HousingData..NashvileHousing

-- put into new columns
Alter Table HousingData..NashvileHousing
Add OwnerSplitAddress nvarchar(255)

Alter Table HousingData..NashvileHousing
Add OwnerSplitCity nvarchar(255)

Alter Table HousingData..NashvileHousing
Add OwnerSplitState nvarchar(255)

Update HousingData..NashvileHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

Update HousingData..NashvileHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

Update HousingData..NashvileHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

select OwnerAddress, OwnerSplitAddress, OwnerSplitCity, OwnerSplitState
from HousingData..NashvileHousing


---------------------------------------------------------------------------------------------------------
-- change "y", "n" to yes/no

-- TODO turn this into flashcard
select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from HousingData..NashvileHousing
group by SoldAsVacant
order by 2 DESC

-- TODO flashcard
select SoldAsVacant
, CASE When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		End as corrected
from HousingData..NashvileHousing
group by SoldAsVacant

Update HousingData..NashvileHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		End

---------------------------------------------------------------------------------------------------------
-- remove duplicates (not standard practice to do in sql but possible)

-- partition on values that should be unique (for this exercise pretend "UniqueId" does not exist)

-- add col row_num -> "this is n-th row with this data" -> if row_num > 1 data is duplicate
select *, 
ROW_NUMBER() OVER (
	PARTITION BY ParcelID, 
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY
					UniqueID
) row_num
from HousingData..NashvileHousing
order by ParcelID
--where row_num > 1 -- would be great - but cant be used without putting into cte first

with RowNumCTE as(
	select *, 
	ROW_NUMBER() OVER (
		PARTITION BY ParcelID, 
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					ORDER BY
						UniqueID
	) row_num
	from HousingData..NashvileHousing
	-- cant contain order by
)
select * --  to check
--delete -- to remove duplicates
from RowNumCTE
where row_num > 1

---------------------------------------------------------------------------------------------------------
-- delete unused columns (rarely in raw data, rather in views)


select top(10) *
from HousingData..NashvileHousing

Alter table HousingData..NashvileHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate










