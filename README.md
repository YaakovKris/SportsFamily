## SportsFamily
### Company Description:
 SportsFamily is an international chain of online store of sportswear and equipment for an active lifestyle. The company mainly operates in Europe (EU and Great Britain), both its clients and agents locate in Europe. SportsFamily exports products from the US market as well, therefore, transactions are performed in 3 currencies: EUR, GBP and USD.
SportsFamily sells sportswear and sports equipment, both for outdoor and indoor activities, including winter, summer, and water sports. The company works with wholesale customers only who further realize their products throughout Europe, therefore, each client belongs to a company. To manage business process, find new products and clients, SportsFamily uses the outsource agencies.
SportsFamily rapidly expanded in 2021, however due to specific demand for sportswear and sports equipment the company's revenues exhibit seasonality.
System Description:
The system implements a BI solution for the company which includes gathering the data, processing the data from the operational database to data warehouse, and analyzing it efficiently to achieve business goals. The analysis includes general overview, and drill in products, categories, agents, and clients as well as geographic analysis.
### Goals of the System:
The system allows to implement efficient business solutions, analyze the large scale data and improve the processes to achieve strategic goals.
### System Tools:
BI solution allows efficient storage of the data in the data warehouse. SportsFamily uses a Priority ERP system for its daily transactions. The solution presents transformation of the data from the ERP to the DWH.
### DWH Tables:
•	DimAgents: the table includes all the relevant information about the agents who work with the company <br />
•	DimCategories: the table consists of the data on categories of the products including general type, and a more specific category<br />
•	DimClients: the table includes the data on customers of the shop who belong to the companies they work for (the shop does not work with end users, rather with official resellers)<br />
•	DimCompanies: the table consists of the data on companies that resell the products, each client belongs to a company<br />
•	DimCountries: the table consists of the list of countries in which the operations of the company take place as well as a more general region within Europe to which the country belongs<br />
•	DimCurrencies: the table includes the data on the currencies in which the operation took place, the exchange rate, and the date for the last update of the exchange rate<br />
•	DimProducts: the table consists of all the data about the product except for its price (for the purposes of the analysis the price is stored in the FactSales table)<br />
•	FactSales: the table shows all the sales including details of each transaction<br />
### Technologies Used:
The operational database and DWH are based on the ERP Priority realized using SQL Management Studio (SQL Server).
For the ETL process the SSIS is used: the data from the sources is transferred to MRR tables using incremental load, then, the data transferred to STG. Finally, the data is transformed and transferred to the DWH. To perform the incremental load the CDC is used. The SSIS solution consists of 4 packages: OneTime, Extract, Transform, Load:<br />
•	OneTime: the package is implemented only once at the beginning of the project: all the data from the ERP Priority is transferred to the DWH<br />
•	Extract: the package is used to extract the new data from the operational DB to the MRR tables. <br />
•	Transform: the package is used to transform and load the new data from the MRR tables to STG tables<br />
•	Load: the data is uploaded to the DWH<br />
### Data Sources:
All the data is stored in the operational database, no outer sources are used.
### ETL Process:
The ETL process allows efficient transfer of the data from operational DB to DWH and its transformation from OLTP to OLAP needs. The ETL process is based on incremental load which is performed on daily basis. At the beginning of the project all relevant data (for the past 3 years) is transferred to the DWH. For the operational DB and each source table in the DB CDC is enabled. The process consists of 3 ETL stages: extract (Source to MRR), load (MRR to STG), and transform (STG to DWH):<br />
•	Extract: to extract data from Source to MRR CDC is used. First, CDC allows to mark the last update datetime, and implement incremental load, i.e., to modify (insert/update/delete) only those records that were affected in that period time. The CDC splitter is used to distinguish between inserted, updated, and deleted records, and then this data is uploaded to MRR tables.<br />
•	Transform: at this stage data is transferred from MRR to STG. At this stage inserted and updated records are added while deleted and updated records are deleted from the DWH. Tables Categories and CategoryType are merged in one table STG_DimCategories. Tables Countries, CountryRegion, and Regions are merged in a table STG_DimCountries. Tables Invoices and InvoiceItems are joined in table FactSales. In addition, product price from table Products is merged with table FactSales and deleted from table Products.<br />
•	Load: the data is transformed (mostly Unicode to non-Unicode data conversion) and uploaded to the DWH (DimTables and FactSales).<br />
