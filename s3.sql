DROP VIEW IF EXISTS date_pos;
DROP VIEW IF EXISTS date;
DROP VIEW IF EXISTS pos;
DROP VIEW IF EXISTS sum;


CREATE VIEW date 
AS 
	SELECT DISTINCT TOP(10000) APPLICATION_DT AS Date 
	FROM data
	ORDER BY APPLICATION_DT;

CREATE VIEW pos 
AS 
	SELECT DISTINCT TOP(10000) INTERNAL_ORG_ORIGINAL_RK AS Pos 
	FROM data 
	ORDER BY INTERNAL_ORG_ORIGINAL_RK;

CREATE VIEW date_pos 
AS 
	SELECT * 
	FROM date, pos;

CREATE VIEW sum 
AS 
	SELECT APPLICATION_DT AS Date, INTERNAL_ORG_ORIGINAL_RK AS Pos, sum(LOAN_AMOUNT) AS Сумма_выдач
	FROM data GROUP BY APPLICATION_DT, INTERNAL_ORG_ORIGINAL_RK;


SELECT date_pos.Date, date_pos.Pos, coalesce(Сумма_выдач,0) 
FROM date_pos LEFT JOIN sum 
on date_pos.date=sum.Date AND date_pos.pos=sum.Pos;
