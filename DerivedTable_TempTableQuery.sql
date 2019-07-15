USE TSQLV4
CREATE TABLE #Temp(
        id int,
	    value1 nvarchar(50),
		value2 nvarchar(50),
		value3 nvarchar(50),	
		value4 nvarchar(50),
		value5 nvarchar(50),
		value6 nvarchar(50),
		value7 nvarchar(50),
		value8 nvarchar(50),
		value9 nvarchar(50),
		value10 nvarchar(50),
)

INSERT INTO  #Temp
SELECT TQ.* FROM (
SELECT
DISTINCT 
  o.orderid as 'OrderId',
  LOWER(c.companyname) as 'CompanyName',
  UPPER(e.country) as 'Country',
  s.phone as 'Phone',
  o.shipaddress as 'ShipAddress',
  c.postalcode as 'PostalCode',
  (o.freight * 20) as 'Freight',
  CAST(e.birthdate as nvarchar) as 'BirthDate',
  c.fax,
  o.shipname,
  CAST(o.shippeddate as date) as 'ShippedDate'
  FROM Sales.orders o
LEFT JOIN Sales.Customers c on c.custid = o.custid
LEFT JOIN HR.Employees E ON E.empid = o.empid
LEFT JOIN Sales.Shippers s ON S.shipperid = O.shipperid
WHERE  o.custid IN (SELECT TOP 1 custid FROM Sales.Customers sc WHERE sc.contacttitle = 'Owner')
)TQ
SELECT * FROM #Temp
DROP TABLE #Temp