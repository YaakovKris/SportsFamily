# SportsFamily
BI Documentation SportsFamily
Company Description:
SportsFamily is an international chain of online store of sportswear and equipment for an active lifestyle. The company mainly operates in Europe (EU and Great Britain), both its clients and agents locate in Europe. SportsFamily exports products from the US market as well, therefore, transactions are performed in 3 currencies: EUR, GBP and USD.
SportsFamily sells sportswear and sports equipment, both for outdoor and indoor activities, including winter, summer, and water sports. The company works with wholesale customers only who further realize their products throughout Europe, therefore, each client belongs to a company. To manage business process, find new products and clients, SportsFamily uses the outsource agencies.
SportsFamily rapidly expanded in 2021, however due to specific demand for sportswear and sports equipment the company's revenues exhibit seasonality.
System Description:
The system implements a BI solution for the company which includes gathering the data, processing the data from the operational database to data warehouse, and analyzing it efficiently to achieve business goals. The analysis includes general overview, and drill in products, categories, agents, and clients as well as geographic analysis.
Goals of the System:
The system allows to implement efficient business solutions, analyze the large scale data and improve the processes to achieve strategic goals.
System Tools:
BI solution allows efficient storage of the data in the data warehouse. SportsFamily uses a Priority ERP system for its daily transactions. The solution presents transformation of the data from the ERP to the DWH.
DWH Tables:
•	DimAgents: the table includes all the relevant information about the agents who work with the company
•	DimCategories: the table consists of the data on categories of the products including general type, and a more specific category
•	DimClients: the table includes the data on customers of the shop who belong to the companies they work for (the shop does not work with end users, rather with official resellers)
•	DimCompanies: the table consists of the data on companies that resell the products, each client belongs to a company
•	DimCountries: the table consists of the list of countries in which the operations of the company take place as well as a more general region within Europe to which the country belongs
•	DimCurrencies: the table includes the data on the currencies in which the operation took place, the exchange rate, and the date for the last update of the exchange rate
•	DimProducts: the table consists of all the data about the product except for its price (for the purposes of the analysis the price is stored in the FactSales table)
•	FactSales: the table shows all the sales including details of each transaction
Technologies Used:
The operational database and DWH are based on the ERP Priority realized using SQL Management Studio (SQL Server).
For the ETL process the SSIS is used: the data from the sources is transferred to MRR tables using incremental load, then, the data transferred to STG. Finally, the data is transformed and transferred to the DWH. To perform the incremental load the CDC is used. The SSIS solution consists of 4 packages: OneTime, Extract, Load, Transform:
•	OneTime: the package is implemented only once at the beginning of the project: all the data from the ERP Priority is transferred to the DWH
•	Extract: the package is used to extract the new data from the operational DB to the MRR tables. 
•	Load: the package is used to load the new data from the MRR tables to STG tables
•	Transform: the data is transformed and uploaded to the DWH
Data Sources:
All the data is stored in the operational database, no outer sources are used.
ETL Process:
The ETL process allows efficient transfer of the data from operational DB to DWH and its transformation from OLTP to OLAP needs. The ETL process is based on incremental load which is performed on daily basis. At the beginning of the project all relevant data (for the past 3 years) is transferred to the DWH. For the operational DB and each source table in the DB CDC is enabled. The process consists of 3 ETL stages: extract (Source to MRR), load (MRR to STG), and transform (STG to DWH):
•	Extract: to extract data from Source to MRR CDC is used. First, CDC allows to mark the last update datetime, and implement incremental load, i.e., to modify (insert/update/delete) only those records that were affected in that period time. The CDC splitter is used to distinguish between inserted, updated, and deleted records, and then this data is uploaded to MRR tables.
•	Load: at this stage data is transferred from MRR to STG. At this stage inserted and updated records are added while deleted and updated records are deleted from the DWH. Tables Categories and CategoryType are merged in one table STG_DimCategories. Tables Countries, CountryRegion, and Regions are merged in a table STG_DimCountries. Tables Invoices and InvoiceItems are joined in table FactSales. In addition, product price from table Products is merged with table FactSales and deleted from table Products.
•	Transfer: the data is transformed (mostly Unicode to non-Unicode data conversion) and uploaded to the DWH (DimTables and FactSales).
 
 
ERD מסד הנתונים Priority ERP
 

Source to Target:
DWH	STG	MRR	Database
DimAgents.ActiveStatus	STG_DimAgents.ActiveStatus	MRR_Agents.ActiveStatus	Agents.ActiveStatus
DimAgents.Address	STG_DimAgents.Address	MRR_Agents.Address	Agents.Address
DimAgents.AgentID	STG_DimAgents.AgentID	MRR_Agents.AgentID	Agents.AgentID
DimAgents.City	STG_DimAgents.City	MRR_Agents.City	Agents.City
DimAgents.CompanyName	STG_DimAgents.CompanyName	MRR_Agents.CompanyName	Agents.CompanyName
DimAgents.Country	STG_DimAgents.Country	MRR_Agents.Country	Agents.Country
DimAgents.Email	STG_DimAgents.Email	MRR_Agents.Email	Agents.Email
DimAgents.Fee	STG_DimAgents.Fee	MRR_Agents.Fee	Agents.Fee
DimAgents.Phone	STG_DimAgents.Phone	MRR_Agents.Phone	Agents.Phone
DimAgents.ZIP	STG_DimAgents.ZIP	MRR_Agents.ZIP	Agents.ZIP
			
DimCategories.CategoryName	STG_DimCategories.CategoryName	MRR_Categories.CategoryName	Categories.CategoryName
		MRR_Categories.CategoryType	Categories.CategoryType
DimCategories.CategoryID	STG_DimCategories.CategoryID	MRR_Categories.CategoryID	Categories.CategoryID
DimCategories.Type	STG_DimCategories.Type	From MRR_CategoryTypes.TypeName	
			
	Joined with Categories	MRR_CategoryTypes.ID	CategoryTypes.ID
	Joined with Categories	MRR_CategoryTypes.TypeName	CategoryTypes.TypeName
			
DimClients.ClientID	STG_DimClients.ClientID	MRR_Clients.ClientID	Clients.ClientID
DimClients.Company	STG_DimClients.Company	MRR_Clients.Company	Clients.Company
DimClients.Email	STG_DimClients.Email	MRR_Clients.Email	Clients.Email
DimClients.FirstName	STG_DimClients.FirstName	MRR_Clients.FirstName	Clients.FirstName
DimClients.LastName	STG_DimClients.LastName	MRR_Clients.LastName	Clients.LastName
DimClients.Title	STG_DimClients.Title	MRR_Clients.Title	Clients.Title
			
DimCompanies.Address	STG_DimCompanies.Address	MRR_Companies.Address	Companies.Address
DimCompanies.City	STG_DimCompanies.City	MRR_Companies.City	Companies.City
DimCompanies.CompanyName	STG_DimCompanies.CompanyName	MRR_Companies.CompanyName	Companies.CompanyName
DimCompanies.Country	STG_DimCompanies.Country	MRR_Companies.Country	Companies.Country
DimCompanies.ID	STG_DimCompanies.ID	MRR_Companies.ID	Companies.ID
DimCompanies.Phone	STG_DimCompanies.Phone	MRR_Companies.Phone	Companies.Phone
DimCompanies.ZIP	STG_DimCompanies.ZIP	MRR_Companies.ZIP	Companies.ZIP
			
DimCountries.CountryName	STG_DimCountries.CountryName	MRR_Countries.CountryName	Countries.CountryName
DimCountries.ID	STG_DimCountries.ID	MRR_Countries.ID	Countries.ID
DimCountries.Region	STG_DimCountries.Region	From MRR_Regions.RegionName	
			
	Joined with Countries	MRR_CountryRegion.CountryID	CountryRegion.CountryID
	Joined with Countries	MRR_CountryRegion.ID	CountryRegion.ID
	Joined with Countries	MRR_CountryRegion.RegionID	CountryRegion.RegionID
			
DimCurrencies.Currency	STG_DimCurrencies.Currency	MRR_Currencies.Currency	Currencies.Currency
DimCurrencies.CurrencyID	STG_DimCurrencies.CurrencyID	MRR_Currencies.CurrencyID	Currencies.CurrencyID
DimCurrencies.Exchange	STG_DimCurrencies.Exchange	MRR_Currencies.Exchange	Currencies.Exchange
DimCurrencies.ExchangeDate	STG_DimCurrencies.ExchangeDate	MRR_Currencies.ExchangeDate	Currencies.ExchangeDate
DimCurrencies.Code	STG_DimCurrencies.Code	MRR_Currencies.ShortName	Currencies.ShortName
			
FactSales.Discount	STG_FactSales.Discount	MRR_InvoiceItems.Discount	InvoiceItems.Discount
		MRR_InvoiceItems.ID	InvoiceItems.ID
		MRR_InvoiceItems.InvoiceID	InvoiceItems.InvoiceID
FactSales.Price	STG_FactSales.Price	From MRR_Product.Price	
FactSales.Product	STG_FactSales.ProductID	MRR_InvoiceItems.Product	InvoiceItems.Product
			
FactSales.Agent	STG_FactSales.AgentID	MRR_Invoices.Agent	Invoices.Agent
STG_FactSales.Client	STG_FactSales.ClientID	MRR_Invoices.Client	Invoices.Client
STG_FactSales.Currency	STG_FactSales.CurrencyID	MRR_Invoices.Currency	Invoices.Currency
		MRR_Invoices.ID	Invoices.ID
FactSales.InvoiceDate	STG_FactSales.Date	MRR_Invoices.Date	Invoices.Date
FactSales.VAT	STG_FactSales.VAT	MRR_Invoices.VAT	Invoices.VAT
			
DimProducts.Category	STG_DimProducts.Category	MRR_Products.Category	Products.Category
DimProducts.ID	STG_DimProducts.ID	MRR_Products.ID	Products.ID
	Joined with FactSales	MRR_Products.Price	Products.Price
DimProducts.PriceUpdate	STG_DimProducts.PriceUpdate	MRR_Products.PriceUpdate	Products.PriceUpdate
DimProducts.ProductName	STG_DimProducts.ProductName	MRR_Products.ProductName	Products.ProductName
DimProducts.ProductStatus	STG_DimProducts.ProductStatus	MRR_Products.ProductStatus	Products.ProductStatus
			
		MRR_Regions.RegionID	Regions.RegionID
	Joined with Countries	MRR_Regions.RegionName	Regions.RegionName

ERD DWH
 
 
1.	Overview
Overview dashboard provides summary of sales in 2021
-	KPIs achieved: annual total sales, annual after-tax revenue, total number of orders and number of unique clients
-	Area chart of average daily revenues throughout the year
-	Stacked column chart of monthly total revenues
-	Funnel chart of average revenues by types of sports
-	Donut chart represents sum of revenues by type of sports
-	The filter allows to filter across geographical regions
 
2.	Analysis by Product
The dashboard presents a drill-in through the product
-	Funnel chart shows 9 most popular products by number of orders that included this product
-	Ribbon chart shows sum of quantity by month
-	Table shows total sales average sales per product, sum of tax paid per product, sum of discount cost per product
-	Filter is enabled for region and category type
 
3.	Analysis by Category
Dashboard shows a drill-in to a category-specific analysis
-	Measures: revenue for the most popular category, average discount cost per category, average tax paid per category
-	Clustered bar chart: sum of revenue by categories (top-6 are shown)
-	Clustered column chart: Average revenue by category (mountain skiing is the most revenue driving category)
-	Treemap: shows the most sold categories by sum of quantity sold
-	Filter: the data can be filtered by type of category and geographic regions
 
4.	Geographical Analysis
Dashboard presents the results of the analysis by country, filter allows to filter by region
-	Funnel Chart shows 5 countries with the highest average revenue
-	Donut chart shows after tax revenue for each geographic region
-	Filled map: shows the sales by country (intensity of colors represents higher total sales)
 
5.	Geographical Analysis (Zoom-In)
The map shows sales by country: yellow – the lowest revenue, green – the highest revenue
 
6.	Agent Analysis
The dashboard shows drill-in by agents.
-	Measures: number of unique agents, average revenue per agent, average fee per agent, maximum revenue per agent
-	Stacked column chart: sum of fee by agent, colors represent after-tax revenue (yellow – the lowest revenue, green – the highest revenue)
-	Scatter fee of orders vs fee, higher fee is associated with larger number of total orders, colors represent larger average discount cost: yellow – the lowest cost, green – the largest cost
 
7.	Customer Analysis
The dashboard shows a drill-in by customers (clients)
-	Measures: number of unique clients, average number of orders per customer, average sales per customer, average discount per customer
-	Funnel chart: customers who spent more than EUR 10K in 2021: colors represent larger average discount cost: yellow – the lowest cost, red – the largest cost
-	Map shows location of each client
 

DAX Derived Columns:
Revenue = FactSales[Quantity]*FactSales[Price]*
(1-FactSales[Discount])*RELATED(DimCurrencies[ExchangeRate])
After Tax Revenue = FactSales[Revenue]*(1-FactSales[VAT])
Tax Paid = Revenue- After Tax Revenue
Discount Cost = FactSales[Quantity]*FactSales[Price]*
FactSales[Discount]*RELATED(DimCurrencies[ExchangeRate])
DAX Measures:
After Tax Revenue = SUM(FactSales[AfterTax Revenue])
Total Orders = DISTINCTCOUNT(FactSales[InvoiceID])
Total Sales = SUM(FactSales[Revenue])
Unique Clients = DISTINCTCOUNT(FactSales[Client])
Average Fee per Agent = AVERAGEX(KEEPFILTERS(VALUES('DimAgents'[AgentID])),CALCULATE(SUM('DimAgents'[Fee])))
Average of Revenue average per Agent = 
AVERAGEX(KEEPFILTERS(VALUES('FactSales'[Agent])),CALCULATE(AVERAGE('FactSales'[Revenue])))
Average Revenue per Agent = 
AVERAGEX(KEEPFILTERS(VALUES('FactSales'[Agent])),CALCULATE(SUM('FactSales'[Revenue])))
Avg Discount Cost per Category = 
AVERAGEX(KEEPFILTERS(VALUES('DimCategories'[CategoryName])),CALCULATE(SUM('FactSales'[Discount Cost])))
Avg Tax Paid per Category = 
AVERAGEX(KEEPFILTERS(VALUES('FactSales'[Tax Paid])),
CALCULATE(COUNTA('DimCategories'[CategoryName])))
Max Revenue per Agent = 
MAXX(KEEPFILTERS(VALUES('DimAgents'[AgentID])),CALCULATE(SUM('FactSales'[Revenue])))
Number of Customers = DISTINCTCOUNT(FactSales[Client])
Number of Unique Agents = DISTINCTCOUNT(FactSales[Agent])
Number Products Per Country = CALCULATE(COUNTA('DimProducts'[ProductName]),ALL('DimCountries'[CountryName]))
Orders per Customer = 
AVERAGEX(KEEPFILTERS(VALUES('DimClients'[ClientID])),
CALCULATE(DISTINCTCOUNT('FactSales'[InvoiceID])))
Revenue in Most Popular Category = 
MAXX(KEEPFILTERS(VALUES('DimCategories'[CategoryName])),CALCULATE(SUM('FactSales'[Revenue])))
Sum of Discount Cost average per ID = 
AVERAGEX(KEEPFILTERS(VALUES('DimProducts'[ID])),CALCULATE(SUM('FactSales'[Discount Cost])))
Sum of Tax Paid average per ID = 
AVERAGEX(KEEPFILTERS(VALUES('DimProducts'[ID])),CALCULATE(SUM('FactSales'[Tax Paid])))
Total Sales average per ID = 
AVERAGEX(KEEPFILTERS(VALUES('DimProducts'[ID])), CALCULATE([Total Sales]))
Average Discount per Customer = 
AVERAGEX(KEEPFILTERS(VALUES('DimClients'[ClientID])),
CALCULATE(SUM('FactSales'[Discount Cost])))
Sales per Customer = 
AVERAGEX(KEEPFILTERS(VALUES('DimClients'[ClientID])),CALCULATE([Total Sales]))

