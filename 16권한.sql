



--               오라클SYS계정에서 실행할 것



--------------------------------------------------------------------------------------

SELECT * FROM HR.EMPLOYEES; --HR의 EMPLOYEES 테이블 소환

-- 유저 목록
SELECT * FROM ALL_USERS;

-- 유저 권한 확인
SELECT * FROM USER_SYS_PRIVS;


-- 계정 생성
CREATE USER USER01 IDENTIFIED BY USER01; -- ID USER01, PW USER01

-- 권한 부여 (접속 권한, 테이블 생성 권한, 뷰 생성 권한, 시퀀스 생성 권한 등이 있음)
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01; --USER01 에게 권한 부여

-- 테이블스페이스 지정 (데이터를 저장하는 물리적인 공간), 이걸 지정해야 USER01에서 테이블 생성, 데이터 삽입 등 가능해짐
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


-- 권한 회수
REVOKE CREATE SESSION FROM USER01; -- 접속 권한을 빼앗음

-- 계정 삭제
DROP USER USER01;

--------------------------------------------------------------------------------------


-- 롤 ROLE : 권한의 그룹을 통한 권한 부여
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT CONNECT, RESOURCE TO USER01; -- 커넥트는 접속 롤, 리소스는 개발 롤, DBA는 관리자 롤

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 'USERS' 테이블 스페이스의 용량 제한을 unlimited로 설정하겠다는 의미









