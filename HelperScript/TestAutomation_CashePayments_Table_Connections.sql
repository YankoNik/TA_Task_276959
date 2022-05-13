/*********************************************************************************/
/* 1. ������ �/� �������� � TA ���������: */
--������ �������--
select 'PREV_COMMON_TA' AS TABLE_NAME 
	,	'������ �������' AS TABLE_DESCRIPTION
	,	* 
from PREV_COMMON_TA
where ROW_ID = '400003'
go

--������--
select 'RAZPREG_TA' AS TABLE_NAME 
	,	'������' AS TABLE_DESCRIPTION
	,	*
from RAZPREG_TA
where ROW_ID = '200010'
go


--�������
select 'DT015_CUSTOMERS_ACTIONS_TA' AS TABLE_NAME 
	,	'�������' AS TABLE_DESCRIPTION
	,	*
from DT015_CUSTOMERS_ACTIONS_TA
where ROW_ID = '100025'
go

----��� �� �������� �����������:
--select 'PROXY_SPEC_TA' AS TABLE_NAME 
--	,	'��� �� �������� �����������' AS TABLE_DESCRIPTION
--	,	[PROXY_CLIENT_ID]
--from [PROXY_SPEC_TA]
--where REF_ID = '100025'
--go

--��� � ������������ �����������:
select 'PROXY_SPEC_TA' AS TABLE_NAME 
	,	'��� � ������������ �����������' AS TABLE_DESCRIPTION
	,	[PROXY_CLIENT_ID] 
	,	*
from PROXY_SPEC_TA
where REF_ID = '100025'
go

-- ����� �� ������������ 
select 'DT015_CUSTOMERS_ACTIONS_TA' AS TABLE_NAME 
	,	'����� �� ������������' AS TABLE_DESCRIPTION
	,	*
from DT015_CUSTOMERS_ACTIONS_TA
where REF_ID = '100400'
go

/*********************************************************************************/
-- 2. ������������ �� ������� 
--K��� ������ �� �� ������������ ������� �� ������������
select * 
from DT015_CUSTOMERS_ACTIONS_TA
where ROW_ID = '100400'
go

--��� � ������ ����� Prev_common_ta � DT015_CUSTOMERS_ACTIONS_TA, ����� �������� �� �� ����� � ��� ��� �� ������ � �����, ������ ������� � �����������.
select PROXY_ROW_ID 
from PREV_COMMON_TA
where ROW_ID = '400003'
go

--���� ��� �� ����� �� ���:
--�����������--
select * 
from DT015_CUSTOMERS_ACTIONS_TA
where ROW_ID in
(select PROXY_ROW_ID from PREV_COMMON_TA
where ROW_ID = '400003')
go

--�������--
select * from DT015_CUSTOMERS_ACTIONS_TA
where ROW_ID in
(
	select REF_ID from RAZPREG_TA where ROW_ID in
	( select REF_ID from PREV_COMMON_TA where ROW_ID = '400003') )
go