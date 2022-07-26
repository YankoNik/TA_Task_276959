--use BPB_TA_REGRESSION_NEXT
go

-- proc for dropping
drop proc IF EXISTS SP_GET_DATASOURCE
drop proc IF EXISTS SP_LOAD_ONLINE_CLIENT_DATA
drop proc IF EXISTS SP_LOAD_ONLINE_DEAL_CORS_DATA
drop proc IF EXISTS SP_LOAD_ONLINE_DEAL_DATA
drop table IF EXISTS AGR_CASH_PAYMENTS_SQL_CONDITIONS
go
drop proc IF EXISTS SP_CASH_PAYMENTS_CLEAR_TA_TABLES
drop proc IF EXISTS SP_CASH_PAYMENTS_GET_DATASOURCE
drop proc IF EXISTS SP_CASH_PAYMENTS_INIT_DEALS
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_CLIENT_DATA
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_DEALS_CORS_TA
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_DT015_CUSTOMERS_ACTIONS_TA
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_RAZREG_TA
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_TA_TABLES
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_TA_TABLES_PREPARE_CONDITIONS
GO
drop proc IF EXISTS SP_CASH_PAYMENTS_FIND_SUITABLE_DEAL
drop proc IF EXISTS SP_CASH_PAYMENTS_PREPARE_CONDITIONS_TABLE
drop proc IF EXISTS SP_CASH_PAYMENTS_PREPARE_DEALS
drop proc IF EXISTS SP_CASH_PAYMENTS_PREPARE_DEALS_BETA
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_TA_FIND_ACCOUNT
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_ACCOUNTS_DAY_OPERATION_BAL
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_ACCOUNT_DAY_OPERATION_BALANCE
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_TAX_INFO
drop proc IF EXISTS SP_CASH_PAYMENTS_UPDATE_TAXED_INFO
drop proc IF EXISTS SP_CASH_PAYMENTS_INIT_TAXES
drop proc IF EXISTS SP_CASH_PAYMENTS_PREPARE_DEALS_AIR
go

-- view for dropping
drop view if exists dbo.VIEW_CASH_PAYMENTS_CONDITIONS
drop view if exists VIEW_CASH_PAYMENT_TEST_CASE_DATA
go

-- table for dropping
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS_ARE_PROXIES
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS_DUBL_EGFN
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS_WITH_DUBL_EGFN
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS_WITH_LOANS
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS_WITH_MANY_CLIENT_CODES
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS_WITH_VALID_IDENTITY_DOCUMENTS
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS_ACTIVE_PROXY_CUSTOMERS
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS_LEGAL_REPRESENTATIVE
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS_WITH_DISTRAINT
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS_WITH_DORMUNT_ACCOUNT
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS_WITH_GS_INDIVIDUAL_PROGRAMME
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS_WITH_OTHER_TAX_ACCOUNT
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS_WITH_TAX_UNCOLECTED
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS_WITH_WNOS_BEL
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS
drop table IF EXISTS AGR_CASH_PAYMENTS_PROXY_ACCOUNT_ACCESS
drop table IF EXISTS AGR_CASH_PAYMENTS_PROXY_CUSTOMERS
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS_WITH_DISTRAINT
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS_WITH_UNCOLLECTED_TAX_CONNECTED_TO_ALL_ACCOUNTS
drop table IF EXISTS AGR_CASH_PAYMENTS_CUSTOMERS_COUNT_DEAL_BY_CURRENCY
drop table IF EXISTS AGR_CASH_PAYMENTS_DEALS_WITH_NAR_RAZP
GO

select 'drop proc IF EXISTS ' + name
from sys.procedures where name like 'sp_cash_p%'
go

select 'drop table IF EXISTS ' + name
from sys.tables where name like 'agr_cash_p%'
go

select 'drop view IF EXISTS ' + name
from sys.views where name like 'VIEW_CASH_PAYMENT%'
go

--select * from dbo.SYS_LOG_PROC
--order by id
--go

--exec sp_db_snapshot_create 'BPB_TA_REGRESSION_NEXT'
--go

--exec sp_db_snapshot_restore 'BPB_TA_NEXT_SS@2022.05.12_v2'
--go

