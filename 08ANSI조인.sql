SELECT * FROM INFO;
SELECT * FROM AUTH;

-- INNER JOIN, 붙을 수 없는 데이터는 나오지 않음
SELECT * 
FROM  INFO /*INNER JOIN 생략 가능*/ JOIN AUTH /*합치기 위해 가져올 테이블명*/
ON INFO.AUTH_ID/*테이블,PK컬럼명*/ = AUTH.AUTH_ID; /*테이블.PK컬럼명*/

SELECT INFO.ID,
            INFO.TITLE,
            INFO.CONTENT,
            INFO.AUTH_ID, -- AUTH_ID는 양쪽 테이블에 다 있는 KEY라서 테이블명.컬럼명으로 기입해야 함, 나머지도 그렇게 적어주면 좋음
            AUTH.NAME
FROM INFO
INNER JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;

-- 테이블 ALIAS (줄임 표기법)
SELECT I.ID,
             I.TITLE,
             A.AUTH_ID,
             A.NAME,
             A.JOB
FROM INFO I -- 알파벳으로 테이블의 별칭 지어줄 수 있음
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

-- 연결할 키가 같다면 USING구문을 사용할 수 있음
SELECT *
FROM INFO I
INNER JOIN AUTH A
USING (AUTH_ID);


--------------------------------


--OUTER JOIN
--LEFT OUTER JOIN (OUTER 생략 가능) - 왼쪽 테이블이 기준이 되므로 왼쪽 테이블은 다 나옴
SELECT * FROM INFO I LEFT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT OUTER JOIN - 오른쪽 테이블이 기준이 되므로 오른쪽 테이블은 다 나옴
SELECT * FROM INFO I RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT조인의 테이블 자리만 바꿔주면 LEFT JOIN
SELECT * FROM AUTH A RIGHT OUTER JOIN INFO I ON A.AUTH_ID = I.AUTH_ID;

--FULL OUTER JOIN - 양쪽 데이터 누락없이 다 나옴
SELECT * FROM INFO I FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--CROSS JOIN  잘못된 조인의 형태이며 실제로 쓸 일은 없음, JOIN 조건도 필요없음
SELECT * FROM  INFO I CROSS JOIN AUTH A;



-- SELF JOIN -하나의 테이블을 가지고 조인을 거는 것, 프로그램에 많이 사용 됨, 조건 테이블 안에 연결 가능한 키가 필요함
SELECT * 
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2
ON E.MANAGER_ID = E2.EMPLOYEE_ID;

----------------------------------------------

--오라클 조인 : 오라클에서만 사용할 수 있고 조인할 테이블을 FROM에 열거하여 씀, 조인 조건은 WHERE에 씀

-- 오라클의 INNER JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID;

--오라클의 LEFT JOIN - 붙일 테이블(오른쪽)에 (+)를 붙임
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID(+);

--오라클의 RIGHT JOIN - 붙일 테이블 (왼쪽)에 (+)를 붙임
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID (+) = A.AUTH_ID;

--오라클에서 FULL OUTER JOIN은 없음

-- 오라클에서 CROSS JOIN은 조인 조건을 적지 않았을 때 나타남
SELECT *
FROM INFO I, AUTH A;

----------------------------------------------

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT * FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
SELECT * FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; -- 데이터 하나 누락

-- 조인은 여러 번 할 수 있음
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME, L.CITY
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE EMPLOYEE_ID >= 150; -- WHERE 조건절도 붙일 수 있음

-- N테이블 쪽(FK 들고 있는 쪽)에 1테이블(PK 들고 있는 쪽) 붙이는 경우가 가장 많음
-- 아래는 1에 N테이블을 붙인 경우
SELECT * FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;



