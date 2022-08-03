/*******************************************************************************************************************************/
-- ������ �� ������������ (���������) �� ���������� �/��� �� ����������� ����� �� �������������� ��������, ����� ������:
--	- ���� �� ������� - �� 19011111
--	- ������ �� ������� - �� ������ (12)
--	- ���� �� ������� - �� ������ �� 'MY MILANO', � �� ���������� �� 'MY HOMETOWN'
--	- TIN - ��������� ���� ������� '19011111' � ��������� � 0-�� ������ ��������� ��������� �� TIN-� � NM177
/*******************************************************************************************************************************/

/* 1. ������������ ������ �� ������� �� �������������� ��������� ����, �� ����� ������ � ���������� �� 19011111: */
update [CUST]
set [BIRTH_DATE] = 19011111
from dbo.[DT015_CUSTOMERS] [CUST] WITH(NOLOCK)
where [CUST].ECONOMIC_SECTOR in (9400, 9999)
	and [CUST].[IDENTIFIER_TYPE] in ( 1, 4, 5, 6 ) /*  1 - '���'; 4 - '���'; 5 - '������������ ���'; 6 - '������������ ��� (���) */
	and [CUST].[BIRTH_DATE] < 18010101
go

/* 2.1. ��������� �� ������� �� ������� �� �������������� ��������� ���� (������ � ����): */
update [NAP]
set	[BIRTH_CNTR] = 12
,	[BIRTH_TWN]  = 'MY MILANO'
from dbo.[DT015_CUSTOMERS] [CUST] WITH(NOLOCK)
INNER JOIN dbo.[DT015NAP] [NAP]
	on [NAP].[CUSTOMER_ID] = [CUST].[CUSTOMER_ID]
where [CUST].[ECONOMIC_SECTOR] in (9400, 9999)
	and [CUST].[IDENTIFIER_TYPE] in ( 1, 4, 5, 6 ) /* 1 - '���'; 4 - '���'; 5 - '������������ ���'; 6 - '������������ ��� (���) */
	and [BIRTH_CNTR] = 0 and [BIRTH_TWN] = ''
go

/* 2.2. ��������� �� ������� �� ������� �� �������������� ��������� ���� (����): */
update [NAP]
set	[BIRTH_TWN]  = 'MY HOMETOWN'
from dbo.[DT015_CUSTOMERS] [CUST] WITH(NOLOCK)
INNER JOIN dbo.[DT015NAP] [NAP]
	on [NAP].[CUSTOMER_ID] = [CUST].[CUSTOMER_ID]
where [CUST].[ECONOMIC_SECTOR] in (9400, 9999)
	and [CUST].[IDENTIFIER_TYPE] in ( 1, 4, 5, 6 ) /* 1 - '���'; 4 - '���'; 5 - '������������ ���'; 6 - '������������ ��� (���) */
	and [BIRTH_CNTR] > 0 and [BIRTH_TWN] = ''
go

/* 3. ��������� TIN �� �������������� ��������� ���� � ���������� �����: */
update [NAP]
set	[NO_TIN_AVAILABLE] = 2
,	[CODE_TIN] = [NEW_TIN].[TIN]
from dbo.[DT015_CUSTOMERS] [CUST] WITH(NOLOCK)
INNER JOIN dbo.[DT015NAP] [NAP]
	on [NAP].[CUSTOMER_ID] = [CUST].[CUSTOMER_ID]
inner join dbo.[nm177] [CNTR] WITH(NOLOCK)
	on [CNTR].[CODE] = [NAP].[RESIDENCE_CNTR]
cross apply (
	SELECT CASE WHEN [CNTR].[TIN_LENGTH_FL] < 8 THEN '1901111100'
				WHEN [CNTR].[TIN_LENGTH_FL] = 8 THEN '19011111'
				WHEN [CNTR].[TIN_LENGTH_FL] > 8 THEN '19011111' + REPLACE(STR(0,([CNTR].[TIN_LENGTH_FL]-8), 0), ' ','0')
				ELSE 'No TIN available'	END AS [TIN]
) [NEW_TIN]
where [CUST].[ECONOMIC_SECTOR] in (9400, 9999)
	and [CUST].[IDENTIFIER_TYPE] in (1, 4, 5, 6) /* 1 - '���'; 4 - '���'; 5 - '������������ ���'; 6 - '������������ ��� (���) */
	and [CNTR].[IS_TIN_SUPPORTED_FL] in ( 1 ) /* ���� �� �������� ���������� TIN �� ����������� ���� */
	and [NAP].[CODE_TIN] = '' 
go

/* 4.1. ��� �������� �� TIN �� ������� � ����� �� �������� �� ��������, � ���� �� �������� �� �������������� �� � ��������, �� �� �������� � ���� �� TIN-a */
UPDATE [CUST]
SET [CORRESPONDENCE_ADDRESS_COUNTRY] = [NAP].[RESIDENCE_CNTR]
from dbo.[DT015_CUSTOMERS] [CUST] WITH(NOLOCK)
INNER JOIN dbo.[DT015NAP] [NAP]
	on [NAP].[CUSTOMER_ID] = [CUST].[CUSTOMER_ID]
inner join dbo.[nm177] [CNTR] WITH(NOLOCK)
	on [CNTR].[CODE] = [NAP].[RESIDENCE_CNTR]
where [CUST].[ECONOMIC_SECTOR] in (9400, 9999)
	and [CUST].[IDENTIFIER_TYPE] in (1, 4, 5, 6) /* 1 - '���'; 4 - '���'; 5 - '������������ ���'; 6 - '������������ ��� (���) */
	and [CNTR].[IS_TIN_SUPPORTED_FL] in ( 1 ) /* ���� �� �������� ���������� TIN �� ����������� ���� */
	and [NAP].[RESIDENCE_CNTR] > 0
	and [NAP].[RESIDENCE_CNTR] not in ([CUST].[CORRESPONDENCE_ADDRESS_COUNTRY], [CUST].[REGISTERED_ADDRESS_COUNTRY], [CUST].[CURRENT_ADDRESS_COUNTRY])
	and [CUST].[CORRESPONDENCE_ADDRESS_COUNTRY] <= 0
go

/* 4.2. ��� �������� �� TIN �� ������� � ����� �� �������� �� ��������, � ���� �� �������� �� ����������� �� � ��������, �� �� �������� � ���� �� TIN-a */
UPDATE [CUST]
SET [REGISTERED_ADDRESS_COUNTRY] = [NAP].[RESIDENCE_CNTR]
from dbo.[DT015_CUSTOMERS] [CUST] WITH(NOLOCK)
INNER JOIN dbo.[DT015NAP] [NAP]
	on [NAP].[CUSTOMER_ID] = [CUST].[CUSTOMER_ID]
inner join dbo.[nm177] [CNTR] WITH(NOLOCK)
	on [CNTR].[CODE] = [NAP].[RESIDENCE_CNTR]
where [CUST].[ECONOMIC_SECTOR] in (9400, 9999)
	and [CUST].[IDENTIFIER_TYPE] in (1, 4, 5, 6) /* 1 - '���'; 4 - '���'; 5 - '������������ ���'; 6 - '������������ ��� (���) */
	and [CNTR].[IS_TIN_SUPPORTED_FL] in ( 1 ) /* ���� �� �������� ���������� TIN �� ����������� ���� */
	and [NAP].[RESIDENCE_CNTR] > 0
	and [NAP].[RESIDENCE_CNTR] not in ([CUST].[CORRESPONDENCE_ADDRESS_COUNTRY], [CUST].[REGISTERED_ADDRESS_COUNTRY], [CUST].[CURRENT_ADDRESS_COUNTRY])
	and [CUST].[REGISTERED_ADDRESS_COUNTRY] <= 0
go

/* 4.3. ��� �������� �� TIN �� ������� � ����� �� �������� �� ��������, � ���� �� �������� �� ����� ����� �� � ��������, �� �� �������� � ���� �� TIN-a */
UPDATE [CUST]
SET [CURRENT_ADDRESS_COUNTRY] = [NAP].[RESIDENCE_CNTR]
from dbo.[DT015_CUSTOMERS] [CUST] WITH(NOLOCK)
INNER JOIN dbo.[DT015NAP] [NAP]
	on [NAP].[CUSTOMER_ID] = [CUST].[CUSTOMER_ID]
inner join dbo.[nm177] [CNTR] WITH(NOLOCK)
	on [CNTR].[CODE] = [NAP].[RESIDENCE_CNTR]
where [CUST].[ECONOMIC_SECTOR] in (9400, 9999)
	and [CUST].[IDENTIFIER_TYPE] in (1, 4, 5, 6) /* 1 - '���'; 4 - '���'; 5 - '������������ ���'; 6 - '������������ ��� (���) */
	and [CNTR].[IS_TIN_SUPPORTED_FL] in ( 1 ) /* ���� �� �������� ���������� TIN �� ����������� ���� */
	and [NAP].[RESIDENCE_CNTR] > 0
	and [NAP].[RESIDENCE_CNTR] not in ([CUST].[CORRESPONDENCE_ADDRESS_COUNTRY], [CUST].[REGISTERED_ADDRESS_COUNTRY], [CUST].[CURRENT_ADDRESS_COUNTRY])
	and [CUST].[CURRENT_ADDRESS_COUNTRY] <= 0
go

/* 4.4. ��� �������� �� TIN (��� ���) �� ������� � ����� �� �������� �� ��������, ���� �� �������� �� ����� ����� �� �� �������� � ���� �� TIN-a */
update  [CUST]
set [CORRESPONDENCE_ADDRESS_COUNTRY] = [NAP].[RESIDENCE_CNTR]
from dbo.[DT015_CUSTOMERS] [CUST] WITH(NOLOCK)
INNER JOIN dbo.[DT015NAP] [NAP]
	on [NAP].[CUSTOMER_ID] = [CUST].[CUSTOMER_ID]
inner join dbo.[nm177] [CNTR] WITH(NOLOCK)
	on [CNTR].[CODE] = [NAP].[RESIDENCE_CNTR]
where [CUST].[ECONOMIC_SECTOR] in (9400, 9999)
	and [CUST].[IDENTIFIER_TYPE] in (1, 4, 5, 6) /* 1 - '���'; 4 - '���'; 5 - '������������ ���'; 6 - '������������ ��� (���) */
	and [CNTR].[IS_TIN_SUPPORTED_FL] in ( 1 ) /* ���� �� �������� ���������� TIN �� ����������� ���� */
	and [NAP].[RESIDENCE_CNTR] not in ([CUST].[CORRESPONDENCE_ADDRESS_COUNTRY], [CUST].[REGISTERED_ADDRESS_COUNTRY], [CUST].[CURRENT_ADDRESS_COUNTRY])
go