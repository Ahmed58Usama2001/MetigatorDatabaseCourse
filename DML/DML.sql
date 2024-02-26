USE PMDB;
GO

INSERT INTO PM.Companies (CRNNO, CompanyName) VALUES (101, N'Company A');

INSERT INTO PM.Companies (CompanyName, CRNNO) VALUES (N'Company B', 102);

INSERT INTO PM.Companies  VALUES (103, N'Company C');

INSERT INTO PM.Companies  VALUES 
           (104, N'Company D'),
           (105, N'Company E'),
           (106, N'Company F'),
           (107, N'Company G');
GO


INSERT INTO PM.Managers (Id ,Email) VALUES (201, 'peter@fake.com');
INSERT INTO PM.Managers (Id ,Email) VALUES (202, 'mike@fake.com');
INSERT INTO PM.Managers (Id ,Email) VALUES (203, 'reem@fake.com');
INSERT INTO PM.Managers (Id ,Email) VALUES (204, 'salah@fake.com'); 

GO
INSERT INTO PM.Technologies(Id , Name) VALUES (301, 'SQL SERVER');
INSERT INTO PM.Technologies(Id , Name) VALUES (302, 'ASP NET CORE');
INSERT INTO PM.Technologies(Id , Name) VALUES (303, 'ANGULAR');
INSERT INTO PM.Technologies(Id , Name) VALUES (304, 'REACT');
INSERT INTO PM.Technologies(Id , Name) VALUES (305, 'WPF');
INSERT INTO PM.Technologies(Id , Name) VALUES (306, 'ANDROID');
INSERT INTO PM.Technologies(Id , Name) VALUES (307, 'ORACLE');
INSERT INTO PM.Technologies(Id , Name) VALUES (308, 'PHP'); 

GO

INSERT INTO PM.Projects ( PRJNO, Title, ManagerId, StartDate, InitialCost, Parked, CRNNO)
     VALUES ( 401, 'CMS', 201, '2022-01-01', 15000000, 0, 101),
            ( 402, 'ERP', 202, '2022-02-01', 20000000, 0, 102),
            ( 403, 'CMS', 203, '2022-03-01', 15000000, 0, 105),
            ( 404, 'Authenticator', 204, '2022-04-01', 150000, 0, 101),
            ( 405, 'CRM-DESKTOP', 203, '2022-05-01', 20000000, 0, 104),
            ( 406, 'ERP', 204, '2022-06-01', 20000000, 0, 105),
            ( 407, 'HUB', 204, '2022-06-01', 20000000, 1, 104);

GO

INSERT INTO PM.ProjectTechnologies (PRJNO, TechnologyId) VALUES 
        ( 401, 301), 
        ( 401, 302),
		( 401, 303),
		( 402, 301), 
        ( 402, 302),
		( 402, 304),
		( 403, 301), 
        ( 403, 302),
		( 403, 308),
		( 404, 306),
		( 405, 307),
		( 405, 305),
		( 406, 307),
		( 406, 308);
GO

-- SELECT

SELECT PRJNO, Title, ManagerId, StartDate, InitialCost, Parked, CRNNO
FROM PM.Projects;

SELECT *
FROM PM.Projects;

SELECT PRJNO, Title
FROM PM.Projects;

-- WHERE 
SELECT * FROM PM.Projects WHERE InitialCost >= 1000000;
SELECT * FROM PM.Projects WHERE NOT InitialCost >= 1000000;
SELECT * FROM PM.Projects WHERE InitialCost >= 1000000 AND StartDate >= '2022-03-01';
SELECT * FROM PM.Projects WHERE InitialCost >= 1000000 OR StartDate >= '2022-03-01';

-- LIKE (%, _)
 -- LIKE xx% starts with
 SELECT * FROM PM.Projects WHERE Title like 'C%'
  -- LIKE %xx ends with
 SELECT * FROM PM.Projects WHERE Title like '%P'
   -- LIKE %xx% contains 
 SELECT * FROM PM.Projects WHERE Title like '%DESK%'
   -- LIKE _R%
    SELECT * FROM PM.Projects WHERE Title like '_R_';
    SELECT * FROM PM.Projects WHERE InitialCost like '_5%';

-- TOP
   SELECT TOP 3 * From PM.Projects
   SELECT TOP 2 PERCENT *  From PM.Projects

-- ORDER BY
SELECT * FROM PM.Projects ORDER BY StartDate;
SELECT * FROM PM.Projects ORDER BY StartDate DESC;
SELECT * FROM PM.Projects ORDER BY InitialCost, StartDate DESC;


--Group by
select title,COUNT(*) from PM.Projects group by Title

--Interview Question
--Where is applied on a column (the table itself) - comes after from
--having is applied on the result of group by (aggregate function) - after group by

select ManagerId,COUNT(*)
from PM.Projects
where parked = 0
group by ManagerId
having count(*) >= 2


--distnct
select distinct Title from PM.Projects

--tables join
select (p.PRJNO) as N'رقم المشروع',
(p.Title) as N'عنوان المشروع',
(m.Email) as N'البريد الإلكتروني لمدير المشروع'
from PM.Projects as p inner join PM.Managers as m
on  p.ManagerId=m.Id

--select PRJNO 
--(PRJNO is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause)
--Title,Email
--from PM.Projects inner join PM.Managers
--on  PM.Projects.ManagerId=PM.Managers.Id
--group by Title


--Update
update pm.Projects
set StartDate='2022-7-10'
where PRJNO=407

--delete
delete from pm.Projects
where PRJNO= 407

delete from pm.Projects
where PRJNO= 406
--The DELETE statement conflicted with the REFERENCE constraint "FK__ProjectTe__PRJNO__412EB0B6". The conflict occurred in database "PMDB", table "PM.ProjectTechnologies", column 'PRJNO'.

--Interviews question
--drop =>remove the table from the database
--truncate=>delete the records but keeps the table

--subquery
update pm.Projects set InitialCost=InitialCost*05
where PRJNO in (select PRJNO from pm.ProjectTechnologies
where TechnologyId =(select id from pm.Technologies where name='Oracle'))