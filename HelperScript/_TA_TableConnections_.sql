--������ �������--
select 'PREV' AS [REG], * 
from PREV_COMMON_TA
where ROW_ID = '400003'--������--
go

select 'DEAL' AS [REG], * 
from RAZPREG_TA
	where ROW_ID = '200010'--�������
go

select 'CUST' AS [REG], * 
from DT015_CUSTOMERS_ACTIONS_TA
	where ROW_ID = '100025'
go

--��� �� �������� �����������:
select 'SPEC' AS [REG], * 
from PROXY_SPEC_TA
	where REF_ID = '100025'--��� � ������������ �����������:
go

--select PROXY_CLIENT_ID from PROXY_SPEC_TA
--	where REF_ID = '100025'--K��� ������ �� �� ������������ ������� �� ������������
--go

select 'PROXY' AS [REG], * 
from DT015_CUSTOMERS_ACTIONS_TA
	where ROW_ID = '100400'
go

--��� � ������ ����� Prev_common_ta � DT015_CUSTOMERS_ACTIONS_TA, ����� �������� �� �� ����� � ��� ��� �� ������ � �����, ������ ������� � �����������.
select PROXY_ROW_ID from PREV_COMMON_TA
	where ROW_ID = '400003'--���� ��� �� ����� �� ���:
go

--�����������--
select * from DT015_CUSTOMERS_ACTIONS_TA
where ROW_ID in
(select PROXY_ROW_ID from PREV_COMMON_TA

	where ROW_ID = '400003'
)
go

--�������--
select * from DT015_CUSTOMERS_ACTIONS_TA
where ROW_ID in (select REF_ID from RAZPREG_TA where ROW_ID in (select REF_ID from PREV_COMMON_TA where ROW_ID = '400003') )
go

/******************************************************************/
declare @TestCaseID int = '400002'
;
-- View ����� ������� ���� ������� ��������� �� ������������
select * from dbo.[VIEW_CASH_PAYMENT_TEST_CASE_DATA]
where [ROW_ID] = @TestCaseID
;

-- ������� �� ������ �����:
select * 
--������ �������--
from dbo.[PREV_COMMON_TA] [PREV] WITH(NOLOCK)
/* ������ */
INNER JOIN dbo.[RAZPREG_TA] [DEAL] WITH(NOLOCK)
	ON [PREV].[REF_ID] = [DEAL].[ROW_ID]
/* ������� */
INNER JOIN dbo.[DT015_CUSTOMERS_ACTIONS_TA] [CUST] WITH(NOLOCK)
	ON [CUST].[ROW_ID] = [DEAL].[REF_ID]
/* ������ ��� ����������� */
LEFT OUTER JOIN dbo.[PROXY_SPEC_TA] [PSPEC] WITH(NOLOCK)
	ON [PSPEC].[REF_ID] = [DEAL].[REF_ID]
/* ������ �� ����������� */
LEFT OUTER JOIN dbo.[DT015_CUSTOMERS_ACTIONS_TA] [PROXY] WITH(NOLOCK)
	ON [PROXY].[ROW_ID] = [PSPEC].[PROXY_CLIENT_ID]
where [PREV].[ROW_ID] = @TestCaseID 
go

