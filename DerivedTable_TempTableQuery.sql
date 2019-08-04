USE [TSQLV4]
GO
/****** Object:  StoredProcedure [dbo].[GetCustom]    Script Date: 16.07.2019 01:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomQuery]
	-- Add the parameters for the stored procedure here
	@id bigint,
	@country nvarchar(50),
	@postcalcode nvarchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
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

WHERE TQ.OrderId = @id
 AND TQ.PostalCode = @postcalcode 
 AND TQ.Country LIKE '%'+ @country+'%' 
SELECT * FROM #Temp
DROP TABLE #Temp
END
