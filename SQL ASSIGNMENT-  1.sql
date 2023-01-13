---creating a database
-- CREATE DATABASE ORGANIZATION
-- USE ORGANIZATION

--(a)Creating an employee table
CREATE TABLE EMPLOYEE( EMPNO INT ,EMPNAME VARCHAR (20),Job VARCHAR(20), MGR INT,HireDate date,Salary INT,Comm INT,Deptno INT);

--(b)Creating an department table
CREATE TABLE Department
(
Dept_no INT,
Dname VARCHAR(20),
Loc VARCHAR (20)
);


---iii)
INSERT INTO EMPLOYEE(
EMPNO,
EMPNAME,
JOB,
MGR,
HIREDATE,
SALARY,
COMM,
DEPTNO)
VALUES(325,'Smith','Clerk',433,'11-jan-95',500,1400,20),(825,'James','Clerk',466,'02-aug-81',2975,NULL,20),
(433,   'James',   'Analyst',825,      '03-DEc-89', 3500,    NULL, 40),
(466,   'Mike',   'President',  NULL,   '18-Nov-97',    7000,NULL,30),
(889,   'Adams',  'Manager',   433,      '23-May-87',   3250,   0, 10),
(435,    'Blake',    'Analyst', 889,     '03-dec-89',   4500,0,40);


 


 ---(iv)
 INSERT INTO Department(Dept_No,Dname,Loc)VALUES(10, 'Accounting',   'Chicago'),
 (10, 'Accounting',   'Chicago'),
 (20, 'Research',   'Dallas'),
 (30, 'Sales',   'NewYork'),
 (40, 'Operations',   'Boston'),
 (50, 'Purchase',   'Los Angeles');

 --(b)
 --(i)
 SELECT * FROM Employee;

 --(ii)
 SELECT * FROM Department;

 ---(iii)
 SELECT EMPNO,EMPNAME,Job FROM EMPLOYEE;

 ---(iv)
SELECT Dept_NO,Dname FROM Department;

---(v)
SELECT DISTINCT (Job) FROM EMPLOYEE;



---Question -2
---(i)
SELECT EMPNAME FROM EMPLOYEE WHERE Job LIKE 'Analyst' AND SALARY >2000;

---(ii)
SELECT  EMPNO,EMPNAME FROM EMPLOYEE  WHERE Comm  IS NULL or Comm = 0;


---(iii)
SELECT  EMPNAME FROM EMPLOYEE WHERE (Job LIKE 'Clerk' OR Job LIKE 'Analyst');

---(iv)
SELECT EMPNAME FROM EMPLOYEE WHERE (Deptno = 10 OR Deptno = 20 OR Deptno = 40) OR (Job LIKE 'Clerk' OR Job LIKE 'Analyst');

---(v)
SELECT e.EMPNAME,e.Deptno,d.Dname FROM EMPLOYEE e INNER JOIN Department d ON e.Deptno = d.Dept_no WHERE d.Dname LIKE 'Research'

---(vi)
SELECT EMPNAME FROM EMPLOYEE WHERE EMPNAME LIKE 'b%e';

---(vii)
SELECT JOB  FROM EMPLOYEE WHERE Deptno = 20 AND Job IN(SELECT Job FROM EMPLOYEE WHERE Deptno = 10) ;

---(viii)
SELECT DISTINCT(Job) FROM EMPLOYEE WHERE Deptno=10;

---(ix)
SELECT EMPNAME FROM EMPLOYEE WHERE (SALARY + 0.2*SALARY)>3000;

---(X)
SELECT *  FROM EMPLOYEE WHERE Mgr is NULL;


---Question - 3
---(a)
---(i)
SELECT COUNT (*) FROM EMPLOYEE

---(ii)
SELECT COUNT (*) FROM EMPLOYEE e INNER JOIN Department d ON e.Deptno = d.Dept_no WHERE d.Dname LIKE 'Accounting'


---(iii)
SELECT SUM(SALARY) FROM EMPLOYEE;
---(iv)
select Deptno,avg(SALARY),min(SALARY),max(SALARY)  from EMPLOYEE  where Deptno in (select Deptno from (select Deptno,count(*) as cnt from EMPLOYEE group by Deptno) as tbl where tbl.cnt>2 ) GROUP BY Deptno;

---(b)
 SELECT GETDATE();
 
---(c)
 SELECT EMPNAME,12 *(Salary )AS "Annual Salary"FROM EMPLOYEE ;

---Question-4

---(a)
---(i)
SELECT Job,COUNT(Job) FROM EMPLOYEE GROUP BY Job;

---(ii)
SELECT tbl.Job,tbl.sum_SALARY from (select Job,sum(SALARY) sum_SALARY from EMPLOYEE group by Job) as tbl where tbl.sum_SALARY>5000 ;

---(iii)
SELECT EMPNO,EMPNAME,DEPTNO,SALARY FROM EMPLOYEE ORDER BY EMPNAME,DEPTNO,SALARY;

---(iv)
SELECT EMPNAME ,12*(SALARY) AS "Annual Salary" FROM EMPLOYEE(SELECT  MAX(SALARY);	


----(b)
---(i)
SELECT  EMPNAME FROM  EMPLOYEE where SALARY = (SELECT MAX(SALARY) from EMPLOYEE);

---(ii)
SELECT EMPNAME  FROM EMPLOYEE WHERE Salary> (SELECT avg(salary) FROM EMPLOYEE);

---(iii)
SELECT  *  FROM EMPLOYEE WHERE Salary > (
SELECT min(salary) from employee where Deptno=30) and Deptno!= 30;

---(iv)
SELECT EMPNAME from EMPLOYEE where salary>(select max(e.salary) from EMPLOYEE e inner join department d on d.Deptno= e.Deptno where d.dname like 'Sales');

---(v)
SELECT * from EMPLOYEE where mgr in (select EMPNO from employee where EMPNAME like '%James%');

---(vi)
SELECT * from EMPLOYEE where (salary >= (select avg(salary) from EMPLOYEE)) and Job like 'Manager';



--Question -5	
---(a)
---(i)
select e.EMPNO,e.EMPNAME ,e.Deptno,d.Dname  from EMPLOYEE e left join Department d on e.Deptno =d.Deptno;
													 
--(ii)
SELECT e1.EMPNAME,e2.EMPNAME AS Manager FROM EMPLOYEE e1 LEFT JOIN EMPLOYEE e2 ON e1.MGR=e2.EMPNO;

---(iii)
SELECT * FROM EMPLOYEE e1 LEFT JOIN EMPLOYEE e2 ON e1.MGR = e2.EMPNO WHERE e1.DEPTNO = e2.DEPTNO;
---(iv)
---LEFT JOIN
 SELECT * FROM EMPLOYEE e LEFT OUTER JOIN DEPARTMENT d ON e.DEPTNO = D.DEPTNO;

 ---RIGHT JOIN
 SELECT * FROM EMPLOYEE e RIGHT OUTER JOIN Department d ON  e.DEPTNO =  d.DEPTNO;
 ---FULL OUTER JOIN

 SELECT * FROM EMPLOYEE e FULL OUTER JOIN Department d ON e.DEPTNO = d.DEPTNO;



 ---(b)
---(i)
 CREATE TABLE Cust_dtls(
Cust_no INT NOT NULL UNIQUE ,
Cust_name  varchar(25) CHECK (UPPER(Cust_name)=Cust_name),
Cust_city varchar(30) CHECK(Cust_city LIKE 'H%')
);
 
															 
---(ii)	
---(a)														 
alter table EMPLOYEE ADD PRIMARY key(EMPNO);

---(b)
ALTER TABLE EMPLOYEE
ALTER COLUMN EMPNAME
SET NOT NULL;

---(C)
ALTER TABLE EMPLOYEE
ALTER COLUMN Comm
SET DEFAULT 0;

---(d)
ALTER TABLE Department
ADD CONSTRAINT unique_DEPTNO UNIQUE (DEPTNO);

ALTER TABLE EMPLOYEE ADD FOREIGN KEY (DEPTNO) REFRENCES Department(DEPTNO);

--(e)
ALTER TABLE EMPLOYEE 
ADD FOREIGN KEY(MGR) REFERENCES EMPLOYEE(EMPNO);

---(iii)


---(iv)
alter table Department add constraint Unique_loc unique(Loc);															 
								
---(v)
alter table cust_dlts drop constraint cust_dlts_cust_name_check;															 
-------------------------------------------------------------------------------															 
---Question 6
---(a)
---(i)
alter table Department add COLUMN int DEFAULT(10);

---(ii)
alter table Department alter column budget int DEFAULT 10;

															 
---(iii)															 
drop table employee;
															 
---(b)
---(i)
alter table Department RENAME to dept_details;
															 
---(ii)															 
delete from dept_details where loc like 'NewYork';															 
															 
---(iii)															 
delete from Employee where salary <(select avg(salary)from employee);															 
														 
---(iv)
update  dept_details set  Dname = 'Distibution'	,DeptNo = 70, where Dname like 'Sales';													 
															 