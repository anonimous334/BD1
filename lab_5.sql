
-- allias de coloana
select deptno from dept;

select deptno departamentul, dname denumirea, loc from dept;


-- IS NULL si NOT NULL 
SELECT ENAME, EMPNO, SAL, COMM
FROM EMP
WHERE
SAL > &&SALARIU
AND
(COMM IS NOT NULL AND COMM >0);

-- NVL: NVL(a, b)=
--                 a, daca a is not null
--                 b, daca a is null
SELECT ENAME, EMPNO, SAL, COMM
FROM EMP
WHERE
SAL > &SALARIU
AND
nvl(comm, 0)>0;

-- VENITUL ANGAJATULUI = SALARIU + NVL(COMISION) : VENIT= SAL + NVL(COMM, 0)


-- JOIN explicit vs PRODUS CARTEZIAN: Toti salariatii din ACCOUNTING fara comision.


select emp.ename, emp.sal, emp.comm, dept.dname
from emp, dept
where
dept.dname='ACCOUNTING'
and
NVL(COMM, 0)=0;

-- PRODUS CARTEZIAN - LIPSESTE CONDITIA DE JOIN
select emp.ename Numele, emp.sal + nvl(comm, 0) Venit, dept.dname Departament
from emp, dept
where
dept.dname='ACCOUNTING'
and
NVL(COMM, 0)=0;


-- JOIN EXPLICIT
select emp.ename Numele, emp.sal + nvl(comm, 0) Venit, dept.dname Departament
from emp, dept
where
EMP.DEPTNO=DEPT.DEPTNO
AND
dept.dname='ACCOUNTING'
and
NVL(COMM, 0)=0;

-- join on
select emp.ename Nume, emp.sal + nvl(emp.comm, 0) Venit, dept.dname Departament
from emp JOIN dept ON EMP.DEPTNO=DEPT.DEPTNO
where
dept.dname='ACCOUNTING'
and
NVL(COMM, 0)=0;


-- JOIN natural
select emp.ename Nume, emp.sal + nvl(emp.comm, 0) Venit, dept.dname Departament
from emp NATURAL JOIN dept
where
dept.dname='ACCOUNTING'
and
NVL(COMM, 0)=0;

SELECT ENAME, DNAME FROM EMP NATURAL JOIN DEPT;

-- join intre o tabela si ea insasi. Comparatie intre venitul unui angajat si cel al sefului sau
SELECT A.ENAME, S.ENAME, A.SAL+ NVL(A.COMM, 0) VENIT_ANGAJAT,  S.SAL+ NVL(S.COMM, 0) VENIT_SEF
FROM EMP A, EMP S
WHERE
A.MGR=S.EMPNO
AND
(A.SAL+ NVL(A.COMM, 0))> (S.SAL+ NVL(S.COMM, 0) );

SELECT A.ENAME, S.ENAME, A.SAL+ NVL(A.COMM, 0) VENIT_ANGAJAT,  S.SAL+ NVL(S.COMM, 0) VENIT_SEF
FROM EMP A JOIN EMP S ON A.MGR=S.EMPNO
WHERE
(A.SAL+ NVL(A.COMM, 0))> (S.SAL+ NVL(S.COMM, 0) );


--- Sa se selecteze toti angajatii care castiga (venit) mai mult decat o valoare citita de la tastatura si care sunt angajati inainte de sefii lor.

-- non EQUI JOIN Sa se selecteze, pentru fiecare angajat din departamentul SALES: numele, denumirea departamentului si gradul salarial
SELECT A.ENAME, B.DNAME, A.SAL, C.GRADE
FROM EMP A, DEPT B, SALGRADE C
WHERE
A.DEPTNO=B.DEPTNO
AND
A.SAL >=C.LOSAL
AND
A.SAL <=C.HISAL
AND
B.DNAME LIKE 'SALES'
ORDER BY 4;

SELECT A.ENAME, B.DNAME, A.SAL, C.GRADE
FROM EMP A JOIN DEPT B ON A.DEPTNO=B.DEPTNO JOIN SALGRADE C ON A.SAL BETWEEN C.LOSAL AND C.HISAL
WHERE
B.DNAME LIKE 'SALES'
ORDER BY 4;



-- UTILIZAND JOIN ON SAU USING: Selectati toti angajatii dintr-un departament cu den cititat de la tastatura, care au salariul in grad 3: 
-- numele, denumirea departamentului, sal, grad salarial

-- outer join
SELECT A.DNAME, A.DEPTNO, B.ENAME, B.JOB
FROM DEPT A, EMP B
WHERE
A.DEPTNO=B.DEPTNO(+)
ORDER BY A.DNAME;

SELECT A.DNAME, A.DEPTNO, B.ENAME, B.JOB
FROM DEPT A LEFT OUTER JOIN EMP B
ON
A.DEPTNO=B.DEPTNO
ORDER BY A.DNAME;










