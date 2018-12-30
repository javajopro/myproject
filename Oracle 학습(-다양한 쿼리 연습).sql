show user;

--kh가 가진 테이블 조회
select * from tab;

select * from department;
select * from employee;
select * from job;
select * from location;
select * from nation;
select * from sal_grade;

--일반관리자, 슈퍼관리자
--1.sys(슈퍼관리자) : 데이터베이스 생성/삭제하는 권한 있음. 
--                데이터베이스 관련 모든 문제를 처리 가능
--                로그인시 SYSDBA롤로 접속해야함.
--2.system(일반관리자) : 데이터베이스 생성/삭제 권한 없음.
--                   데이터베이스 유지보수하는 관리자.

/*
## Table
- 데이터를 담고 있는 객체
- 데이터에 대해서 생성, 조회, 수정, 삭제(CRUD)작업을 하는 대상
- 행과 열로 이루어져 있다.

Table(Entity, Relation) : Employee
Column(Field, Attribute) : Emp_id 200 201 202.....
Row(Record, Tuple) : 200	선동일	621225-1985634	sun_di@kh.or.kr	01099546325	D9	J1	S1	8000000	0.3		90/02/06		N
Domain : 하나의 컬럼(속성)이 취할 수 있는 같은 타입으로 이루어진 값의 집합
        gender : 남, 여

*/

--하나의 테이블 정보조회
desc employee;

--null여부 (nullable)
--1. not null : 필수요소
--2. null : 선택요소

/*
Data type
1. 문자형
* CHAR : 고정길이 문자형(최대 2000byte)
* VARCHAR2 : 가변길이의 문자형(최대 4000byte)

* NCHAR : char와 동일하나 유니코드 문자개수로 처리. 고정형.
          1000개*유니코드(2byte) => 2000byte까지 가능
* NVARCHAR2 : varchar2와 동일하나 유니코등 문자개수로 처리. 가변형
          2000개*유니코드(2byte) => 4000byte까지 가능
          
    char(10) 고정형으로 문자열 10byte
            'korea' : 실제로는 5byte지만, 저장시에는 10byte모두 사용. 빈공백으로 잔여크기 채움.
            '대한민국' : 글자당 2byte, 실제로는 8byte지만, 저장시에는 10byte
            '대한민국 서울시' : 실제로는 15byte이지만, 최대크기가 10byte이므로 에러
    varchar2(20) 가변형으로 문자열 20byte까지 저장가능
            'korea' : 실제 5byte, 저장 5byte
            '대한민국' : 실제 8byte, 저장 8byte
            '대한민국 서울시' : 실제 15byte, 저장 15byte
    
    nchar(10) 고정형, 문자열개수가 10개까지 허용
    nvarchar2(10) 가변형, 문자열개수가 10개까지 허용
    
long : 최대 2gb까지 작성가능한 가변형  문자타입.

*/    
--테스트용테이블생성
create table tb_chartype(
    col1 char(6),
    col2 varchar2(6),
    col3 nchar(6),
    col4 nvarchar2(6)
);

--데이터입력(create)
insert into tb_chartype values('abc', 'abc', 'abc', 'abc');
insert into tb_chartype values('가나다', '가나다', '가나다', '가나다');
--오라클에서 한글처리는 2byte지만, 11g xe버젼은 3byte로 처리됨.
insert into tb_chartype values('가', '가', '가나다', '가나다');

select * from tb_chartype;

--메모리에서 작업한것을 취소.
rollback;
--메모리에서 작업한 내용을 실제 파일에 적용
commit;


/*    
2. 숫자형
number([p,s])
- precision : 표현할 수 있는 전체 숫자 자리수 (1~38)
- scale : 소수점이하 자리수(-84 ~ 127)

데이터입력값이 1234.678일때,

데이터타입       저장되는 값
------------------------------------
number(7,3)     1234.678
number(7)       1235
number         1234.678
number(7,1)     1234.7
number(5,-2)     1200
------------------------------------

3. 날짜형 : date
일자(년/월일) 및 시간(시/분/초) 정보를 관리
기본적으로 화면에 년/월/일만 표시된다.
날짜의 연산 또는 비교가 가능하다.

연산      결과타입        설명
---------------------------------------
날짜+-숫자   date        하루를 1로 계산해서 처리함.
날짜+-날짜   number     두 날짜의 차이를 리턴(하루가 1기준)

정밀한 시각정보(밀리초이하)를 표현하기 위한 timestamp타입도 있다.

*/
select sysdate from dual;
select sysdate-1 from dual;
select sysdate+1 from dual;

select to_char(sysdate, 'yyyy/mm/dd hh:Mi:ss') from dual;

select systimestamp from dual;


/*

4. LOB형
- clob : 최대4GB 허용가능한 문자타입

*/

--@실습문제 : today라는 회사의 회원테이블을 작성할때, 
--다음 필드에 적절한 db데이터타입을 설정해서 tb_today_member라는 테이블을 생성하세요.
/*
1. id : 8자리에서 15자리
2. password : 8자리이상 15자리
3. name 
4. phone : -없이 11자리
5. ssn : 주민번호 -없이 13자리
6. mileage : 회원마일리지
7. reg_date : 가입일
*/
create table tb_today_member(
    id varchar2(15),
    password char(15),
    name varchar2(100),
    phone char(11),
    ssn char(13),
    mileage number,
    reg_date date
);

-----------------------------------------------
--# SQL
-----------------------------------------------
/*
Structured Query Language : 구조화된 질의 언어
dbms사용되는 sql문법이 조금씩 다름.

* ddl : Data Definition Language. 데이터베이스의 구조, 객체에 대한 언어 -> create, alter, drop
* dml : Data Manipulation Language. 저장된 데이터의 조작 -> insert, update, delete, select -> CRUD
* dcl : Data Control Language. 사용자권한, 설정 -> grant, revoke
* tcl : Transaction Control Language -> commit, rollback, savepoint 

*/
-----------------------------------------------
--## DQL1
-----------------------------------------------
/*
데이터를 검색(추출)하기 위한 언어.
DML로 분류됨.
데이터를 조회한 결과를 ResultSet(결과집합)
-> 0개이상의 행이 포함
-> 특정기준에 의해서 정력될 수 있음.

5. select : 조회하고자하는 컬럼명을 기술함.
1. from : 조회하고자 하는 테이블명 기술
2. where : 특정행을 선출하는 조건을 기술함.
3. group by
4. having
6. order by : 특정컬럼을 대상으로 오름/내림차순 지정.

*/
select * 
from employee;

select emp_id, emp_name, salary 
from employee;

select emp_id, emp_name, salary, job_code 
from employee 
where job_code='J5';

select emp_id, emp_name, salary, job_code --3
from employee --1
where job_code='J5'--2 
order by emp_name; --4

/*
select 
from 
where 
order by
*/

--1. job테이블에서 job_name컬럼만 출력
select job_name
from job;
--2. department테이블의 전체 컬럼을 출력
select *
from department;
--3. employee테이블에서 이름, 이메일, 전화번호, 입사일을 출력
select emp_name, email, phone, hire_date
from employee;
--4. employee테이블에서 월급이 2,500,000원 이상인 사람만 출력
select *
from employee
where salary >= 2500000;

--5. employee테이블에서 
--월급이 350만원이상이면서 job_code가 'J3'인 
--사원의 이름, 전화번호 출력
select emp_name, phone
from employee
where salary >= 3500000 and job_code = 'J3';

--산술연산
--연봉 : 월급*12 + (월급*보너스)*12
select emp_name,
      salary,
      bonus,
      salary*12,
      
      (salary+(salary*bonus))*12
from employee;

select null, 1+null, 0*null, null/2 from dual;

--null처리함수 : nvl(col, val)=> 값을 리턴
--col의 값이 null인 경우, val를 리턴
--col의 값이 null이 아닌 경우, col의 값을 리턴

select nvl(7,3), nvl(null,3), nvl('이순신','거북선'), nvl(null,'거북선')
from dual;

select nvl(bonus,0), bonus
from employee;

select emp_name,
      (salary+(salary*nvl(bonus,0)))*12
from employee;

--컬럼명 별칭(alias)지정 
-- as "별칭" 
-- 반드시 ""를 써야하는 경우 : 공백이 포함된 경우, 숫자로 시작하는 경우
select emp_name "사원 명",
      (salary+(salary*nvl(bonus,0)))*12 as "2108년 연봉"
from employee;

--컬럼에 리터럴(literal)지정
--리터럴은 resultset의 모든행에 반복표시됨.
select emp_name, salary, '원' as 단위, 12345
from employee;

--중복값 제거 distinct
-- select절에 한번만 사용가능, 여러컬럼을 사용하면, 여러컬럼을 합친것을 고유값으로 간주

select distinct job_code, dept_code
from employee;

--연결연산자 ||
--문자열연결, 기타값과 문자열연결에 +연산자가 아닌 || 연산자사용

select emp_name, salary || '원' as aaaaaaaaaaaaaaaaaaaaaaaaa,
      salary as bbbbbbbbbbbbbbbbbbbbbb
from employee;

desc employee;

--where절에 사용하는 연산자
/*
--1.논리연산자
and 
or
not : 해당결과를 반전한다.(null을 제외)

--2.비교연산자
=
>, <
>=, <=
<>, ^=, !=  같지 않다.
between 값1 and 값2 : 값1 이상 값2 이하
like/ not like : 문자패턴비교
is null/ is not null : null여부 비교 -> where bonus is not null
in / not in : 비교값 목록에 포함되었는지 여부

*/
--부서코드 D6이고, 급여를 2000000원보다 많이 받는 사원의 이름, 부서, 월급을 출력
select emp_name, dept_code, salary
from employee
where dept_code = 'D6' and salary > 2000000;

--직급코드가 J1이 아닌 사원들의 월급등급(sal_level)을 중복없이 출력
select distinct sal_level
from employee
where job_code <> 'J1';

--비교연산자 between and
--급여를 3500000원 이상, 6000000원 이하인 사원의 이름과 급여를 출력

select emp_name, salary
from employee
where salary between 3500000 and 6000000;
where salary >= 3500000 and salary <= 6000000;

--숫자, 날짜에 대해서 사용가능.
--입사일이 90/01/01 ~ 01/01/01인 사원을 조회
select emp_name, hire_date
from employee
where hire_date between '90/01/01' and '01/01/01';
--기본날짜포맷으로 날짜데이터를 의미하는 문자열을 전달하면, 자동형변환후 처리됨.

select sysdate from dual;

--문자열패턴비교 like
--비교하려는 값이 지정한 문자패턴을 만족시키면 true을 리턴함.
--와일드카드 % _를 사용함
-- % : 글자가 없든지, 있으면 true
-- _ : 임의의 문자1개를 의미함.

--'전'씨 성을 가진 직원이름과 급여조회
select emp_name, salary
from employee
where emp_name like '전__';--이름이 3글자라는 조건이 있다면.
where emp_name like '전%';

--이름에 '이'가 들어가는 사원명 조회
select emp_name
from employee
where emp_name not like '%이%';

--email에서 _의 앞자리가 3자리인 직원을 조회
--이스케이핑처리 : 임의의 문자를 이스케이프 문자로 사용하고, 이를 명시
select email
from employee
where email like '___#_%' escape '#';

--@실습문제
--tb_watch테이블의 description컬럼에서 99.99%라는 문자열이 있는 행 조회
create table tb_watch(
    watchname varchar2(40),
    description varchar2(200)
);
--drop table tb_watch;
insert into tb_watch values ('금시계', '순금 99.99%함유 고급시계');
insert into tb_watch values ('은시계', '고객만족도 99.99점을 획득한 고급시계');
commit;
select * from tb_watch;

select *
from tb_watch
where description like '%99.99\%%' escape '\';

--비교연산자 in
--비교하려는 값 목록에 일치하는 것이 있는가? 있으면 true, 없으면 false
--D6, D8 부서의 사원들을 조회하라.

select emp_name, dept_code
from employee
where dept_code in ('D6','D8');
where dept_code = 'D6' or dept_code = 'D8';

--D6, D8 부서가 아닌 사원들을 조회하라.
select emp_name, dept_code
from employee
where dept_code ^= 'D6' and dept_code ^= 'D8';
where dept_code not in ('D6','D8');

--연산자우선순위
--1. 산술연산자
--2. 연결연산자 ||
--3. 비교연산자
--4. IS NULL / IS NOT NULL, LIKE, IN / NOT IN
--5. BETWEEN AND / NOT BETWEEN AND
--6. NOT
--7. AND
--8. OR

--직급코드가 J7 또는 J2이고, 급여가 2000000원 이상인 사원 조회
select emp_name, job_code, salary
from employee
where (job_code = 'J7' or job_code = 'J2') and salary >= 2000000; 

--order by
--select한 컬럼에 대해서 정렬기준을 제시
--order by 컬럼명 | 별칭 | 컬럼순서 [정렬방식(ASC | DESC)] [NULLS FIRST | LAST]

select emp_name
from employee
order by emp_name desc;

select emp_id as "아이디",
      emp_name as "사원명",
      dept_code as "부서코드"
from employee
order by 3 asc nulls first, 2 desc ;


-----------------------------------------------
--# FUNCTION
-----------------------------------------------
/*
일련의 처리과정을 반복적으로 사용하기 위해서 작성해둔 서브프로그램.
호출시 값을 전달하면, 수행결과를 리턴하는 방식

함수의 유형
1. 단일행처리 함수
    * 문자처리함수
    * 숫자처리함수
    * 날짜처리함수
    * 형변환함수
    * 기타함수
2. 그룹함수

*/

-----------------------------------------------
--## 1.단일행처리함수
-----------------------------------------------
--### 문자처리함수

--1. length : 문자개수를 리턴

select emp_name, length(emp_name),
      email, length(email)
from employee;

--2. lengthb : 문자열의 byte를 리턴

select emp_name, lengthb(emp_name),
      email, lengthb(email)
from employee;

--3. instr 
--찾는 문자열이 대상문자열에서 지정한 위치부터 지정한 회수번째에 나타난 위치를 반환.
--instr(대상문자열, 찾고자하는문자열[, 시작인덱스[, 몇번째]])
--오라클에서 인덱스는 0기반이 아닌 1기반이다.

select instr('kh정보교육원 국가정보원 정보문화사','정보',1,1),
      instr('kh정보교육원 국가정보원 정보문화사','정보',4),
      instr('kh정보교육원 국가정보원 정보문화사','정보',4,2),
      instr('kh정보교육원 국가정보원 정보문화사','정보',-6)--11    
      
from dual;

--email컬럼에서 @의 위치인덱스값을 출력
select email,
      instr(email,'@')
from employee;

--4. lpad/rpad
--lpad(string,byte[,paddingString])
--byte공간에 string문자열을 쓰고, 남은공간 왼쪽/오른쪽에 paddingString으로 채워라
select lpad(email,20,'#'), rpad(email,20,'#'),
      lpad(email,20), rpad(email,20)
from employee;

--5. ltrim / rtrim
--ltrim/rtrim(string, str)
select ltrim('        kh',' '),
      ltrim('        kh'),
      ltrim('00001000002345','0'),
      ltrim('1243431243211243kh','123456789')--삭제할 문자열은 문자단위로 처리됨
from dual;

--6. trim
--양쪽에서 지정한 문자를 제거.
select trim('    kh    '),
      trim('z' from 'zzzzzkhzzzz'),
      trim(leading 'z' from 'zzzzzkhzzzz'),
      trim(trailing 'z' from 'zzzzzkhzzzz'),
      trim(both 'z' from 'zzzzzkhzzzz')
from dual;

--trim함수는 제거할 문자열 하나만 지정할 수 있다.
select trim(both '123' from '123122kh132323')
from dual;

--@실습문제 : 123456789098765456hello678908765467898765
select ltrim(rtrim('123456789098765456hello678908765467898765','1234567890'), '1234567890')
from dual;

--7. substr
--substr(string, position[, length])
select substr('showmethemoney',5,2),
      substr('showmethemoney',10),
      substr('showmethemoney',-8,3),
      substr('show me the money',9,3)
from dual;

--8. lower / upper / initcap
select lower('Welcome To The Oracle'),
      upper('Welcome To The Oracle'),
      initcap('welcome to the oracle')
from dual;

--9. concat
--문자연결함수이지만, 2개의 문자만 처리가능. 
--3개이상연결에는 ||를 사용할 것.
select concat('abc','def'),
      'abc'||'def',
      concat(concat('abc','def'),'ghi'),
      'abc'||'def'||'ghi'
from dual;

--10. replace
--replace(대상문자열,fromString,toString)
select  replace('I hate you','hate','love')
from dual;

--@실습문제
--1. 사원명에서 성만 중복없이 출력(성은 한글자라고 가정함)
select distinct substr(emp_name,1,1) 
from employee
order by 1;

--2. employee테이블에서 남자만 사원번호, 사원명, 주민번호를 출력
--주민번호의 뒷자리6자리는 ******로 처리할 것

select emp_id 사원번호
    , emp_name 성명
    , substr(emp_no,1,8)||'******' 주민번호		
from employee
where substr(emp_no,8,1) in ('1','3');

--3.다음 tb_files테이블에서 파일명만 출력할 것.
create table tb_files(
    fileno number(3),
    filepath varchar2(500)
);
insert into tb_files values(1, 'C:\abc\def\salesinfo.xls');
insert into tb_files values(2, 'C:\music\안녕.mp3');
insert into tb_files values(3, 'C:\movies\서치.mp4');
insert into tb_files values(3, 'C:\document\학생레포트.hwp');
commit;
select * from tb_files;

select fileno 파일번호,
      substr(filepath, instr(filepath,'\',-1)+1) 파일명
from tb_files;

--### 숫자처리함수
--1.abs : 절대값구하기
select abs(10),
      abs(-10)
from dual;

--2.mod : 나머지구하는 함수
--%가 아닌 mod함수를 사용
select mod(10,3),
      mod(10,2),
      mod(10,4)
from dual;

--3.round
--round(number[,position])
select round(123.456, 3), 
      round(123.456, 2),
      round(123.456, 1),
      round(123.456),
      round(123.456, -1),
      round(123.456, -2)
from dual;

--4.ceil
select ceil(123.456)
from dual;
--12.3456을 소수점둘째짜리까지 올림처리해서 표현하기
select ceil(12.3456*100)/100
from dual;

--5.floor
select floor(10.5),
      floor(10.51)
from dual;


--6.trunc
--trunc(number, position)
select trunc(123.456, 1),
      trunc(123.456, 2),
      trunc(123.456),
      trunc(123.456, -1)
from dual;


--### 날짜처리함수
--1.sysdate
select sysdate from dual;

--시분초표현
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')
from dual;

--어제, 오늘, 내일 표현
--하루를 1로 치환해서 연산한다.
select sysdate-1, sysdate, sysdate+1
from dual;

select to_char(sysdate-1,'yyyy-mm-dd hh24:mi:ss'),
      to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
      to_char(sysdate+1,'yyyy-mm-dd hh24:mi:ss')
from dual;

--한시간전
select to_char(sysdate-1/24,'yyyy-mm-dd hh24:mi:ss')
from dual;

--30분전
select to_char(sysdate-(30*1/24/60),'yyyy-mm-dd hh24:mi:ss')
from dual;

--2.add_months
--add_months(date, number)
--1이 한달
select add_months(sysdate,1)
from dual;
--입사후 3개월후 날짜조회
select emp_name, hire_date, add_months(hire_date,3)
from employee;

--3. months_between
--months_between(date1, date2)
--date1과 date2의 날짜차이를 month단위로 리턴
--1이 한달

select add_months(sysdate,12),
      months_between(add_months(sysdate,12), sysdate)
from dual;

--수료일로부터 남은개월수
select to_date('19/03/12','yy/mm/dd'),
      months_between(to_date('19/03/12','yy/mm/dd'), sysdate) 
from dual;

--@실습문제
--근무개월수 구하기
select emp_name, hire_date,
      trunc(months_between(sysdate, hire_date))||'개월' "근무개월수" 
from employee;

--한동준씨가 오늘 재입대합니다. 군복무 1년6개월이라합니다.
--전역일, 전역일까지 먹어야 짬빱의 수를 출력하세요.

select sysdate "동준씨 재입대일",
      add_months(sysdate,18) "전역일",
      (add_months(sysdate,18)-sysdate)*3 "짬밥수"
from dual;

--4.next_day
--인자로 전달받은 요일데이타를 토대로 가장 빠른 해당요일을 리턴
--next_day(date, string | number)

--요일을 추출
select to_char(sysdate, 'day') "월요일",
      to_char(sysdate, 'dy') "월",
      to_char(sysdate, 'd') "1"--일요일 1
from dual;

select next_day(sysdate, '월요일'),
      next_day(sysdate, '목'),
      next_day(sysdate, 7)
from dual;

--5.last_day
--해당일자를 기준으로 해당월의 말일을 리턴
select last_day(sysdate) from dual;

--6.extract
--특정일에서 년월일 정보를 추출함.
--extract(year|month|day from date)

select extract(year from sysdate) "년",
      extract(month from sysdate) "월",
      extract(day from sysdate) "일"
from dual;

--사원테이블에서 입사일의 년, 월, 일을 각각 출력

select extract(year from hire_date) "년",
      extract(month from hire_date) "월",
      extract(day from hire_date) "일"
from employee;

--7.trunc
--trunc(date) : 시분초 정보를 00:00:00으로 처리
select to_char(trunc(sysdate), 'yyyy/mm/dd hh24:mi:ss'),
      to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')
from dual;

--### 형변환함수
/*
        to_char()         to_number() 
        ---------->         ---------->
    DATE       CHARACTER        NUMBER
        <----------         <----------
        to_date()         to_char()
        
*/      
--1.to_char
--to_char(date[,format])

select to_char(sysdate-1,'yyyy/mm/dd hh24:mi:ss day') 어제,
      to_char(sysdate,'yyyy/mm/dd hh24:mi:ss day') 오늘,
      to_char(sysdate+1,'yyyy/mm/dd hh24:mi:ss day') 내일
      
from dual;

--@실습문제 
--1. 사원테이블에서 사원명과 입사일을 출력. 1990/2/19(화)
select emp_name 사원명,
      to_char(hire_date,'fmyyyy/mm/dd(dy)') 입사일
from employee;

--2. 현재시각으로 부터 1일 2시간 3분 4초뒤를 출력(yyyy-mm-dd hh24:mi:ss)
--일 -> 1
--시간 -> 1/24 
--분 -> 1/24/60
--초 -> 1/24/60/60
select to_char(sysdate+1+(2*1/24)+3*(1/24/60)+4*(1/24/60/60),'yyyy/mm/dd hh24:mi:ss')
from dual;

--to_char(number[,format])
/*
,   9,999   세자리마다 콤마찍기
.   9.99    소수점이하 2자리까지표현
9   999     해당자리의 숫자
0   900     해당자리의 숫자가 없을시 0으로 표현함.
$   $999    통화기호
L   L999    Local통화로 표시(한국은 ￦)
fm  fm999   포맷9로부터 치환된 공백 혹은 소수점이하 0을 제거

*/
select to_char(1234567, '999,999,999'),
      to_char(1234567, '999,999'),--오류 : 자릿수가 모자름.
      to_char(1234567, 'L999,999,999'),
      to_char(1234.567, '999,999.999'),
      to_char(1234.567, '000,000.000')
from dual;

--2. to_date
--숫자/문자형 데이터를 받아서 날짜형으로 리턴
select to_date('20181225','yyyymmdd') 날짜로,
      to_char(to_date('20181225','yyyymmdd'), 'yyyy/mm/dd hh24:mi:ss') 다시문자로,
      to_date(20181225,'yyyymmdd')
      --to_date(051225,'yyyymmdd')--ORA-01840: input value not long enough for date format
from dual;

--2000년도 이후에 입사한 사원을 조회(사원명, 입사일 출력)
--입사일 : 1999년 9월 9일(화요일)
select emp_name 사원명,
      --to_char(hire_date,'yyyy년 mm월 dd일(day)') 입사일--ORA-01821: date format not recognized
      to_char(hire_date,'fmyyyy"년" mm"월" dd"일"(day)') 입사일
from employee
where hire_date > to_date('20010101','yyyymmdd');

--수료일 2019년 3월 12일 21:30까지 남은 시간을 계산하기
select to_date('201903122130','yyyymmddhh24mi')-sysdate
from dual;

-- ?일 ?시간 ?분 ?초 남았습니다.
--151.202708333333333333333333333333333333
--일단위 -> 초단위 -> 결과도출

--?*24*60*60 ->초단위
select (to_date('201903122130','yyyymmddhh24mi')-sysdate)*24*60*60
from dual;

--3730초
--시간
select trunc(3730/60/60) 시간,
      mod(trunc(3730/60),60) 분,
      mod(3730, 60) 초
from dual;

select trunc((to_date('201903122130','yyyymmddhh24mi')-sysdate)*24*60*60)
from dual;

--13063313
select trunc(13063313/60/60/24) 일,--해당초를 하루(60*60*24)로 나눈 몫(정수부) : 일
      mod(trunc(13063313/60/60),24) 시간,--해당초를 한시간(60*60초)로 나누고, 다시 하루(24)로 나눈 나머지 
      mod(trunc(13063313/60),60) 분,--해당초를 1분(60초)로 나누고, 다시 한시간(60분)으로 나눈 나머지
      mod(13063313,60) 초--해당초를 60초로 나눈 나머지
from dual;

--공식
select trunc(?/60/60/24) 일,
      mod(trunc(?/60/60),24) 시간,
      mod(trunc(?/60),60) 분,
      mod(?,60) 초
from dual;

select trunc(trunc((to_date('201903122130','yyyymmddhh24mi')-sysdate)*24*60*60)/60/60/24) 일,
      mod(trunc(trunc((to_date('201903122130','yyyymmddhh24mi')-sysdate)*24*60*60)/60/60),24) 시간,
      mod(trunc(trunc((to_date('201903122130','yyyymmddhh24mi')-sysdate)*24*60*60)/60),60) 분,
      mod(trunc((to_date('201903122130','yyyymmddhh24mi')-sysdate)*24*60*60),60) 초
from dual;

--3.to_number
--to_number(character[, format])
--1,000,000,000 - 50,000,000

select to_number('1,000,000,000', '9,999,999,999') - to_number('50,000,000','999,999,999')
from dual;

--자동형변환
select '1000'+'100',
     to_number('1000','99999')+to_number('100','9999')
from dual;

select emp_name 사원명,
      to_char(hire_date,'fmyyyy"년" mm"월" dd"일"(day)') 입사일
from employee
where hire_date > '01/01/01';--기본날짜포맷으로 이루어진 문자열(날짜정보)는 자동형변환

--현재 세션관련정보
select *
from v$nls_parameters;
--NLS_DATE_FORMAT	RR/MM/DD

--@실습문제
--1. employee테이블에서 사원명, 급여, 연봉를 출력 (￦1,000,000)
--연봉 = (급여+(급여*보너스))*12

--2.현재시각에서 3시간후 날짜정보를 yyyy/mm/dd hh24:mi:ss로 출력

--3.경매
create table tb_auction(
    auction_no number,
    expire_date date
);
--drop table tb_auction;
insert into tb_auction values(1, to_date('2018/10/13 15:40:00','yyyy/mm/dd hh24:mi:ss'));
insert into tb_auction values(2, to_date('2018/10/14 15:40:00','yyyy/mm/dd hh24:mi:ss'));
insert into tb_auction values(3, to_date('2018/10/12 22:00:00','yyyy/mm/dd hh24:mi:ss'));
insert into tb_auction values(4, to_date('2018/10/12 19:00:00','yyyy/mm/dd hh24:mi:ss'));

commit;

select auction_no "경매번호",
      to_char(expire_date, 'yyyy/mm/dd hh24:mi:ss') "종료일자"
from tb_auction;

--경매테이블에서 경매번호, 경매종료시각, 남은시간(일시분초)로 출력하세요.
    
--경매테이블에서 종료일자까지 남은시간이 하루미만인 것만, 
--경매번호, 경매종료시각, 남은시간(일시분초)로 출력하세요.

--4. nvl
--null처리함수 nvl(컬럼, null일경우값)
--nvl2(col, val1, val2)
--col의 값이 null이 아니면 val1, null이면, val2
select nvl2(7,3,2),
      nvl2(null,3,2),
      nvl2('거북선','이순신','이성계'),
      nvl2(null,'이순신','이성계')
from dual;
--보너스가 있는 사원은 보너스있음, 없으면 보너스없음으로 표시하세요.
select emp_name,
      bonus,
      nvl2(bonus,'보너스있음','보너스없음') 보너스여부
from employee;

--##기타함수
--1.greatest, least
--숫자, 문자, 날짜 비교

select greatest('이재선','한동준','김민성'),
      least('이재선','한동준','김민성'),
      greatest(1,2,3),
      least(1,2,3),
      greatest(sysdate+1,sysdate,sysdate-1),
      least(sysdate+1,sysdate,sysdate-1)
from dual;

--2.decode (선택함수)
--switch문과 흡사함. 값을 비교해서 선택함
--decode(표현식,조건1,결과1,조건2,결과2,조건3,결과3,....)
--사원명과 직급코드에 따른 직급명으로 출력
--J1 -> 대표
--J2 -> 부사장
--J3 -> 부장
--J4 -> 차장
--J5 -> 과장
--J6 -> 대리
--J7 -> 사원
select emp_name,
      job_code,
      decode(job_code,'J1','대표',
                    'J2','부사장',
                    'J3','부장',
                    'J4','차장',
                    'J5','과장',
                    'J6','대리',
                    'J7','사원') 직급명,
     decode(job_code,'J1','대표',
                    'J2','부사장',
                    'J3','부장',
                    '평사원') 직급명                    
     
from employee;

--3.case
/*
1. case when 조건1 then 결과1
       when 조건2 then 결과2
       ...
       else 결과
       end

2. case 조건 
       when 조건1 then 결과1
       when 조건2 then 결과2
       ...
       else 결과
       end
*/

select emp_name,
      case when substr(emp_no,8,1)='1' then '남'
           when substr(emp_no,8,1)='3' then '남'
           else '여'
           end "성별",
      case when substr(emp_no,8,1) in ('1','3') then '남'
           else '여'
           end "성별"
from employee;

select emp_name,
      case substr(emp_no,8,1) 
           when '1' then '남'
           when '3' then '남'
           else '여'
           end "성별"
from employee;

--@실습문제 : 사원나이를 조회 (현재년도-출생년도+1)
----------------------------------------
--사원명   주민번호    성별  나이
----------------------------------------

select emp_name 사원명,
      emp_no 주민번호,
      case when substr(emp_no,8,1) in ('1','3') then '남' else '여' end 성별,
      extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2),'yy'))+1 "잘못된 나이1",
      extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2),'rr'))+1 "잘못된 나이2",
      extract(year from sysdate)
      - (to_number(substr(emp_no,1,2))+
        case when substr(emp_no,8,1) in ('1','2') then 1900 
             else 2000 end) 
      +1 "올바른 나이"
from employee;  

--날짜포맷 yy, rr
--1. 4자리처리할때 yyyy, rrrr는 동일하다.
--2. 2자리처리할때는 다르다.
/*
rr
-------------------------------------------
현재년도    입력년도    처리년도
-------------------------------------------
00~49      00~49    현재세기
           50~99    전세기 
50~99      00~49    다음세기
           50~99    현재세기 
-------------------------------------------

현재년도    입력년도    rr      yy
-------------------------------------------
1994        95     1995    1995
1999        04     2004    1904
2018        10     2010    2010
-------------------------------------------

*/

-----------------------------------------------
--## 2.그룹함수
-----------------------------------------------
--하나의 행이 아니라, 여러행을 그룹으로 묶어서 총합, 평균 등의 값을 리턴하는 함수
--1.sum
select sum(salary)
from employee;

--2.avg
select trunc(avg(salary)) 평균
from employee;

--3.count
select count(*) 총사원수
from employee;

select count(*) "보너스없는사원수"
from employee
where bonus is null;

--4.max
--5.min
select max(salary),
      min(salary)
from employee;

select max(hire_date),
      min(hire_date)
from employee;

-----------------------------------------------
--## DQL2
-----------------------------------------------
--3. group by
--세부적인 그룹을 지정해서 그룹함수를 사용할 수 있다.
--부서별 salary의 합계

select dept_code, sum(salary)
from employee;--ORA-00937: not a single-group group function

select dept_code, sum(salary)
from employee
group by dept_code;

select * from employee
where dept_code is null;

--직급별 사원수를 조회하고, 직급순으로 정렬하라.
select job_code, count(*) 사원수
from employee
group by job_code
order by 1;

--부서코드별 급여의 합계, 급여의 평균(정수처리), 인원수 조회
select dept_code,
      sum(salary),
      trunc(avg(salary)),
      count(*),
      sum(1)
from employee
group by dept_code;

--부서코드별로 보너스를 지급받는 사원수를 조회.
select dept_code, count(*)
from employee
where bonus is not null
group by dept_code
order by 1;

select dept_code, count(bonus)--컬럼의 값이 null인 행을 제외하고 연산
from employee
group by dept_code
order by 1;

--두개이상의 컬럼을 대상으로 할 수 있다.
select dept_code, job_code, count(*)
from employee
group by dept_code, job_code
order by 1,2;

--@실습문제 : 
--1. employee테이블에서 직급코드가 J1인 사원을 제외하고, 
--직급별 사원수, 평균급여를 조회
select job_code, count(*), trunc(avg(salary))
from employee
where job_code <> 'J1'
group by job_code
order by 1;

--2. employee테이블에서 직급코드가 J1인 사원을 제외하고, 
-- 입사년도별 인원수를 조회해서, 입사년 기준으로 정렬할 것.

select extract(year from hire_date), count(*)
from employee
where job_code <> 'J1'
group by extract(year from hire_date)
order by 1;

--3. employee테이블에서 성별 인원수와 급여의 평균을 출력할 것.
select decode(substr(emp_no,8,1),'1','남','3','남','여') 성별,
      count(*),
      trunc(avg(salary))
from employee
group by decode(substr(emp_no,8,1),'1','남','3','남','여')
order by 1;

--4. 부서내 성별 인원수를 구하세요
select dept_code 부서코드, 
      decode(substr(emp_no,8,1),'1','남','3','남','여') 성별,
      count(*)
from employee
group by dept_code, decode(substr(emp_no,8,1),'1','남','3','남','여')
order by 1, 2;


--부서별 급여평균이 300만원 이상인 부서들만 부서명, 급여평균을 출력하세요.
select dept_code, avg(salary)
from employee
group by dept_code
where avg(salary) >= 3000000;


--4. having
--그룹함수로 값을 구해야하는 그룹에 조건은 having절에 기술함.
--그룹함수를 사용한 where은 쓸수 없다.
select dept_code, trunc(avg(salary))
from employee
group by dept_code
--having avg(salary) >= 3000000
order by dept_code;

--부서별인원이 5명이상인 부서만 출력
select dept_code 부서코드,
      count(*) 인원수
from employee
group by dept_code
having count(*) >= 5
order by 1;

--관리하는 사원이 2명이상인 매니져의 
--매니져 아이디와 관리하는 사원수를 출력
select manager_id, count(*)
from employee
where manager_id is not null
group by manager_id
having count(*) >=2 
order by 1;

--### 소계, 누계를 처리하기 : rollup, cube
--1. rollup : 가장 먼저 지정한 그룹별 합계와 총합계를 출력
--2. cube : 그룹으로 지정된 모든 그룹에 대한 합계와 총합계를 출력

--부서별 인원정보
--rollup
select dept_code, count(*)
from employee
group by rollup(dept_code)
order by 1;

--cube
select dept_code, count(*)
from employee
group by cube(dept_code)
order by 1;

--그룹지정한 컬럼이 하나인 경우, rollup, cube 결과는 동일하다.
 
--grouping함수
--group by절에 의해서 산출된 컬럼은 0을 리턴
--rollup, cube에 의해서 산출된 컬럼은 1을 리턴

select decode(grouping(dept_code),0,nvl(dept_code,'인턴'),1,'총계') 부서, 
      count(*)
from employee
group by cube(dept_code)
order by 1;

--부서별 급여정보 출력(null처리 할것)
select case grouping(dept_code)
      when 0 then nvl(dept_code, '인턴')
      else '총계' end 부서코드, 
      sum(salary) 
from employee
group by rollup(dept_code)
order by 1;

--두개이상의 컬럼으로 그룹핑하고, rollup/cube를 사용하면...
--rollup
--부서내 직급별 인원정보 출력

select decode(grouping(dept_code),0,nvl(dept_code,'인턴'),'합계') 부서코드,
      decode(grouping(job_code),0,job_code,'소계') 직급,
      count(*)
from employee
group by rollup(dept_code, job_code)
order by 1,2;

--cube
select decode(grouping(dept_code),0,nvl(dept_code,'인턴'),'합계') 부서코드,
      decode(grouping(job_code),0,job_code,'합계') 직급,
      count(*)
from employee
group by cube(dept_code, job_code)
order by 1,2;

select decode(grouping(dept_code),0,nvl(dept_code,'인턴'),'합계') 부서코드,
      decode(grouping(job_code),0,job_code,'합계') 직급,
      count(*),
      case when grouping(dept_code)=0 and grouping(job_code)=1
           then '부서별합계'
           when grouping(dept_code)=1 and grouping(job_code)=0
           then '직급별합계'
           when grouping(dept_code)=1 and grouping(job_code)=1
           then '총합계'
           else '-' end "구분"
from employee
group by cube(dept_code, job_code)
order by 1,2;



-----------------------------------------------
--## JOIN
-----------------------------------------------
--1.join : 가로합침, 컬럼과 컬럼을 합치는 것.
--2.union : 세로합침, 행과 행을 합치는 것.

--여러테이블의 레코드를 조합하여 하나의 행으로 표현한 가상테이블 생성
--연관성이 있는 컬럼을 기준으로 조합

--조인맛보기
--송종기 사원의 부서명을 알고싶은 경우
select *
from employee
where emp_name='송종기';

select dept_title
from department
where dept_id = 'D9';

select dept_title
from employee join department
    on employee.dept_code = department.dept_id
where emp_name = '송종기';

--join 두가지종류
--1. equi-join : 동등조건으로 조인하는 경우. =을 이용
--2. non equi-join : 동등조건이 아닌 between and, is null, in등을 이용한 조인

--join 두가지문법
--1. ANSI 표준문법 : dbms와 상관업시 공통적으로 사용하는 표준 sql. join키워드 사용
--2. Oracle전용구문(벤더사 제공하는문법) : oracle에서 사용하는 구문. , 콤마(오라콤마)

--## 1.equi-join
--1. 조인하는 컬럼명이 다른 경우
--부서명과 지역명을 출력하라(deparment, location)
select * from department;
select * from location;

--[ANSI]
select dept_title, local_name
from department join location
    on department.location_id = location.local_code;

--[Oracle전용문법]
--1. join키워드 대신 ,(콤마)를 사용
--2. on절대신, where절을 사용
select dept_title, local_name
from department D, location L
where D.location_id = L.local_code;


--2. 조인하는 컬럼명이 같은 경우
--employee, job
select * from employee;
select * from job;

select *
from employee join job
    on employee.job_code = job.job_code;

select emp_name, 
--      job_code,--ORA-00918: column ambiguously defined
      E.job_code,
      job_name
from employee E join job J
    on E.job_code = J.job_code;
    
--[Oracle전용문법]
select emp_name, 
      employee.job_code,
      job_name
from employee, job
where employee.job_code = job.job_code;


--using
--테이블명이나 별칭을 사용하면 에러
select emp_name, job_code, job_name
from employee join job 
    using(job_code);

--지역명과 국가명을 출력(location, nation)
--두가지방법 on, using으로 만들것.
select local_name 지역명
    , national_name 국가명
from location  join nation 
using(national_code)
order by 1;

select local_name 지역명
    , national_name 국가명
from location l join nation n
    on l.national_code = n.national_code
order by 1;

--## equi-join 종류
--1. inner join : 교집합
-- 기본조인 : (inner) join
    
--2. outer join : 합집합
--  left (outer) join : 왼쪽외부조인
--  right (outer) join : 오른쪽외부조인
--  full (outer) join : 완전외부조인

--3. cross join
--4. self join
--5. multiple join

--###1. inner join
--교집합. 기존되는 컬럼에서 null이나 해당하는 값이 없다면 제외.
--employee, department
select * from employee;--24
select * from department;--9
select distinct dept_code from employee;--7

select *
from employee inner join department
    on employee.dept_code = department.dept_id;--22
    
--## 2.outer join
--1. left outer join : 좌측table 모두 반환, 우측테이블은 조건컬럼에 일치하는 row만 반환
select * 
from employee left outer join department
    on employee.dept_code = department.dept_id;--24 = 22+2

--[Oracle전용구문]
--where절에 (+)이 없는 쪽을 우선 다출력
--left : (+) 우항에 작성
--right : (+) 좌항에 작성
select * 
from employee E, department D
where E.dept_code = D.dept_id(+);



--2. right outer join : 우측table 모두 반환, 좌측테이블은 조건컬럼에 일치하는 row만 반환
select *
from employee right outer join department
    on employee.dept_code = department.dept_id
order by dept_id;--25 = 22 + 3, 

--[Oracle전용구문]
select * 
from employee E, department D
where E.dept_code(+) = D.dept_id;

select distinct dept_id
from employee right outer join department
    on employee.dept_code = department.dept_id;

--3. full outer join
--좌측 테이블, 우측테이블 데이터 모두 반환. 
select *
from employee full outer join department
    on employee.dept_code = department.dept_id;--22 = 22 + 2 + 3

--조인결과 : employee(23), department(9)
--inner join : 22
--left outer join : 24 = 22+2
--right outer join : 25 = 22+3
--full outer join : 26 = 22+2+3
--수고하셨습니다 :)

--[Oracle전용구문]
--없다.

--### 3.cross join
--좌측테이블 * 오른쪽테이블 
--모든 경우의 수를 구하고, 행의수는 좌측테이블행개수 * 우측테이블행개수
--cartesian product : 카테시안의 곱

select *
from employee cross join department;--216
select count(*) from employee;--24
select count(*) from department;--9

--평균월급과 평균월급과의 차이
select trunc(avg(salary))
from employee;

select emp_id,
      emp_name,
      salary,
      평균,
      salary-평균 "월급차이"
from employee cross join (select trunc(avg(salary)) "평균"
                        from employee);

--[Oracle전용구문]
--where조건절을 안쓰면 cross join
select emp_id,
      emp_name,
      salary,
      평균,
      salary-평균 "월급차이"
from employee, (select trunc(avg(salary)) "평균"
                        from employee);


--###4.self join
--같은테이블을 조인해서 결과셋을 얻고자할때 사용.

--사원명과 해당사원의 매니져명을 조회
select count(*) from employee
where manager_id is null;

select E.emp_id,
      E.emp_name,
      E.manager_id,
      M.emp_name
from employee E inner join employee M
    on E.manager_id = M.emp_id; --15
    
--[Oracle전용구문]
select E.emp_id,
      E.emp_name,
      E.manager_id,
      M.emp_name
from employee E, employee M
where E.manager_id = M.emp_id;



---###5.multilple join(다중조인)
--사원명, 부서명, 지역명을 출력
select emp_name, dept_code from employee;
select dept_id, dept_title, location_id from department;
select local_code, local_name from location;

--이때 join되는 순서는 반드시 지켜야한다.
select emp_name, 
      dept_title,
      local_name
from employee E 
 join department D on E.dept_code = D.dept_id
 join location L on D.location_id = L.local_code;
    
--[Oracle전용구문]
--다중조인에서 테이블 순서는 중요하지 않다.
select emp_name, 
      dept_title,
      local_name
from employee E, department D, location L
where E.dept_code = D.dept_id 
  and D.location_id = L.local_code;
    
    
--@실습문제 
--직급이 대리이면서, asia지역에 근무하는 직원을 조회
--사번(employee), 
--이름(employee), 
--직급명(job), 
--부서명(department), 
--근무지역명(location), 
--급여(employee)를 출력

select E.emp_id 사번,
      E.emp_name 사원명,
      J.job_name 직급명,
      D.dept_title 부서명,
      L.local_name 근무지역,
      E.salary 급여
from employee E
 join department D on E.dept_code = D.dept_id
 join job J using(job_code)
 join location L on D.location_id = L.local_code
where J.job_name = '대리' and
    local_name like 'ASIA%';

--[Oracle전용구문]
select e.emp_id "사번",
    e.emp_name "이름",
    j.job_name "직급명",
    d.dept_title "부서명",
    l.local_name "근무지역명",
    to_char(e.salary,'FML999,999,999') 급여
from employee e, department d, job j, location l
where (e.dept_code = d.dept_id
  and e.job_code = j.job_code
  and d.location_id = l.local_code)
  and j.job_name = '대리'
  and l.local_name like 'ASIA%';
  
--##2. non-euqi join
--동등조건이 아닌 기준으로 조인
select * from employee;
select * from sal_grade;

select emp_name, E.salary, S.sal_level
from employee E join sal_grade S
  on E.salary between S.min_sal and S.max_sal;
  

-----------------------------------------------
--## 집합연산자(Set Operator)
-----------------------------------------------
--여러개의 질의결과를 가로로 연결하여 합치거나 뺀 후, 하나로 결합하는 방식
--조건1. select절의 컬럼수가 동일해야함.
--조건2. select절의 동일위치게 존재하는 컬럼의 데이터타입이 상호호환가능해야함.

/*
A = {1,2,3,4,5}
B = {3,5,7,9}

1. union 합집합
    A ∪ B = {1,2,3,4,5,7,9} => 합집합, 중복을 제거하고, 첫번째컬럼기준으로 오름차순정렬
    
2. union all 합집합
    A ∪ B = {1,2,3,4,5,3,5,7,9} => 합집합, 중복을 제거하지 않음. 그냥 연결만 함.
    
3. intersect 교집합
    A ∩ B = {3,5}
    
4. minus 차집합
    A - B = {1,2,4}
    B - A = {7,9}

*/
--1.union
-- 가로합침, 중복데이터제거, 첫번째컬럼기준정렬(오름차순)

--부서코드가 D5인 사원의 사원번호, 사원명, 부서코드, 급여를 출력
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5';--6

--급여가 300만원보다 많은 사원의 사원번호, 사원명, 부서코드, 급여를 출력
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000;--9

--union
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
union
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000;--13

--union조건
--ORA-01790: expression must have same datatype as corresponding expression
select 123, '가나다' from dual
union
select '가나다', 123 from dual;

--order by절은 마지막에 select문에서 한번만 사용
select 123, 'zzz' from dual
union
select 456, 'abc' from dual
union
select 345, 'def' from dual
order by 2;

--2. union all
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
union all
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000;--15

--3. intersect 교집합
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
intersect
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000;


--4. minus 차집합
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
minus
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000;--4

select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000
minus
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5';--7

--5. grouping sets
--group by + union all
--부서코드별 인원수, 직급코드별로 인원수를 동시에 출력
select dept_code,
      job_code,
      count(*) 
from employee
group by grouping sets(dept_code, job_code);

--group by + union all
select dept_code,
      null job_code, 
      count(*)
from employee
group by dept_code
union all
select null dept_code,
      job_code,
      count(*)
from employee
group by job_code;

--성별, 부서별, 직급별 급여평균을 구하세요
select nvl(decode(substr(emp_no,8,1),'1','남','3','남','여'),' ') 성별,
    decode(grouping(dept_code),0,nvl(dept_code,'인턴'),' ') 부서코드,
    nvl(job_code,' '),
    trunc(avg(salary))
from employee
group by grouping sets(
    decode(substr(emp_no,8,1),'1','남','3','남','여'),
    dept_code,
    job_code
)
order by 1,2;


--222번 이태림사원 추가
Insert into KH.EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE,QUIT_DATE,QUIT_YN) values ('222','이태림','760918-2854697','lee_tr@kh.or.kr','01033000002','D8','J6','S5',2436240,0.35,'100',to_date('97/09/12','RR/MM/DD'),to_date('17/09/12','RR/MM/DD'),'Y');
commit;


-----------------------------------------------
--## SubQuery
-----------------------------------------------
--하나의 sql문안에 포함된 또 다른 sql문
--메인쿼리에 종속된 서브쿼리가 존재함.
--존재하지 않는 조건에 근거한 값들을 검색할때.

--서브쿼리는 반드시 소괄호 묶을것.
--서브쿼리는 연산자의 오른쪽 위치할 것.

--노옹철사원의 관리자이름을 출력하라.
--셀프조인

select B.emp_name 관리자이름
from employee A left join employee B
    on A.manager_id = B.emp_id--24
where A.emp_name = '노옹철';

select B.emp_name 관리자이름
from employee A join employee B
    on A.manager_id = B.emp_id--15 manager_id가 null인 사원은 제외
where A.emp_name = '노옹철';

--1. 노옹철사원의 manager_id
select manager_id
from employee
where emp_name = '노옹철';--201

--2. manager_id를 emp_id로 가진 사원의 이름
select emp_name "관리자이름"
from employee
where emp_id = 201;

--서브쿼리
select emp_name "관리자이름"
from employee
where emp_id = (select manager_id
                from employee
                where emp_name = '노옹철');

--전직원의 급여평균보다 많은 급여를 받고 사원의 사번, 이름, 직급코드, 급여를 출력
--1. 급여평균
select avg(salary)
from employee;
--2. 급여평균보다 많은 급열 받는 사원 필터링
select emp_id, emp_name, job_code, salary
from employee
where salary > 3107343.33333333333333333333333333333333;

select emp_id, emp_name, job_code, salary
from employee
where salary > (select avg(salary)
                from employee);

--서브쿼리의 유형
--1. 단일행 서브쿼리(단일컬럼)
--2. 다중행 서브쿼리(단일컬럼)
--3. 다중열 서브쿼리(단일행)
--4. 다중행 다중열 서브쿼리
--5. 상관 서브쿼리
--6. 스칼라 서브쿼리
--7. 인라인뷰

--1. 단일행 서브쿼리
--@실습문제
--1. 윤은해사원과 급여가 같은 사원의 사번, 사원명, 급여를 출력
select emp_id, emp_name, salary
from employee
where salary = (select salary
                from employee
                where emp_name = '윤은해')
and emp_name <> '윤은해';

--2. 기본급여가 가장 많은 사람과 제일 적은 사람을 출력
select emp_id 사번, 
      emp_name 사원명,
      salary
from employee
where salary in ((select max(salary) from employee),
               (select min(salary) from employee));
    
--3. D1, D2부서에 근무하는 사원중에 급여가 D5분서의 평균급여보다 많은 사원을 조회
--사번 사원명 부서코드 급여

select dept_code 부서번호,
      emp_id 사원번호,
      emp_name 사원명,
      salary 월급
from employee
where dept_code in ('D1','D2')
   and salary > (select avg(salary)
                from employee
                where dept_code = 'D5');



-- 2. 다중행 서브쿼리
-- 사용가능 연산자 : IN , NOT IN , ANY , ALL , EXISTS

-- in
-- 송종기 , 하이유가 속한 부서의 사원정보 출력

select dept_code
from employee
where emp_name in ('송종기' , '하이유');

select emp_name , dept_code
from employee
where dept_code in ('D5','D9');

-- 서브쿼리 버젼
select emp_name , dept_code
from employee
where dept_code in (select dept_code
                                from employee
                                where emp_name in ('송종기' , '하이유'));
                                
-- not in
-- 송종기 , 박나라가 속한 부서에 근무하지 않는 사원 조회
select emp_name , dept_code
from employee
where dept_code not in (select dept_code
                                from employee
                                where emp_name in ('송종기' , '박나라'));
                                
-- any(some)
-- 서브쿼리의 결과 중에서 하나라도 참이면 참
-- any의 안에는 in처럼 여러개의 값이 올 수 있다.
/*
x > any(..) : any절의 어떤 값보다도 크기만 하면 참. 최소값보다 크기만 하면 참.
x < any(..) : any절의 어떤 값보다도 작기만 하면 참. 최대값보다 작기만 하면 참.
x = any(..) : any절의 어떤 값과 일치만 하면 참. in과 동일하다.
x != any(..) : any절의 하나 이상의 값과 일치하지 않으면 참.

*/
select emp_name , salary
from employee
where salary > any(2000000 , 5000000);

-- all
-- 서브쿼리의 결과 중에서 모두 참이면 참
/*
x > all(..) : 모든 값보다 크면 참. 최대값 보다 크면 참.
x < all(..) : 모든 값보다 작으면 참. 최소값보다 작으면 참.
x = all(..) : 모든 값과 같으면 참. false 처리된다.
x != all(..) : 모든 값과 다르면 참. not in하고 동일하다.
*/
select emp_name ,
        salary 
from employee
where salary > all( 2000000 , 5000000 , 3000000); -- 최대값이랑만 비교

select emp_name ,
        salary 
from employee
where salary < all( 2000000 , 5000000 , 3000000); -- 최소값이랑만 비교

-- D2부서의 모든 사원보다 적은 급여를 받는 사원조회
select emp_name , salary
from employee
where salary < all(select salary
                        from employee
                        where dept_code = 'D2'); -- 최소값 보다 작은 !!! 사원

-- 부서별 평균급여 중에 가장 높은 부서의 부서코드 , 평균급여를 조회
-- all 을 사용해서 해보자.
select dept_code as "부서코드" ,
        avg(salary)
from employee
group by dept_code
having avg(salary) >= all(select avg(salary)
                                from employee
                                group by dept_code);
                                
-- @실습문제
-- 1. 2011년 1월 1일 이전 입사자 중에서
-- 2011년 1월 1일 이후의 어떤 입사자보다 급여를 적게 받는사원 조회.
-- 사원명 , 입사일 , 급여 출력
select * from employee;

select emp_name as "사원명" ,
        hire_date as "입사일" ,
        salary as "급여"
from employee
where hire_date < '2011/01/01' and salary < all(select salary
                                                                    from employee
                                                                    where hire_date > '2011/01/01');
-- 강사님은 hire_date < to_date('20110101','yyyymmdd') 이렇게 비교하셨다.

-- 2. 어떤 'J4' 직급의 사원보다도 많은 급여를 받는, 직급이 J5 , J6 , J7인 사원출력
-- 사원명 , 직급코드 , 급여
select emp_name as "사원명" ,
        job_code as "직급코드" ,
        salary as "급여"
from employee
where job_code in ('J5','J6','J7') and salary > all(select salary
                                                                    from employee
                                                                    where job_code = 'J4');
-- 3. 직급이 대표 , 부사장이 아닌 모든 사원 출력(메인쿼리 조인하지 말것)
-- 사원명 , 직급코드
select * from job;
select emp_name as "사원명" ,
        job_code as "직급코드"
from employee
where job_code not in (select job_code
                                from job
                                where job_name in ('대표','부사장'));

-- 4. Asia1지역에 근무하는 사원정보 출력(메인쿼리 조인하지 말것)
-- 부서코드, 사원명
select * from location;
select * from employee;
select * from department;

select dept_code as "부서코드" ,
        emp_name as "사원명"
from employee
where dept_code in (select dept_id from department where location_id in
                                                                                (select local_code 
                                                                                from location
                                                                                where local_name = 'ASIA1'));                                         
-- 강사님과 선웅이형은 이렇게 푸셨다.
select dept_code , emp_name
from employee
where dept_code =any(select dept_id
                               from department  join location
                               on location_id = local_code
                               where local_name like 'ASIA1');

-- 3. 다중열서브쿼리
-- 하나의 컬럼이 아닌 여러 컬럼
-- 퇴사한 여직원
-- 퇴사한 여직원 같은 부서 , 같은 직급에 해당하는 사원을 조회

select dept_code , job_code
from employee
where quit_yn = 'Y';

select emp_name , dept_code , job_code
from employee
where (dept_code , job_code) in (select dept_code , job_code
                                                from employee
                                                where quit_yn = 'Y');
-- 이때, 서브쿼리 결과가 단일행이든 , 다중행이든 처리방식은 같다.
-- 직급별 최소급여를 받는 직원의 사번 , 이름 , 직급 , 급여를 조회
select job_code , min(salary)
from employee
group by job_code;

select emp_id , emp_name , job_code , salary
from employee
where (job_code , salary) in (select job_code , min(salary)
                                        from employee
                                        group by job_code);

-- 상관 서브쿼리
-- 상호연관 서브쿼리
-- 메인쿼리의 값을 서브쿼리에 전달하고,
-- 서브쿼리를 수행한다음, 그 결과를 다시 메인쿼리로 리턴

-- 직급별 평균급여보다 많은 급여를 받는 사원 출력
select emp_name , job_code , salary
from employee E
where salary > (select avg(salary)
                        from employee
                        where job_code = E.job_code) -- 메인쿼리의 잡코드를 서브쿼리에 전달!!!
order by 2;

select avg(salary)
from employee
where job_code = 'J2';

-- 4.1 exists
-- 서브쿼리의 결과 중에서 만족하는 행이 하나라도 존재하면 참.
select *
from employee
where 1=1; -- 매 행마다 실행 무조건 참

select *
from employee
where 1=2; -- 무조건 거짓

-- 메인쿼리의 행을 검사할때 서브쿼리의 결과셋에 행이 존재하면 참 
    ---> 메인쿼리의 해당행을 resultset에 포함.
-- 메인쿼리의 행을 검사할때 서브쿼리의 결과셋에 행이 존재하지 않으면 거짓
    ---> 메인쿼리의 해당행을 resultset에 포함시키지 않는다.
select *
from employee
where exists(select emp_name from employee where dept_code = 'D5');
--                 참 을 리턴해서 모든 행이 실행된다.
select *
from employee
where exists(select emp_name from employee where dept_code = 'D100');
--                 거짓을 리턴해서 아무것도 나오지 않는다. where 1=2와 동일

-- 메인쿼리의 데이터를 행단위로 체크하는 서브쿼리 작성한다.
-- 부하직원이 한명이라도 있는 직원을 출력
select emp_id , emp_name
from employee E -- <- 메인쿼리를 서브쿼리에 전달하기위한 E
where exists(select emp_name
                    from employee
                    where manager_id = E.emp_id);

select 1
from employee
where manager_id = 200; -- 행이 있느냐 없느냐?

-- not exists를 이용해서 최대/최소값 구하기
-- 행이 존재하면 거짓 , 행이 존재하지 않으면 참
-- 가장 많은 급여를 받는 사원을 조회
select emp_id , salary
from employee E
where not exists(select 1 
                        from employee
                        where salary > E.salary); 

select 1 
from employee
where salary > 5000000;-- (메인쿼리의 해당행의 salary)
-- 500만원보다 많이받는 행이 2개 존재한다. 1이 2개나오니깐

select max(salary)
from employee; -- 8000000

-- 가장급여를 많이받는사람과 적게받는사람을 구해보자.
select emp_id , salary
from employee E
where not exists(select 1 
                        from employee
                        where salary > E.salary)
        or not exists(select 1 
                        from employee
                        where salary < E.salary); 
-- 이해 이렇게 where절에 or로 이어붙여도되고 아니면 union써서 2개 출력해도 된다.
-- not exists니까 employee E 의 salary와 서브쿼리의 salary를 비교한 후
-- salary > E.salary를 비교하니까 8000000원보다 큰게 있느냐? 없다. 그러니까 참이고
-- 8000000만원을 출력한 것. 최소값도 그 반대!
-- exists를 쓰는 이유는 1개의 행을 employee (같은 다른테이블의 모든행과 비교!)

-- ## 5. 스칼라서브쿼리
-- 결과값이 1개(단일행 , 단일컬럼)인 상관서브쿼리
-- select : 주로 select절 스칼라서브쿼리를 일컫음.
-- where
-- order by

-- 1. select
-- 모든 사원의 사번 , 이름 , 관리자사번 , 관리자명을 조회
select emp_id , 
        emp_name , 
        manager_id , 
        (select emp_name as "관리자명"
            from employee
            where emp_id = E.manager_id) as "관리자명"
from employee E;

select emp_name as "관리자명"
from employee
where emp_id = 201;

-- 2. where절
-- 사원이 속한 직급평균보다 많은 급여를 받은 사원 조회
select emp_id , emp_name , salary
from employee E
where salary > (select avg(salary)
                        from employee
                        where job_code = E.job_code);
                        
-- 3. order by절
-- 모든 직원의 사번 , 이름, 부서코드를 부서명순으로 조회
select emp_id , emp_name , dept_code , (select dept_title 
                                                            from department
                                                            where dept_id = E.dept_code) as "부서명"
from employee E
order by 부서명;
order by (select dept_title
                from department
                where dept_id = E.dept_code) asc;
-- 위아래 같은말! 그냥 보여줄려고 하신 것이라고 하셨다.

-- ## 6. 인라인뷰
-- from절에서 사용하는 서브쿼리를 인라인뷰(Inline view)라고한다.

-- view? : 실제 테이블에 근거한 논리적 가상테이블(result set)
-- 1. Inline view : 1회용
-- 2. stored view : db에 저장해서 영구적 사용가능.
-- view를 사용하면 복잡한 쿼리문을 가독성 좋게 만들 수 있다.

-- 여사원의 사번 , 사원명 , 부서코드 , 성별을 출력
select emp_id , 
        emp_no ,
        emp_name ,
        dept_code ,
        decode(substr(emp_no,8,1),'1','남','3','남','여') as "성별"
from employee
where decode(substr(emp_no,8,1),'1','남','3','남','여') = '여';

-- inline view
-- ★주의 서브쿼리에서 alias를 달아주었다면 메인쿼리에서 반드시 alias로 접근해야 한다.
-- 인라인뷰에 없는 칼럼 ex) salary를 메인쿼리에 써준다면 에러발생
select emp_id , emp_no , emp_name , dept_code , 성별
from(
select emp_id , 
        emp_no ,
        emp_name ,
        dept_code ,
        decode(substr(emp_no,8,1),'1','남','3','남','여') as "성별"
from employee)
where 성별 = '여';

-- 1. 1990년대에 입사한 사원을 조회
-- 사번 , 사원명 , 입사년도
select *
from(
select emp_id as "사번" ,
        emp_name as "사원명" ,
       extract(year from hire_date) as "입사년도"
from employee)
where 입사년도 like '199%';

-- 2. 사원명 , 부서명 , 급여 , 부서별 평균임금을 스칼라 서브쿼리를 이용해서 출력.
select emp_name as "사원명" ,
        (select dept_title 
            from department
            where dept_id = E.dept_code) as "부서명" ,
        salary ,
        (select round(avg(salary))
            from employee
            where dept_code = E.dept_code) as "평균임금"
from employee E;


-- 3. 직급이 J1을 제외하고 , 부서를 지정받은 사원중에서
-- 자신의 부서별 평균급여보다 적은 급여를 받는 사원출력.
-- 부서코드 , 사원명 , 급여 , 부서별 급여평균
select * from employee;

select dept_code as "부서코드" , 
        emp_name as "사원명" ,
        (select dept_title 
            from department
            where dept_id = E.dept_code) as "부서명" ,
        salary ,
        (select round(avg(salary))
            from employee
            where dept_code = E.dept_code) as "평균임금"
from employee E
where job_code != 'J1' and dept_code is not null;

-- 4. employee테이블에서 사원중 30대 40대 여자사원의
-- 사번 , 부서명 , 성별 , 나이를 출력하시오. (인라인뷰 사용)
select 사번 , nvl(부서명,'인턴') , 성별 , 나이
from(
select emp_id as "사번" ,
         (select dept_title 
            from department
            where dept_id = E.dept_code) as "부서명" ,
        decode(substr(emp_no,8,1),'1','남','3','남','여') as "성별" ,
        extract(year from sysdate) - (to_number(substr(emp_no,1,2)) + case when substr(emp_no,8,1) in ('1','2') then 1900 else 2000 end) + 1 as "나이"
from employee E)
where 나이 between 30 and 49 and 성별 = '여';


-----------------------------------------------
--## 고급쿼리
-----------------------------------------------
--1. Top-N 분석/질의
--가장 큰 n개의 값, 가장 작은 n개의 값을 요청할 때 사용.

--rowid, rownum
--데이터가 생성되면서 자동으로 제공된다. 
--rowid : 테이블의 특정레코드에 접근할 수 있는 논리적인 주소값.
--rownum : 각행에 대한 일련번호. 오라클이 내부적으로 부여함.
--          insert문 실행시 순서에 따라 1씩 증가하면서 값이 지정됨.
--          데이터가 입력된 시점에 결정된 rownum은 변경불가

select rownum, 
      rowid,
      employee.*
from employee
order by emp_name;

--top-n : 고연봉자 5명을 조회.

select rownum new_rnum, E.*--인라인뷰에 새로 부여된 rownum
from(
    select rownum old_rnum, emp_name, salary--employee테이블에 최초부여된 rownum
    from employee
    order by salary desc) E
where rownum < 6;

--where절에 특정조건을 제시하면, resultset에 포함되는 행이 달라지고,
--rownum도 새로 부여받는다.
select rownum, e.*
from employee e
where dept_code = 'D5';

--@실습문제 : 부서별 급여평균 top3
--부서코드, 부서명, 평균급여

select rownum 순위, SalByDeptDesc.*
from (
    select dept_code, 
          dept_title, 
          to_char(avg(salary), 'fml999,999,999') 평균급여 
    from employee E 
        left join department D--left join : 부서지정이 안된 사원포함 
        on E.dept_code = D.dept_id
    group by dept_code, dept_title
    order by 평균급여 desc) SalByDeptDesc
where rownum <= 3;

--사원급여랭킹 Top-5
select rownum, E.*
from (
select emp_name, salary
from employee
order by salary desc) E
where rownum < 6;

--사원급여랭킹 6위~10위
--rownum은 from, where절이후에 부여가 끝난다.
--같은 레벨의 where절에서 접근할 수 있는 건 1부터 접근한 경우만 가능.
--그렇지 않은 경우에는 inline-view레벨을 하나더 추가해야한다.
select *
from (
    select rownum rnum, E.*
    from (
        select emp_name, salary
        from employee
        order by salary desc) E )
where rnum between 6 and 10;

--부서별 급여평균 Top4~Top6
select *
from(
select rownum 순위, SalByDeptDesc.*
from (
    select dept_code, 
          dept_title, 
          to_char(avg(salary), 'fml999,999,999') 평균급여 
    from employee E 
        left join department D--left join : 부서지정이 안된 사원포함 
        on E.dept_code = D.dept_id
    group by dept_code, dept_title
    order by 평균급여 desc) SalByDeptDesc)
where 순위 between 4 and 6;

--2. with절
--서브쿼리에 이름 붙여주고, 인라인뷰로 사용시 서브쿼리명으로 접근한다.
--중복을 제거하고, 가독성을 높힐 수 있다.

with topn_sal as (select emp_name, salary
                from employee
                order by salary desc)
select rownum, topn_sal.*
from topn_sal
where rownum <= 10;

--18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름, 학번 조회
--tb_class - tb_student - tb_grade

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_CLASS C
 JOIN TB_GRADE G USING (CLASS_NO)
 JOIN TB_STUDENT S USING (STUDENT_NO)
WHERE C.DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '국어국문학과')
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) >= ALL(
    SELECT AVG(POINT)
    FROM TB_CLASS C2
     JOIN TB_GRADE G2 USING (CLASS_NO)
     JOIN TB_STUDENT S2 USING (STUDENT_NO)
    WHERE C2.DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '국어국문학과')
    GROUP BY STUDENT_NO, STUDENT_NAME
);

select *
FROM TB_CLASS C
 JOIN TB_GRADE G USING (CLASS_NO)
 JOIN TB_STUDENT S USING (STUDENT_NO)
WHERE C.DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '국어국문학과');

--국어국문학과 학생들의 평점 -> top1
--국어국문학과 department_no
select * from tb_grade;--student한명당 여러건의 수업점수가 담겨있다.
select * from tb_student;

--학생들의 평점을 inline-view로 지정
--학생1명당 하나의 평점을 가진 가상테이블
with v_stdt_grade as(select student_no, avg(point) avg
                   from tb_grade G join tb_student S using(student_no)
                   group by student_no)
select *
from(
    select student_no, student_name
    from tb_student S
        join tb_department D using(department_no)
        join v_stdt_grade using(student_no)
    where D.department_name = '국어국문학과'
    order by avg desc)
where rownum = 1;


--3. 계층형쿼리 Hierarchical Query
--join을 통해서 수평적으로 기준컬럼을 연결하지 않고, 수직적인 관계를 만듬.
--조직도, 메뉴, 답글게시판 등 fractal구조의 표현에 적합하다.
--start with : 부모행(루트노드)를 지정
--connect by : 부모(prior)와 자식관계를 지정

--1.하향식
select level,--계층정보를 나타내는 가상컬럼.
      emp_id,
      emp_name,
      manager_id
from employee
start with emp_id = 200--최고조상 지정
connect by prior emp_id = manager_id --부모(prior)컬럼, 자식컬럼 관계를 지정
order by level;

select lpad(' ',(level-1)*5) || emp_name || '(' || emp_id || ')'
from employee
start with emp_id = 200--최고조상 지정
connect by prior emp_id = manager_id; --부모(prior)컬럼, 자식컬럼 관계를 지정

--2. 상향식
--윤은해 사원의 결재경로를 계층형쿼리로 표현

select level,
      emp_id,
      emp_name,
      manager_id
from employee
start with emp_name='윤은해'--루트행을 지정하는 절
connect by prior manager_id = emp_id
order by level;

--@실습문제 : menu예제
create table tb_menu(
    no number primary key,
    menu_name varchar2(100),
    parent_no number
);
--drop table tb_menu;
insert into tb_menu values(100, '주메뉴1', null);
insert into tb_menu values(200, '주메뉴2', null);
insert into tb_menu values(300, '주메뉴3', null);

insert into tb_menu values(1000, '서브메뉴A', 100);
insert into tb_menu values(2000, '서브메뉴B', 200);
insert into tb_menu values(3000, '서브메뉴C', 300);

insert into tb_menu values(1001, '상세메뉴A1', 1000);
insert into tb_menu values(1002, '상세메뉴A2', 1000);
insert into tb_menu values(1003, '상세메뉴A3', 1000);
insert into tb_menu values(2001, '상세메뉴B1', 2000);
insert into tb_menu values(3001, '상세메뉴C1', 3000);

select * from tb_menu;
commit;

select lpad(' ', (level-1)*5)||menu_name 메뉴
from tb_menu
start with parent_no is null --루트노드로 삼을 행을 지정함.
connect by prior no = parent_no
order siblings by menu_name desc;

--4. window함수
--행과 행간의 관계를 쉽게 정의하기 위한 오라클 내장함수
--1. 순위함수 (Rank Function)
--2. 집계함수 (Aggregate Function)
--3. 분석함수 (Analytic Fuction)

--window_function(ARGUMENTS) OVER ([PARTITION BY절][ORDER BY절][WINDOW절])

--1.순위함수
--rank() over(order by)
--특정컬럼 기준으로 rank를 부여함.

--회사연봉순위를 조회
--동일한 순위가 있다면, 순위+n만큼 증가해서 지속된다.
select emp_name,
      salary,
      rank() over(order by salary desc) "순위"
from employee;

--rank() over(partiton by)

select dept_code,
      emp_name,
      salary,
      rank() over(order by salary desc) "급여 전체순위",
      rank() over(partition by dept_code order by salary desc) "부서별 급여순위"
from employee
order by dept_code, salary desc;

--@실습문제 
--사원명, 입사일, 입사일 순위 조회

select emp_name,
      hire_date,
      rank() over(order by hire_date) "입사일 순위"
from employee;

--부서별로 입사일일 빠른순서를 조회하세요.
--부서명, 사원명, 입사일, 부서별 입사순서

select dept_title,
      emp_name,
      hire_date,
      rank() over(partition by dept_code order by hire_date) 입사순서
from employee left join department
    on dept_code = dept_id;

--dense_rank() over()
select emp_name,
      hire_date,
      rank() over(order by hire_date) "입사일 순위",
      dense_rank() over(order by hire_date) "입사일 순위(dense)"
from employee;

--@실습문제 : 기본급여 순위가 1등부터 10등까지 조회
--(rownum이 아닌 윈도우함수 사용)

select rank() over(order by salary desc) 순위,
      emp_name,
      salary
from employee
where rank() over(order by salary desc) 순위 >= 10;--window함수는 select절에만 사용가능


select *
from(
select rank() over(order by salary desc) 순위,
      emp_name,
      salary
from employee)
where 순위 between 1 and 10;

--2.집계함수
--sum() over()
--사원명, 급여, 전체사원의 급여합계를 조회

select emp_name,
      salary,
      (select sum(salary) from employee) "급여합계"
from employee;

--윈도우함수 사용
select emp_name,
      salary,
      sum(salary) over() "급여합계"
from employee;

--부서별로 급여의 합계를 구한다. 
select dept_code,
      sum(salary) "부서별 급여합계"
from employee
group by dept_code;


select emp_name, 
      dept_code,
      salary,
      sum(salary) over(partition by dept_code) "부서별 급여합계",
      sum(salary) over(partition by dept_code order by salary) "부서별 급여누계",
      sum(salary) over() "전체급여합계"
from employee;

--avg() over()

select dept_code, 
      emp_name,
      salary,
      round(avg(salary) over(partition by dept_code)) "부서별 평균급여",
      round(avg(salary) over()) "전체평균급여"
from employee;

-----------------------------------------------
--## DML
-----------------------------------------------
--Data Manipulation Language
--CRUD - Data를 이용하려는 사용자와 
--Database서버사이의 인터페이스를 직접적으로 제공하는 언어
--C : insert
--R : select
--U : update
--D : delete

--1. insert
--새로운 행을 추가하는 명령어
--insert into 테이블명 values(col1값, col2값,....);
--insert into 테이블명(col1명, col2명,....) values(col1값, col2값,....);

--테스트용테이블 emp_test1생성
--서브쿼리를 이용한 테이블생성 : 테이블구조 및 데이터복사
create table emp_test1 as 
select * from employee;

select * from emp_test1;

--1.데이터추가 : 컬럼명 없이 추가
insert into emp_test1
values(301, '장채현', '901123-1080503', 'jang_ch@kh.or.kr', '01055554444',
      'D1', 'J8', 'S3', 4300000, 0.2, '200', sysdate, default, default);

--data_default컬럼에서 default값 확인가능
select *
from user_tab_cols
where table_name = 'EMPLOYEE';

--기록하기
commit;

--2.데이터추가 : 컬럼명 지정후 추가
insert into emp_test1 (emp_id, emp_name, emp_no, 
                    email, phone, dept_code, job_code, 
                    sal_level, salary, bonus, manager_id, 
                    hire_date, quit_date, quit_yn)
values(302, '함지민', '781020-2123453', 'hamham@kh.or.kr', '01012344443',
      'D1', 'J4', 'S3', 4300000, 0.2, '200', sysdate, default, default);

--컬럼명은 생략가능하다. 단 nullable, default값이 지정된 경우에 한해서 생략가능.
--컬럼지정순서도 자유롭다. 하지만, values절과 반드시 일치해야한다.

insert into emp_test1(emp_id, emp_name, emp_no, 
                    email, phone, dept_code, job_code, 
                    sal_level, salary, bonus, manager_id)
values(303, '잡채현', '901123-1080503', 'jab@kh.or.kr', '01055554444',
      'D1', 'J8', 'S3', 4300000, 0.2, '200');

select * from emp_test1;

--서브쿼리를 이용한 insert
create table emp_test2(
    emp_id number,
    emp_name varchar2(30),
    dept_title varchar2(20)
);

select emp_id, emp_name, dept_title
from employee left join department 
    on dept_code = dept_id;
    
--서브쿼리 대입
insert into emp_test2(
    select emp_id, emp_name, dept_title
    from employee left join department 
        on dept_code = dept_id
);

select * from emp_test2;
commit;

--2.update
--테이블에 이미 기록된 행에 대해서 컬럼의 값을 수정
--작업후 행의 개수에는 변화가 없다.
create table dept_copy as
select * from department;

--D9의 부서명을 총무부에서 전략기획팀으로 변경
select * from dept_copy;

--where조건절을 반드시 명시할 것.
update dept_copy set dept_title = '전략기획팀'
where dept_id = 'D9';

commit;

--서브쿼리를 이용한 update
--방명수사원의 급여와 보너스율을 유재식사원과 동일하게 변경
create table emp_salary as
select emp_id, emp_name, dept_code, job_code, salary, bonus
from employee;

select emp_name, salary, bonus
from emp_salary
where emp_name in ('유재식','방명수');

update emp_salary set salary=3400000, bonus=0.2
where emp_name = '방명수';
rollback;

--subquery1
update emp_salary
set salary = (select salary from emp_salary where emp_name = '유재식'), 
    bonus = (select bonus from emp_salary where emp_name = '유재식')
where emp_name = '방명수';

--subquery2
update emp_salary
set (salary, bonus) = (select salary, bonus from emp_salary where emp_name = '유재식')
where emp_name = '방명수';

select * from emp_salary
where emp_name in ('방명수','유재식');

--3. delete
--테이블의 행을 삭제
--where절을 반드시 사용해서, 회사에서 살아남자.
select * from emp_test1;

delete from emp_test1 where emp_name = '잡채현';

rollback;

--외래키
--부모자식관계의 테이블에서 참조되고 있는 부모테이블의 행은 삭제불가
delete from department where dept_id = 'D2';
--ORA-02292: integrity constraint (KH.FK_EMPLOYEE_DEPARTMENT) violated - child record found

--truncate로 테이블 행삭제하기
--dml이 아닌 ddl이다. 자동커밋되므로 사용시 주의할 것.

select * from dept_copy;
delete from dept_copy;--dml은 작업시 before image를 생성.
rollback;

--truncate의 처리속도가 빠르다. 
truncate table dept_copy;
rollback;

--dml / ddl 혼용시 주의할점
--dml은 comit/rollback TCL사용가능
--ddl은 autocommit되므로 TCL사용불가

create table tbl_test(
    id varchar2(20)
);
insert into tbl_test values('hello');
insert into tbl_test values('world');

select * from tbl_test;

--현재 데이터를 추가했고, commit하지 않았다.
create table tbl_other(
    no number
);

rollback;
--의도대로 데이터 롤백되지 않는다.
--DDL을 사용했으므로, 자동커밋되었다.

delete from tbl_test where id = 'world';
select * from tbl_test;
rollback;

drop table tbl_other;

-----------------------------------------------
--## DDL
-----------------------------------------------
--Data Definition Language 데이터정의언어
--데이터베이스객체에 대해서, 생성create, 수정alter, 삭제drop하는 명령어모음
--rollback/commit등의 TCL사용이 불가하다. 자동커밋된다.

--데이터베이스객체
--table
--user
--sequence : numbering을 담당
--index
--view : 가상테이블
--package
--procedure
--function
--trigger
--synonym

--1.create
create table member(
    member_id varchar2(20),
    member_pwd varchar2(20),
    member_name varchar2(20)
);

--주석
--테이블/컬럼 등에 주석을 다는 습관을 들이자.
--DD : dba_, all_, user_ 객체에 대한 메타정보를 가지고 있는 테이블
select *
from user_tab_comments
where table_name = 'EMPLOYEE';

select *
from user_col_comments
where table_name = 'EMPLOYEE';

--1. 테이블주석달기
comment on table member is '회원관리테이블';

select *
from user_tab_comments
where table_name =  'MEMBER';

--2. 컬럼주석달기

comment on column member.member_id is '회원아이디';
comment on column member.member_pwd is '회원비밀번호';
comment on column member.member_name is '회원이름';

select *
from user_col_comments
where table_name = 'MEMBER';

--수정/삭제는 동일한 명령어
comment on column member.member_name is '';

--##제약조건 (Constraints)
--데이터무결성을 지키기 위해 컬럼단위로 제한된 조건
--무결성(intergrity) : 데이터의 정합성, 일관성이 유지 되는 것.
/*
1. NOT NULL : 데이터에 null을 허용하지 않는것 -> 필수항목(컬럼)
2. UNIQUE : 중복된 값을 허용하지 않음 -> 주민등록번호, 이메일
3. PRIMARY KEY (기본키) : 레코드의 고유식별자로 사용. unique + not null ->  ID
4. FOREIGN KEY (외래키) : 두 테이블간 데이터를 연결하여 설정.
                       외래키테이블에 올수 있는 데이터를 제한함.
5. CHECK : 저장가능한 데이터의 값의 조건, 범위를 설정 -> 성별, 기혼여부(0,1), 삭제여부

*/

--제약조건 정보 확인
--user_contraints
--user_cons_columns

select *
from user_constraints
where table_name = 'EMPLOYEE';--컬럼명이 나오지 않음

select *
from user_cons_columns
where table_name ='EMPLOYEE';

--제약조건 조회
select constraint_name, UC.owner, UC.table_name, UC.constraint_type, UC.search_condition
from user_constraints UC join user_cons_columns UCC using (constraint_name)
where UC.table_name = 'EMPLOYEE';

--1. not null
--필수항목인 컬럼에 추가하는 제약조건

--제약조건이 없는 막장테이블
create table user_nocons(
    user_no number,
    user_id varchar2(20),
    user_pwd varchar2(30),
    user_name varchar2(30),
    gender char(3),
    phone char(13),
    email varchar2(50)
);

--데이터추가
insert into user_nocons 
values(1,'user01', 'p1234','홍길동','남','010-1234-5678','honggd@kh.or.kr');

insert into user_nocons
values(2,null,null,null,null,'010-4444-4444','hong4444@kh.or.kr');

insert into user_nocons (user_no, phone)
values(3,'010-3333-3333');

select * from user_nocons;
--필수정보가 누락되는 버그발생

--not null제약조건 추가
create table user_notnull(
    user_no number constraint nn_user_notnull_user_no not null,
    user_id varchar2(20) constraint nn_user_notnull_user_id not null,
    user_pwd varchar2(30) constraint nn_user_notnull_pwd not null,
    user_name varchar2(30) constraint nn_user_notnull_name not null,
    gender char(3) default '여',
    phone char(13),
    email varchar2(50)
);

drop table user_notnull;

insert into user_notnull
values(1,'user01', 'p1234','홍길동','남','010-1234-5678','honggd@kh.or.kr');
insert into user_notnull
values(2,null,null,null,null,'010-4444-4444','hong4444@kh.or.kr');
insert into user_notnull (user_no, phone)
values(3,'010-3333-3333');

insert into user_notnull
values(1,'user01', 'p1234','홍길순', default,'010-1234-5678','honggd@kh.or.kr');

--제약조건 조회
select constraint_name, UC.owner, UC.table_name, UCC.column_name, UC.constraint_type, UC.search_condition
from user_constraints UC join user_cons_columns UCC using (constraint_name)
where UC.table_name = 'USER_NOTNULL';

--2. unique
--컬럼 입력값에 대해서 중복을 제한하는 제약조건

insert into user_nocons 
values(1,'user01', 'p1234','홍길동','남','010-1234-5678','honggd@kh.or.kr');
    
select * from user_nocons;
--1.컬럼레벨
create table user_unique(
    user_no number not null,
    user_id varchar2(20) constraint uq_user_unique_user_id unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30) not null,
    gender char(3) default '남',
    phone char(13),
    email varchar2(50)
);
drop table user_unique;

--2.테이블레벨
create table user_unique(
    user_no number not null,
    user_id varchar2(20) not null,
    user_pwd varchar2(30) not null,
    user_name varchar2(30) not null,
    gender char(3) default '남',
    phone char(13),
    email varchar2(50),
    constraint uq_user_unique_user_id unique(user_id)
);

--데이터추가
insert into user_unique 
values(1,'user01', 'p1234','홍길동','남','010-1234-5678','honggd@kh.or.kr');
    
insert into user_unique
values(1,'user01', 'p1234','홍길동','남','010-1234-5678','honggd@kh.or.kr');
--ORA-00001: unique constraint (KH.UQ_USER_UNIQUE_USER_ID) violated    

--unique제약조건이 걸린 컬럼에 null데이터추가
--dbms별로 처리방식이 따라 다르다.
--oracle, mysql -> null데이터 중복입력이 가능
--mssql -> null데이터 중복입력이 불가
insert into user_unique
values(1,null, 'p1234','홍길동','남','010-1234-5678','honggd@kh.or.kr');

select * from user_unique;

--3. primary key
--not null + unique 기능을 한지만, 테이블당 한개만 선언가능하다.
--테이블에서 한행의 정보를 구분하기 위한 고유식별자(identifier) 역할을 하기 위해.
create table user_primarykey(
    user_no number not null,
    user_id varchar2(20) constraint pk_user_primarykey_user_id primary key,
    user_pwd varchar2(30) not null,
    user_name varchar2(30) not null,
    gender char(3) default '남',
    phone char(13),
    email varchar2(50)
);

drop table user_primarykey;

create table user_primarykey(
    user_no number not null,
    user_id varchar2(20),
    user_pwd varchar2(30) not null,
    user_name varchar2(30) not null,
    gender char(3) default '남',
    phone char(13),
    email varchar2(50),
    constraint pk_user_primarykey_user_id primary key(user_id)
);

--제약조건 조회
select constraint_name, UC.owner, UC.table_name, UCC.column_name, UC.constraint_type, UC.search_condition
from user_constraints UC join user_cons_columns UCC using (constraint_name)
where UC.table_name = 'EMPLOYEE';

--primary key는 단일컬럼에 대해서 부여하는 single primary key
--여러 컬럼을 묶어서 부여하는 composite primary key
--주문테이블 : 상품번호, 주문자아이디, 주문일자, 주문수량
create table tbl_order_composite_pk(
    product_no varchar2(20),
    user_id varchar2(20),
    order_date date,
    order_num number, --주문수량
    constraint pk_tbl_order primary key(product_no, user_id, order_date)
);
insert into tbl_order_composite_pk
values ('p123','u123',sysdate,10);

select * from tbl_order_composite_pk;

--4. foreign key
--참조 무결성을 유지하기 위한 제약조건
--참조하는 컬럼(자식)과 참조되는 컬럼(부모)간의 부모자식테이블관계를 형성

select * from department;
select * from employee;
--제약조건 조회
select *
from user_constraints UC join user_cons_columns UCC using (constraint_name)
where UC.table_name = 'EMPLOYEE';

--shop_member
--shop_buy : shop_member.user_id컬럼값을 참조

create table shop_member(
    user_no number,
    user_id varchar2(20),
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10) default '남',
    phone varchar2(30),
    email varchar2(50),
    constraint pk_shop_member_user_id primary key(user_id),
    constraint uq_shop_member_user_no unique(user_no)
);

select *
from user_constraints UC join user_cons_columns UCC using (constraint_name)
where UC.table_name = 'SHOP_MEMBER';

insert into shop_member
values(1,'user01','1234','홍길동','남','010-1234-5678','honggd@kh.or.kr');
insert into shop_member
values(2,'user02','1234','이순신','남','010-1234-5678','lee@kh.or.kr');
insert into shop_member
values(3,'user03','1234','유관순','남','010-1234-5678','yoo@kh.or.kr');
insert into shop_member
values(4,'user04','1234','안중근','남','010-1234-5678','ahn@kh.or.kr');
insert into shop_member
values(5,'user05','1234','윤봉길','남','010-1234-5678','yoon@kh.or.kr');

select * from shop_member;
commit;

--회원이 물품을 구매했을때 기록하는 테이블
--shop_member.user_id를 참조하는 외래키를 설정
--1.컬럼레벨
create table shop_buy(
    buy_no number constraint pk_shop_buy_no primary key,
    user_id varchar2(20) constraint fk_shop_buy_user_id 
                       references shop_member(user_id),
    product_name varchar2(20),
    reg_date date
);
drop table shop_buy;
--2.테이블레벨
create table shop_buy(
    buy_no number constraint pk_shop_buy_no primary key,
    user_id varchar2(20),
    product_name varchar2(20),
    reg_date date,
    constraint fk_shop_buy_user_id foreign key(user_id)
                                references shop_member(user_id)
);
drop table shop_buy;

insert into shop_buy values(1,'user01','축구화',sysdate);
insert into shop_buy values(2,'user02','농구화',sysdate);
insert into shop_buy values(3,'user03','배구화',sysdate);
insert into shop_buy values(4,'kkkkk','축구화',sysdate);--ORA-02291: integrity constraint (KH.FK_SHOP_BUY_USER_ID) violated - parent key not found
insert into shop_buy values(5,null,'골프화',sysdate);--fk컬럼에 null값은 추가가능

select * from shop_buy;

delete from shop_member
where  user_id = 'user03';
--참조되고 있는 데이터는 삭제불가능하다.
--ORA-02292: integrity constraint (KH.FK_SHOP_BUY_USER_ID) violated - child record found
--자식테이블데이터 -> 부모테이블데이터 순으로 삭제

drop table shop_member; 
--ORA-02449: unique/primary keys in table referenced by foreign keys
--자식테이블삭제 -> 부모테이블삭제

--외래키 삭제 옵션
--on delete restricted : 기본값
--on delete set null : 부모데이터가 삭제된 자식데이터를 null로 변경
--on delete cascade : 부모데이터가 삭제되면 자식데이터도 삭제 

create table shop_buy_set_null(
    buy_no number constraint pk_shop_buy_set_null_no primary key,
    user_id varchar2(20),
    product_name varchar2(20),
    reg_date date,
    constraint fk_shop_buy_set_null_user_id foreign key(user_id)
                                references shop_member(user_id)
                                on delete set null
);
insert into shop_buy_set_null values(1,'user01','축구화',sysdate);
insert into shop_buy_set_null values(2,'user02','농구화',sysdate);
insert into shop_buy_set_null values(3,'user03','배구화',sysdate);

select * from shop_buy_set_null;

--부모데이터 삭제시도
delete from shop_member
where  user_id = 'user03';

--5.check
--컬럼 도메인의 값을 제한.
create table user_check(
    user_no number not null,
    user_id varchar2(20),
    user_pwd varchar2(30) not null,
    user_name varchar2(30) not null,
    gender char(3) default '남' constraint ck_user_check_gender 
                            check(gender in ('남','여')),
    phone char(13),
    email varchar2(50),
    constraint pk_user_check_user_id primary key(user_id)
);
drop table user_check;
create table user_check(
    user_no number not null,
    user_id varchar2(20),
    user_pwd varchar2(30) not null,
    user_name varchar2(30) not null,
    gender char(3) default '남' not null, --default절 이후에 not null추가
    phone char(13),
    email varchar2(50),
    constraint pk_user_check_user_id primary key(user_id),
    constraint ck_user_check_gender check(gender in ('남','여'))
);






--@실습문제
--테이블을 적절히 생성하고, 테이블, 컬럼주석을 추가하세요.
--
--1. 첫번째 테이블 명 : EX_MEMBER
--* MEMBER_CODE(NUMBER) - 기본키							-- 회원전용코드 
--* MEMBER_ID (varchar2(20) ) - 중복금지						-- 회원 아이디
--* MEMBER_PWD (char(20)) - NULL 값 허용금지					-- 회원 비밀번호
--* MEMBER_NAME(varchar(30)) 							-- 회원 이름
--* MEMBER_ADDR (char(50)) - NULL값 허용금지					-- 회원 거주지
--* GENDER (varchar2(5)) - '남' 혹은 '여'로만 입력 가능				-- 성별
--* PHONE(varchar2(20)) - NULL 값 허용금지 					-- 회원 연락처
--2. EX_MEMBER_NICKNAME 테이블을 생성하자. (제약조건 이름 지정할것)
--* MEMBER_CODE(NUMBER) - 외래키(EX_MEMBER의 기본키를 참조),중복금지		-- 회원전용코드
--* MEMBER_NICKNAME(varchar(30)) 							-- 회원 이름


create table ex_member(
        member_code number constraint pk_ex_member_member_code primary key,
        member_id varchar2(20) constraint uq_ex_member_member_id unique,
        member_pwd varchar2(30) constraint nn_ex_member_member_pwd not null,
        member_name varchar(30) not null ,
        member_addr varchar2(50) constraint nn_ex_member_member_addr not null,
        gender char(3) default '남' constraint ck_ex_member_gender check(gender in ('남', '여')),
        phone char(13) constraint nn_ex_member_phone not null
);
drop table ex_member;

insert into ex_member values (1, 'user01', '1234', '홍길동', '서울 금천구 시흥', '남', '010-8830-2912');

select * from ex_member;

create table ex_member_nickname(
        member_code number constraint fk_ex_member_code
                                                     references ex_member(member_code)
                                                     on delete set null,
        member_nickname varchar2(30) not null
);

select constraint_name, UC.owner, UC.table_name, UCC.column_name, UC.constraint_type, UC.search_condition
from user_constraints UC join user_cons_columns UCC using (constraint_name)
where UC.table_name = 'EX_MEMBER_NICKNAME';

select * from ex_member_nickname;




--## alter
--테이블 등 데이터 베이스 객체의 정보를 수정 할 때 사용
--1. 컬럼/제약조건 : add, modify, rename, drop
--2. 테이블 : rename

--연습용 테이블 생성
create table tbl_alter(
       user_no number primary key,
       user_id varchar2(20),
       user_pwd char(20)
);

desc tbl_alter;

--####1. 컬럼/제약조건
--1. add 컬럼
alter table tbl_alter add user_name varchar2(20);
--컬럼 default 값 추가
alter table tbl_alter add user_age number default 0;
--제약조건 추가
alter table tbl_alter add user_gender char(3) default '남'
                                                   check(user_gender in ('남','여'));

--2. add 제약조건
alter table tbl_alter add constraint uq_tbl_alter_user_id unique(user_id);
--not null 제약조건은 추가가 아니라 변경!!!
--최초의 기본 값으로 nullable -> not null
alter table tbl_alter modify user_pwd not null;
desc tbl_alter;

--3. modify 컬럼
--데이터 타입, default값 변경이 가능
alter table tbl_alter modify user_name char(10);
alter table tbl_alter modify user_age default 20;

--4. modify 제약조건
--이런건 없음. 제약조건 삭제 후 다시 생성 할 것

--5. rename 컬럼
alter table tbl_alter rename column user_pwd to password;
desc tbl_alter;

--6. rename 제약조건 명
--제약조건 조회
select constraint_name, UC.owner, UC.table_name, UCC.column_name, UC.constraint_type, UC.search_condition
from user_constraints UC join user_cons_columns UCC using(constraint_name)
where UC.table_name = 'TBL_ALTER';

alter table tbl_alter rename constraint SYS_C007140 to pk_tbl_alter;

--7. drop 컬럼
alter table tbl_alter drop column user_age;

--8. drop 제약조건
alter table tbl_alter drop constraint SYS_C007143;

--add 컬럼/제약조건
--modify 컬럼
--rename 컬럼/제약조건
--drop 컬럼/제약조건

--##2. 테이블
--테이블 명만 변경 가능
alter table tbl_alter rename to tbl_alter_after;
select * from tab; --user_tables : BIN은 삭제된 테이블

rename tbl_alter_after to tbl_alter;

--### drop
--데이터 베이스 객체 삭제 시 사용

--자식 테이블에서 외래키로써 부모테이블의 기본키를 참조하고 있을 때
--부모테이블을 삭제 할 수 있을까?
create table tbl_alter_child(
        parent_no number references tbl_alter(user_no)
);
--제약조건 조회
select *
from user_constraints UC join user_cons_columns UCC using(constraint_name)
where UC.table_name = 'TBL_ALTER_CHILD';
--부모테이블 삭제
drop table tbl_alter;--에러

--부모테이블 강제 삭제 옵션 : cascade constraint
drop table tbl_alter cascade constraint;--자식 테이블의 제약조건을 날려버림

-------------------------------------------------------
--## DCL
-------------------------------------------------------
--Data Control Language
--grant(권한 부여), revoke(권한 회수), commit(실행), rollback(복구) - 오른쪽 둘은 TCL로 구분하기도 함

--1. grant
--grant [SYSTEM_Privilege | role] to [user | role | PUBLIC] [WITH ADMIN OPTION]
--System_privilege : 권한 create session, create table......
--role : 권한 묶음 connect, resource, dba
--PUBLIC : 관리자가 모든 사용자가 사용 할 수 있도록 부여함
--WITH ADMIN OPTION : 권한을 부여받은 사용자도 이 권한을 다른 사용자에게 부여가능

--qwerty 사용자를 생성해서 관리
--관리자 계정에서 사용자 생성
create user qwerty identified by qwerty
default tablespace users;

select * from dba_users;

grant create session to qwerty;
grant connect to qwerty;

--(관리자 계정)사용자에게 부여된 권한/role 조회
select * from dba_sys_privs
where grantee = 'qwerty';

select * from dba_role_privs
where grantee = 'qwerty';

--일반 사용자가 본인의 권한/role조회
select * from user_sys_privs;

select * from user_role_privs;

--qwerty에게 테이블 생성 권한 create table
--resource라는 role 부여 : 여러 권한 포함
grant resource to qwerty;

--role에 포함된 권한 조회하기
select *
from dba_sys_privs
where grantee in ('CONNECT', 'RESOURCE');

--특정 테이블에 대한 권한 부여
--kh 계정의 테이블에 대한 권한을 kh가 qwerty에게 부여
create table tbl_coffee(
       pname varchar2(20) primary key,
       price number not null,
       company varchar2(20) not null
);
insert into tbl_coffee values('맥심커피', 30000,'동서식품');
insert into tbl_coffee values('카누커피', 50000,'동서식품');
insert into tbl_coffee values('네스카페커피', 40000,'네슬레');

commit;

select * from tbl_coffee;
--tbl_coffee 테이블을 qwerty에게 권한 부여
grant select on kh.tbl_coffee to qwerty;
grant insert, update, delete on kh.tbl_coffee to qwerty;
grant all on kh.tbl_coffee to qwerty;--select insert update delete
--qwerty에서 데이터 삽입 후 commit을 해야 kh에서도 볼 수 있음

--2. revoke
--사용자(또는 role)로부터 권한 회수
revoke insert on kh.tbl_coffee from qwerty;
revoke all on kh.tbl_coffee from qwerty;

-------------------------------------------------------
--## Database Object
-------------------------------------------------------



-------------------------------------------------------
--## DD Data Dictionary
-------------------------------------------------------
--자원(데이터베이스 객체)을 효율적으로 관리하기 위해서 다양한 메타정보를 담고 있는 테이블
--사용자가 DD에 직접적으로 작업하지 않음
--사용자가 테이블 등에 작업을 하게 되면 자동으로 DD에 반영됨
--사용자는 조회만 가능
select * from dictionary;
select * from dict;--dictionary의 동의어(synonym)으로 지정됨

select * from tab;
select * from user_tables;

--1. user_xxx : 자신의 계정이 소유한 객체 조회
--2. all_xxx    : 자신에게 부여받은 객체 조회
--3. dba_xxx  : 관리자가 조회하는 모든 객체 조회

select * from user_tables;
select * from all_tables;
select * from dba_tables;--권한이 없음

-------------------------------------------------------
--## View
-------------------------------------------------------
--stored view
--inline view(일회용)과 다르게 저장된 가상 테이블
--뷰를 사용해서 특정 사용자가 원본 테이블에 제한적을 접근 가능하게 만듦
--view를 생성하기 위해서는 권한을 부여 받아야 한다 resource 롤에 포함이 안됨
select * from view_emp;

create view view_emp as
select emp_id, emp_no, emp_name, phone, job_code, sal_level
from emp_test1;--ORA-01031: insufficient privileges

--관리자 계정에서 권한 부여
grant create view to kh;

--특정 사용자에게 뷰 권한 부여
grant select on view_emp to qwerty;

select * from emp_test1;

update emp_test1 set emp_name = '암지민' where emp_name = '함지민';
commit;

select * from view_emp;

--DD에서 조회
select *from user_views;/*
text:
"select emp_id, emp_no, emp_name, phone, job_code, sal_level
from emp_test1"*/
--가상테이블
select * from view_emp;
select * from (select emp_id, emp_no, emp_name, phone, job_code, sal_level
                   from emp_test1
);

--뷰 삭제
drop view view_emp;

--뷰 특징
--1. 실제 존재하는 컬럼뿐아니라 가상 컬럼(산술연산) 생성가능
create or replace view view_emp_salary as--객체가 존재한다면 갱신
select emp_name 사원명,
        (salary+(salary*nvl(bonus,0)))*12 연봉
from emp_test1;

select * from view_emp_salary;
select * from user_views;

--2. join view
--사번, 사원명, 부서명, 직급명을 포함하는 view_emp_read 뷰 객체를 작성하세요
create view view_emp_read as
select emp_id 사번, emp_name 사원명, D.dept_title 부서명, J.job_name 직급명
from emp_test1 E left join department D on E.dept_code = D.dept_id
                        left join job J using(job_code);
drop view view_emp_read;

select * from view_emp;

--view의 DML
--생성된 뷰에 대해서 제한적으로 DML이 가능하다

insert into view_emp
values(401,'790405-1012333','강오동','01054548787','J4','S3');

select * from emp_test1;

update ;



--view에 DML이 불가능한 경우
--1. 뷰에 가상 컬럼이 포함된 경우, 가상 컬럼을 조작할 수 없다
--2. insert시 뷰에 포함되지 않은 컬럼중에 not null인 경우 추가 할 수 없다
--3. 산술표현식으로 처리된 경우. 연봉 -> salary, bonus 불가!
--4. distinct, group by 가 포함된 경우
--5. join view에서 FK로 연결되지 않은 경우

--view 옵션
--1. with check option
--where절 조건에 사용된 컬럼은 수정하지 못한다
create or replace view view_emp_d5 as
select emp_id, emp_name, salary, dept_code
from emp_test1
where dept_code = 'D5'
with check option;

--급여가 250만원 이상인 사원을 D2부서로 변경
update view_emp_d5
set dept_code = 'D2'
where salary >= 2500000;
--ORA-01402: view WITH CHECK OPTION where-clause violation

--2. with read only
create or replace view view_emp_d5 as
select emp_id, emp_name, salary, dept_code
from emp_test1
where dept_code = 'D5'
with read only;
--수정불가
update view_emp_d5
set salary = salary + 500000;--42399.0000 - "cannot perform a DML operation on a read-only view"

/*@실습문제
다음테이블을 우선 생성하고, 각각 제약조건을 추가하기
1. tbl_parent 테이블
 * id : number
 * name : varchar2(20), not null 제약 추가
2. tbl_child 테이블
 * parent_id : number

tbl_parent 제약조건 추가 : id컬럼 pk 지정, 제약조건명 : pk_tbl_parent_id
tbl_child 제약조건 추가 : parent_id컬럼 fk 지정, 제약조건명: fk_tbl_child_parent_id, tbl_parent의 id컬럼 참조.*/
create table tbl_parent(
       id number,
name varchar2(20)
);
alter table tbl_parent add constraint pk_tbl_parent_id primary key(id);
alter table tbl_parent modify name not null;

--drop table tbl_parent;
create table tbl_child(
       parent_id number
       --constraint fk_tbl_child_parent_id foreign key(parent_id) references tbl_parent(id)
);
alter table tbl_child add constraint fk_tbl_child_parent_id foreign key(parent_id) references tbl_parent(id);





------------------------------------------------------------------
--## SEQUENCE
------------------------------------------------------------------
--순차적으로 정수값을 자동으로 생성하는 객체. 채번기
/*
create sequence [시퀀스명]
[start with 숫자] -- 시작값. 기본값 1
[increment by 숫자] -- 증가치. 기본값 1
[maxvalue 숫자 | nomaxvalue] -- 최대값. 기본값은 nomaxvalue
[minvalue 숫자 | nominvalue] --  최소값. 기본값은 nominvalue
[cycle | nocycle] -- 순환여부. 기본값은 nocycle
[cache | nocache] -- 캐쉬여부. 기본값은 nocache
;
*/

create table tbl_sequence(
        no number primary key,
        name varchar2(20) not null,
        age number not null
);


--시퀀스객체생성
create sequence seq_tbl_sequence_no
start with 1
increment by 1
nominvalue
nomaxvalue
nocycle
nocache;

--데이터삽입 
--no 기본키 : 절대 중복되서는 안되는 고유식별키
insert into tbl_sequence values(seq_tbl_sequence_no.nextval, '홍길동', 20);
insert into tbl_sequence values(seq_tbl_sequence_no.nextval, '김말똥', 30);
insert into tbl_sequence values(seq_tbl_sequence_no.nextval, '강부자', 40);



select * from tbl_sequence;

--dd : user_sequences
select * from user_sequences;
--last_number컬럼이 다음 nextval요청시 부여받는 번호.



--curr_val : 현재번호 -> 마지막으로 발행된 번호
select seq_tbl_sequence_no.currval from dual;
--nextval호출시 시퀀스객체 1씩 증가
select seq_tbl_sequence_no.nextval from dual;

insert into tbl_sequence values(seq_tbl_sequence_no.nextval, '하춘화', 50);

select * from tbl_sequence;

--@실습문제
--고객이 상품주문시 사용할 테이블 tbl_order를 생성
/*
order_no number pk
user_id : 고객 아이디
product_id : 주문상품 아이디
product_cnt : 주문개수
order_date : 주문일자 default sysdate

order_no컬럼은 seq_order_no 시퀀스객체에서 채번할것.
--주문내역
kang 님이 swk 상품을 5개 주문했다.
gam 님이  gjk 상품을 20개 주문했다.
ring 님이 oring 상품을 30개 주문했다.
*/

create sequence seq_order_no
start with 1
increment by 1
nominvalue
nomaxvalue
nocycle
nocache;

drop sequence seq_order_no; 
create table tbl_order(
    order_no number,
    user_id varchar2(20) not null,
    product_id varchar2(20) not null,
    product_cnt number,
    order_date date default sysdate,
    constraint pk_tbl_order_order_no primary key(order_no)
--    constraint pk_tbl_order_number primary key(product_cnt, user_id, order_date)
);
drop table tbl_order;

insert into tbl_order values(seq_order_no.nextval, 'kang', 'swk',5,sysdate);

insert into tbl_order
values ('gam','gjk',20,sysdate);

insert into tbl_order
values ('ring','oring',30,sysdate);

select * from tbl_order;


--order_no : kh-20181024-1000 고유번호를 가질 수 있게 작성하기.
--tbl_order2
--채번은 매일 1000으로 reset된다. (start with 1000)
create sequence seq_order2_no
start with 1000
increment by 1
nominvalue
nomaxvalue
nocycle
nocache;

create table tbl_order2(
    order_no char(16),
    user_id varchar2(20) not null,
    product_id varchar2(20) not null,
    product_cnt number,
    order_date date default sysdate,
    constraint pk_tbl_order2_no primary key(order_no)
--    constraint pk_tbl_order_number primary key(product_cnt, user_id, order_date)
);


insert into tbl_order2 (order_no, user_id, product_id, product_cnt)
values(
        'kh-' || to_char(sysdate, 'yyyymmdd') || '-' || seq_order2_no.nextval ,
        'kang',
        'sek',
        5
);

select * from tbl_order2;

--------------------------------------------
--## INDEX
--------------------------------------------

--색인. 처리속도 향상을 위해서 컬럼에 대하여 생성하는 객체
--key=value
--key = 해당컬럼값
--value = 행이 저장된 주소값.
--단점 : 인덱스에 대한 추가저장공간이 필요, 인덱스 생성 시간이 소요.
--        데이터변경(insert/update/delete)가 자주 일어나는 컬럼에는 index생성시 역효과 있음.

--인덱스 사용시 주의 사항
--인덱스활용여부는 전적으로 Optimizer가 결정하지만,
--다음 경우는 index를 사용하지 않는다.
--1. 인덱스컬럼에 변형이 가해지는 경우 : nvl(dept_code, '인턴') = 'D5'
--2. null, not null 비교를 하는 경우
--3. not 비교검색하는 경우
--4. 인덱스컬럼의 데이터타입과 다른 경우
--5. Cost Based Optimizer의 실행계획에 따른 선택


/*
어떤 컬럼에 인덱스를 만들어야 될까?
선택도가 좋은 컬럼을 가지고 인덱스를 만들어야 한다.
고유한 값을 많이 가지는 컬럼이 선택도가 좋다고 할 수 있다.
- 선택도가 좋은 컬럼 : 주민번호 > 성명
- 선택도가 나쁜 컬럼 : 성별

효율적으로 인덱스를 사용하려면....
- where 절에 자주 사용되는 컬럼을 인덱스로 만들 것.
- 전체데이터에서 10%~15%에 해당하는 컬럼
- 조인시에 조건절로 사용되는 컬럼
- 데이터변경이 적은 컬럼
- 테이블의 데이터가 아주 많은 컬럼 (최소 20만건)

*/


--인덱스조회
--pk와 uq제약조건이 걸린 컬럼은 자동으로 인덱스 생성
select * from user_indexes
where table_name = 'EMPLOYEE';

select * from employee
where emp_id = 200; --pk컬럼을 통한 검색

select * from employee
where emp_no = '621225-1985634';

select * from employee
where emp_name = '송종기';


--인덱스
create index idx_emp_name on employee(emp_name);

--복합인덱스
--2개이상의 컬럼으로 이루어진 인덱스
--선행이 무엇이냐가 아주 중요하다.

create index idx_emp_name_dept_code on employee(emp_name, dept_code);

select * from employee
where emp_name = '박나라' and dept_code = 'D5';


----------------------------------------------------------
--# PL/SQL
----------------------------------------------------------
--Oracle's Procedural Language Extension to SQL
--오라클이 제공하는 절차적 언어 확장
--기존 sql에 변수, 조건문, 반복처리등을 지원

--종류
--1. 익명블럭 : 1회명
--2. 프로시져 : 특정작업처리를 위한 서브프로그램,
--                 단독을 실행하거나, 다른 프로시져를 호출해서 실행
--3. 함수 : 거의 프로시져와 유사하나 반드시 리턴값이 있다.

/*
구조

DECLARE(선택) : 선언부

BEGIN(필수) : 실행부

EXCEPTION(선택) : 예외처리부




END;(필수)
/ -> pl/sql블럭의 종료 및 실행

*/

--나의 첫 pl/sql : hello world

begin
        dbms_output.put_line('Hello World');
end;
/


--출력담당변수 수정
set serveroutput on;

--pl/sql

declare
        vid number;
begin
        select emp_id
        into vid --변수에 대입
        from employee
        where emp_name = '&emp_name'; --사용자로 부터 입력값 받기

        dbms_output.put_line('emp_id=' || vid);
exception
        when no_data_found then dbms_output.put_line('데이터가 없습니다.');        
end;
/

--/ 뒤에 주석 달지 말것. 컴파일 에러

--1. 변수선언

declare
        v_empno number(4);
        v_empname varchar2(10);
        test_num number := 50;
begin
        v_empno := 1010;
        v_empname := '강오동';
        dbms_output.put_line('사번        이름');
        dbms_output.put_line('------------------');
        dbms_output.put_line(v_empno || ' ' || v_empname);
        dbms_output.put_line('------------------');
        dbms_output.put_line('test_num =' || test_num);
end;
/

--참조변수 %type

declare
        vid employee.emp_id%type;
        vname employee.emp_name%type;
begin
        --주민번호를 입력받아서 emp_id, emp_name조회
        select emp_id, emp_name
        into vid, vname
        from employee
        where emp_no = '&emp_no';
        
        dbms_output.put_line('사번 : ' || vid);
        dbms_output.put_line('사원명 : ' || vname);
end;
/

select * from employee;

--참조변수 %rowtype


declare
        vemp employee%rowtype;
begin
        select *
        into vemp
        from employee
        where emp_name = '&emp_name';
        
        dbms_output.put_line('사번 : ' || vemp.emp_id);
        dbms_output.put_line('부서코드 : ' || vemp.dept_code);
        dbms_output.put_line('급여 : ' || vemp.salary);
end;
/


--@실습문제 : 사원명을 입력받아서 사번, 사원명, 직급명, 부서명을 출력하는
--pl/sql블럭을 작성하세요.

select * from employee;
select * from job;
select * from department;

declare
--        vemp employee%rowtype;
--        vjob job%rowtype;
--        vde department%rowtype;
        vemp_id employee.emp_id%type;
        vemp_name employee.emp_name%type;
        vjob_name job.job_name%type;
        vde_title department.dept_title%type;
begin
        select E.emp_id, E.emp_name, J.job_name, D.dept_title
        into vemp_id, vemp_name, vjob_name, vde_title
        from employee E 
                join department D on E.dept_code = D.dept_id
                join job J using(job_code)
        where emp_name = '&emp_name';
        
        
        dbms_output.put_line('사번 : ' || vemp_id);
        dbms_output.put_line('사원명 : ' || vemp_name);
        dbms_output.put_line('직급명 : ' || vjob_name);
        dbms_output.put_line('부서명 : ' || vde_title);
end;
/

--pl/sql에서 dml문도 실행가능

select * from member;

begin
        insert into member
        values('abc', '123@','김동현');
        --적용처리까지 함께 할 것.
        commit;
end;
/

rollback;

--### pl/sql 조건문
--1. if ~ then ~ end if문


begin
        if '&이름' = '김동현' then
                dbms_output.put_line('김동현님, 환영합니다.');
        end if;
end;
/

--2. if ~ then ~ else ~ end if문

begin
        if '&이름' = '김동현' then
                dbms_output.put_line('김동현님, 환영합니다.');
        else
                dbms_output.put_line('김동현님이 아닙니다.');
        end if;
end;
/

--3. if then elsif then end if
declare
        vno number;
begin
        vno := &number;
        
        if vno = 1 then
                dbms_output.put_line('1을 입력하셨습니다.');
        elsif vno = 2 then
                dbms_output.put_line('2을 입력하셨습니다.');    
        else
                dbms_output.put_line('딴거를 입력하셨습니다.');
        end if;
end;
/


--4. case when then

declare
        vinput number;
begin
        vinput := &input;
        
        case vinput
                when 1 then
                        dbms_output.put_line(111111);
                when 2 then
                        dbms_output.put_line(222222);
                else
                        dbms_output.put_line('딴걸 입력하셨습니다.');
        end case;
end;
/               

select * from employee;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
--사원 번호를 입력받아서 직급코드 J1이면 대표, J2면 임원진, 나머지는 일반사원으로 출력

declare
        vno number;
begin
        vno := &number;
        
        from employee
        where(
        if emp_id := vno and job_code := 'J1' then
                dbms_output.put_line('대표입니다.');
        elsif vno = 2 then
                dbms_output.put_line('임원진입니다.');    
        else
                dbms_output.put_line('일반 사원입니다.');
        end if;)
end;
/


-- ## 반복문
-- 1. 기본 반복문

/*
loop

end loop;
*/

declare
        no number := 1;
begin
        loop
                dbms_output.put_line(no);
                no := no + 1;
                
                --탈출조건문1
--                if no > 5 then
--                        exit;
--                end if;
                --탈출조건문2
                exit when no>5;
        end loop;
end;
/


--2. while loop
--조건식이 true인 동안만 반복문 실행
--별도의 exit절 필요없음.

declare
        num number := 1;
begin
        while num<=5 loop
                dbms_output.put_line(num);
                num := num+1;
        end loop;
end;
/



--@실습문제
--사용자로부터 2~9까지의 숫자를 입력받아 구구단을 출력하세요.


declare
        num number;
        no number := 0;
begin
        num := &구구단;
        

       while no<=9 and num between 2 and 9 loop
       no := no+1;
            --n이 짝수일 경우, 건너뜀
            continue when mod(no,2) = 0;
          dbms_output.put_line(num || '*' || no ||'='|| num*no);
        end loop;
       

end;
/



--3. for in loop
--별도의 증감식은 필요없음.
--reverse

begin
        for n in reverse 1..5 loop
                dbms_output.put_line(n);
        end loop;
end;
/


--@실습문제 : employee테이블에서 200번~210번 사원을 조회
--사번, 사원명, 이메일 출력
declare
      vemp employee%rowtype;
begin
        for n in 200..210 loop
       select * into vemp from employee where emp_id = n;
        
        dbms_output.put_line(vemp.emp_id || vemp.emp_name || vemp.email);
        
        end loop;
end;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
/

select *
from employee
where emp_id = '200';

--1. EMP_TEST1테이블에서 사번 마지막번호를 구한뒤, +1한 사번에 사용자로 부터 입력받은 
--이름, 주민번호, 전화번호, 직급코드, 급여등급를 등록하는 PL/SQL을 작성하세요
--(직급코드 : J5, 급여등급 : S5 고정)
select * from emp_test1;
declare
        vemp emp_test1%rowtype;
        v_name emp_test1%type;
        v_name_no emp_test1%type;
        v_phone emp_test1%type;
        v_dept_code emp_test1%type;
        v_sal_lever emp_test1%type;
begin
        select *
        into vemp
        from employee;
        
        v_name := &이름;
        v_name_no := &주민번호;
        v_phone := &전화번호;
        v_dept_code := &직급코드;
        v_sal_lever := &급여등급;
        
        insert into emp_test1 values(304, v_name,  v_name_no , 'janggg_ch@kh.or.kr', v_phone,
      v_dept_code, 'J8', v_sal_lever, 4300000, 0.2, '200', sysdate, default, default);
end;
/



--2. 사번을 입력 받은 후 다음 사원정보를 출력하세요.
--사번,이름,급여,급여등급
--
--	500만원 이상(그외) : A
--	400만원 ~ 499만원 : B
--	300만원 ~ 399만원 : C
--	200만원 ~ 299만원 : D
--	100만원 ~ 199만원 : E
--	0만원 ~ 99만원 : F
declare
        vemp emp_test1%rowtype;
        no number; 
begin
        no := &사번;
        
        select * into vemp from employee where emp_id = no;

        if vemp.salary >= 5000000 then
        dbms_output.put_line(vemp.emp_id ||' '||  vemp.emp_name ||' '|| vemp.salary ||' '|| 'A' );
        elsif vemp.salary between 4000000 and 4990000 then
        dbms_output.put_line(vemp.emp_id ||' '||  vemp.emp_name ||' '|| vemp.salary ||' '|| 'B' );
        elsif vemp.salary between 3000000 and 3990000 then
        dbms_output.put_line(vemp.emp_id ||' '||  vemp.emp_name ||' '|| vemp.salary ||' '|| 'C' );
        elsif vemp.salary between 2000000 and 2990000 then
        dbms_output.put_line(vemp.emp_id ||' '||  vemp.emp_name ||' '|| vemp.salary ||' '|| 'D' );
        elsif vemp.salary between 1000000 and 1990000 then
        dbms_output.put_line(vemp.emp_id ||' '||  vemp.emp_name ||' '|| vemp.salary ||' '|| 'E' );
        else 
        dbms_output.put_line(vemp.emp_id ||' '||  vemp.emp_name ||' '|| vemp.salary ||' '|| 'F' );
        end if;
end;
/
--3. 난수 1~10사이의 난수를 5개 출력하세요
--DBMS_RANDOM.VALUE(low,high) - DBMS_RANDOM패키지의 난수발생 함수사용 
--(low보다 크거나 같고, high보다 작은 범위의 난수발생)

SELECT CEIL(DBMS_RANDOM.VALUE(1, 10)) rand 
FROM DUAL
CONNECT BY LEVEL <= 5;



--4. TBL_NUMBER 테이블에 0~99사이의 난수를 10개 저장하고, 입력된 수의 합계를 콘솔에 출력하세요.
--TBL_NUMBER테이블은 숫자타입의 컬럼 NO, 날짜타입의 INPUT컬럼을 가지고 있음.
--kh 계정에서 TBL_NUMBER 테이블 생성
--	
--CREATE TABLE TBL_NUMBER(NO NUMBER(3), INPUT DATE DEFAULT SYSDATE);
select * from tbl_number;

CREATE TABLE TBL_NUMBER
(   NO NUMBER(3),
    INPUT DATE DEFAULT SYSDATE );
    
    
SELECT CEIL(DBMS_RANDOM.VALUE(0, 99)) rand 
FROM DUAL
CONNECT BY LEVEL <= 10;

--1.EMP_TEST1테이블에서 사번 마지막번호를 구한뒤, +1한 사번에 사용자로 부터 입력받은 
-- 이름, 주민번호, 전화번호, 직급코드(J5), 급여등급(S5)를 등록하는 PL/SQL을 작성하자.

declare
    last_num emp_test1.emp_id%type;
begin
    select max(emp_id)
    into last_num
    from emp_test1;
    
    --pl/sql의 dml문
    insert into emp_test1(emp_id, emp_name, emp_no, phone, job_code, sal_level) 
    values (last_num+1, '&emp_name','&emp_no','&phone','J5','S5');
end;
/

select * from emp_test1;

--2. 사번을 입력 받은 후 급여에 따라 등급을 나누어 출력하도록 하시오 
--그때 출력 값은 사번,이름,급여,급여등급을 출력하시오
--500만원 이상(그외) : A
--400만원 ~ 499만원 : B
--300만원 ~ 399만원 : C
--200만원 ~ 299만원 : D
--100만원 ~ 199만원 : E
--0만원 ~ 99만원 : F

SET SERVEROUTPUT ON
DECLARE             
  EMP_ID EMPLOYEE.EMP_ID%TYPE;
  EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
  SAL_GRADE VARCHAR2(2);
BEGIN 
    SELECT EMP_ID,EMP_NAME,SALARY
    INTO EMP_ID,EMP_NAME,SALARY
    FROM EMPLOYEE
    WHERE EMP_ID= &EMP_ID;
    
    SALARY := SALARY / 10000;
    IF SALARY BETWEEN 0 AND 99 THEN SAL_GRADE := 'F';
    ELSIF SALARY BETWEEN 100 AND 199 THEN SAL_GRADE := 'E';
    ELSIF SALARY BETWEEN 200 AND 299 THEN SAL_GRADE := 'D';
    ELSIF SALARY BETWEEN 300 AND 399 THEN SAL_GRADE := 'C';
    ELSIF SALARY BETWEEN 400 AND 499 THEN SAL_GRADE := 'B';
    ELSE SAL_GRADE := 'A';
    END IF;
              
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('급여등급 : ' || SAL_GRADE);
END;
/


--case
DECLARE
    E EMPLOYEE%ROWTYPE;
    V_SAL_GRADE CHAR(1);
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
        
    CASE TRUNC(E.SALARY/1000000)
        WHEN 0 THEN V_SAL_GRADE := 'F';
        WHEN 1 THEN V_SAL_GRADE := 'E';
        WHEN 2 THEN V_SAL_GRADE := 'D';
        WHEN 3 THEN V_SAL_GRADE := 'C';
        WHEN 4 THEN V_SAL_GRADE := 'B';
        ELSE V_SAL_GRADE := 'A';
    END CASE;
    
    --사원정보출력
    DBMS_OUTPUT.PUT_LINE('사번 : '||E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||E.SALARY);
    DBMS_OUTPUT.PUT_LINE('급여등급 : '||V_SAL_GRADE);
END;
/

--3.난수 1~10사이의 난수를 5개 출력해보자.
--DBMS_RANDOM.VALUE(low,high) - 난수발생 함수. low보다 크거나 같고, high보다 작은 범위의 난수발생.
DECLARE
    rnd_num number;
    n number := 0;
BEGIN
    loop
        N:= N+1;
        DBMS_OUTPUT.PUT_LINE(TRUNC(DBMS_RANDOM.VALUE(1,10)));
        
        exit when n>5;
    end loop;
END;
/



--4.TBL_NUMBER 테이블에 0~99사이의 난수를 10개 저장되게 하시오.
--(심화) 입력된 수의 합계를 출력.
--TBL_NUMBER테이블은 숫자타입의 컬럼 NO, 날짜타입의 INPUT컬럼을 가지고 있다.
--kh 계정에서 TBL_NUMBER 테이블 생성
CREATE TABLE TBL_NUMBER(NO NUMBER(3), INPUT DATE DEFAULT SYSDATE);


--insert문 실행.
DECLARE
    RND NUMBER;
    V_SUM NUMBER := 0;
BEGIN
    FOR N IN 1..10 LOOP
        RND := TRUNC(DBMS_RANDOM.VALUE(0,100));
        --DBMS_OUTPUT.PUT_LINE(RND);
        INSERT INTO TBL_NUMBER(NO) VALUES(RND);
        V_SUM := V_SUM + RND;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('합계 : '||V_SUM);
    COMMIT;
END;
/
--데이터확인
SELECT * FROM TBL_NUMBER;















-------------------------------------------------------
--# Database Object 2
-------------------------------------------------------

-------------------------------------------------------
--## Function
-------------------------------------------------------
--프로시져의 한 종류로 리턴값이 반드시 존재하는 객체
--Stored Function

/*
create function 함수명(매개변수명 자료형....)
        return 자료형 -- 세미콜론을 찍지 않는다.
is
        (지역변수 선언부);
begin
        (실행부);
end;
/

*/
--양모자 씌우기
--리턴절에 세미콜론 금지, 파라미터, 리턴절 데이터타입의 크기지정금지 -> 컴파일 에러
create or replace function myfunc(
        P_str varchar2
)
return varchar2
is
        result varchar2(1000); --리턴될 변수
begin
        dbms_output.put_line('p_str=' || p_str);
        result := 'd' || p_str || 'b';
        return result;
end;
/
--확인
--user_functions(X)
--user_procedures에서 object_type = 'FUNCTION'로 검색할것.
select *
from user_procedures
where object_type = 'FUNCTION';

--실행
--1. exec명령문 실행
var result varchar2;
exec :result := myfunc('김동현');
print result;
--2. 쿼리문에서 실행
select myfunc('&이름') 양모자
from dual;

--3. 익명블럭
begin
        dbms_output.put_line(myfunc('&이름'));
end;
/

--사번을 입력받아서 해당 사원의 연봉을 계산해서 리턴하는 저장함수 작성

create or replace function fn_bonus_calc(
        p_emp_id employee.emp_id%type
)
        return number
is
        v_salary number;
        v_bonus number;
        result number;
begin
        select salary, nvl(bonus,0)
        into v_salary, v_bonus
        from employee
        where emp_id = p_emp_id;
        
        --연봉 계산
        
        result := (v_salary+ (v_salary*v_bonus)) * 12;
        return result;
end;
/
--확인
select * from user_procedures where object_type = 'FUNCTION';

--실행

--1. plsql exec 명령어
var  annualPay number;
exec :annualPay := fn_bonus_calc('&emp_id');
print annualPay;

--2. select 

select emp_id 사번,
        emp_name 사원명,
        fn_bonus_calc(emp_id) 연봉
from employee;



--@실습문제 :
-- 주민번호를 입력받아서 성별을 리턴하는 저장함수 fn_get_gender를 생성하고,
--사번, 사원명, 성별을 조회하는 데 사용할 것.
select * from employee;

create or replace function fn_get_gender(
        v_emp_no employee.emp_no%type
)
        return varchar2
is
        result varchar2(1000);
        gender varchar2(1000);
begin

        select case when substr(emp_no,8,1)='1' then '남'
           when substr(emp_no,8,1)='3' then '남'
           else '여'
           end
        into gender
        from employee
        where emp_no = v_emp_no;
        
        --주민 번호 입력 받아서 성별 리턴
        result := gender;
        
        return result;
end;
/


--1. plsql exec 명령어
var  emp_gender varchar2;
exec :emp_gender := fn_get_gender('&emp_no');
print emp_gender;

--2. select 

select emp_id 사번,
        emp_name 사원명,
        fn_get_gender(emp_no) 성별
from employee
where emp_no = '&emp_no';

--2. 사원번호를 받아서 직급명을 리턴하는 저장함수 fn_get_job_name
select * from job;
select * from employee;

create or replace function fn_get_job_name(
        v_emp_id employee.emp_id%type
)
        return varchar2
is
        result varchar2(1000);
        j_name varchar2(1000);
begin

        select J.job_name
        into j_name
        from employee E 
            join job J using(job_code) 
        where E.emp_id = v_emp_id;
        
        --주민 번호 입력 받아서 성별 리턴
        result := j_name;
        
        return result;
end;
/

--1. plsql exec 명령어
var  j_name varchar2;
exec :j_name := fn_get_job_name('&emp_id');
print j_name;

--2. select 

select emp_id 사번,
        emp_name 사원명,
        fn_get_job_name(emp_id) 직급
from employee
where emp_id = '&emp_id';



---------------------------------------------------
--## PROCEDURE
---------------------------------------------------
--Stored Procedure
--함수와 달리 반환값이 없을수도 있다.
/*
create [or replace] procedure 프로시져명(
        매개변수명1 [IN | OUT] 자료형,
        매개변수명2 [IN | OUT] 자료형,
        ....
)
is
        변수선언부;
begin
        실행부;
end;
/
*/
--1. 매개변수 없는 프로시져
select * from emp_copy;
--emp_copy테이블의 모든 데이터를 삭제하는 프로시져
create or replace procedure proc_del_all_emp
is


begin
        delete from emp_copy;
        commit;
end;
/

--확인
select * from user_procedures;

--실행
exec proc_del_all_emp;
select * from emp_copy;
--2. 매개변수 있는 프로시져

insert into emp_copy
(select emp_id, emp_name, salary, dept_title, job_name
from employee
        left join department on dept_code = dept_id
        left join job using(job_code)
);

drop table emp_copy;

--emp_id를 입력받아서, emp_copy 테이블에서 제거하는 프로시져
create or replace procedure proc_del_emp(
        p_emp_id IN emp_copy.emp_id%type
)
is

begin
        delete from emp_copy
        where emp_id = p_emp_id;
        commit;
        dbms_output.put_line(p_emp_id || '번 사원을 삭제했습니다.');
end;
/

--실행
exec proc_del_emp('&emp_id');

select * from emp_copy
where emp_id = '201';

--매개변수 OUT
--사번을 입력받아서 사원명, 급여, 보너스를 OUT하는 프로시져
create or replace procedure proc_select_emp(
        p_emp_id IN employee.emp_id%type,
        p_emp_name OUT employee.emp_name%type,
        p_salary OUT employee.salary%type,
        p_bonus OUT employee.bonus%type
)
is
begin
        select emp_name, salary, nvl(bonus,0)
        into p_emp_name, p_salary, p_bonus
        from employee
        where emp_id = p_emp_id;
end;
/
drop procedure proc_select_emp;
--실행
--바인드변수 선언
var b_emp_name varchar2(30);
var b_salary number;
var b_bonus number;

--프로시져 호출
exec proc_select_emp('&emp_id', :b_emp_name, :b_salary, :b_bonus);

print b_emp_name;
print b_salary;
print b_bonus;

--exec명령후 바인드변수 자동출력
set autoprint on;


--프로시져를 활용예제 : UPSERT
--insert + update : 기존의 데이터가 존재하면, update, 존재하지 않으면 insert
--직급코드 관리
create table job_copy 
as
select * from job;

select * from job_copy;

--제약조건 조회
select constraint_name, UC.owner, UC.table_name, UCC.column_name, UC.constraint_type, UC.search_condition
from user_constraints UC join user_cons_columns UCC using (constraint_name)
where UC.table_name = 'JOB_COPY';

--제약조건 추가
--job_code : pk, job_name :not null
create table tbl_parent(
       id number,
name varchar2(20)
);
alter table job_copy add constraint pk_job_copy_job_code primary key(job_code);

alter table job_copy modify job_name not null;


--프로시져 생성
create or replace procedure proc_upsert_job_copy(
        p_job_code job_copy.job_code%type,
        p_job_name job_copy.job_name%type
        
)
is
        v_cnt number;
begin
        --0. null여부검사
        if p_job_name is null then
                dbms_output.put_line('ERROR : JOB_NAME컬럼에는 NULL을 대입불가');
                RETURN;
        end if;
        
        
        --1. 데이터가 존재하는지 확인
        select count(*)
        into v_cnt
        from job_copy
        where job_code = p_job_code;
        
        dbms_output.put_line('v_cnt =' || v_cnt);
        
        --2. inser or update
        if v_cnt = 1 then
               update job_copy set job_name = p_job_name where job_code = p_job_code;
        else
                insert into job_copy values(p_job_code, p_job_name);
        end if;
        commit;
        
--        insert into job_copy values(p_job_code, p_job_name);
--        commit;
end;
/

--실행
exec proc_upsert_job_copy('J8', '인턴');

select * from job_copy;

exec proc_upsert_job_copy('J9', '');


--ORA-00001: unique constraint (KH.PK_JOB_COPY_JOB_CODE) violated




--@실습문제
--1. 주민번호를 입력받아 나이를 리턴하는 저장함수 fn_get_age를 사용해서
--사번, 이름, 성별, 연봉, 나이를 조회
create or replace function fn_get_age(
        v_emp_no employee.emp_no%type
)
        return number
is
        result number;
begin

        select extract(year from sysdate)
      - (to_number(substr(emp_no,1,2))+
        case when substr(emp_no,8,1) in ('1','2') then 1900 
             else 2000 end) 
      +1
        into result
        from employee
        where emp_no = v_emp_no;
        
        return result;
end;
/

select emp_id 사번,
        emp_name 사원명,
        case when substr(emp_no,8,1) in ('1','3') then '남' else '여' end 성별,
        (salary+(salary*nvl(bonus,0)))*12 연봉,
        fn_get_age(emp_no) 나이
from employee
where emp_no = '&emp_no';
        
--2. 사원에게 특별상여금(보너스)를 지급하8려고 하는데, 입사일기준으로 차등 지급하려 한다.
-- 입사일기준 10년이상이면 150%, 3년이상 10년미만이면 125%, 3년미만이면 50%를 지급함.
-- 저장함수명 : FN_BONUS_CALC, FN_GET_WORKING_DAYS(HIRE_DATE)
-- 조회컬럼 : 사번, 사원명, 입사일, 근무기간(~년 ~개월), 보너스금액

create or replace function fn_get_working_days(
        v_emp_id employee.emp_id%type
)
        return varchar2
is
        result varchar2(1000);
begin

        select trunc(months_between(sysdate, hire_date)/12 )||'년' || mod(trunc(months_between(sysdate, hire_date)),12)||'개월'
        into result
        from employee
        where emp_id = v_emp_id;
        
        return result;
end;
/

create or replace function fn_bonus_calc(
        v_emp_id employee.emp_id%type,
        v_hire_date employee.hire_date%type
)
        return number
is
        result number;
begin

        if trunc(months_between(sysdate, v_hire_date)/12) >10 then
            select (salary * (150/100))
            into result
            from employee
            where emp_id = v_emp_id;
        elsif trunc(months_between(sysdate, v_hire_date)/12) between 3 and 10 then
            select (salary * (125/100))
            into result
            from employee
            where emp_id = v_emp_id;
        else
            select (salary * (50/100))
            into result
            from employee
            where emp_id = v_emp_id;
        end if;
        
        return result;
end;
/

select emp_id 사번,
        emp_name 사원명,
        hire_date 입사일,
        fn_get_working_days(emp_id) 근무기간,
        fn_bonus_calc(emp_id, hire_date) 보너스금액
from employee;






--3. 기존부서테이블의 DEPT_ID, DEPT_TITLE만 복제한 DEPT_COPY를 생성한다.
--DEPT_ID 컬럼 PK추가. DEPT_ID 컬럼 변경 CHAR(3)
--DEPT_COPY를 관리하는 프로시져 PROC_MAN_DEPT_COPY를 생성한다.
--첫번째 인자로 작동FLAG값 'UPSERT'/'DELETE'를 받는다.
--UPDATE시, 데이터가 존재하지 않으면 INSERT, 데이터가 존재하면 UPDATE
--DELETE시, 해당부서에 사원이 존재하는지(EMPLOYEE에서 FK로 참조하고있다고 가정)를 검사해서, 
--존재하면, 경고메세지와 함께 실행취소함. 그렇지 않으면,  삭제.
--프로시저의 매개변수에 기본값을 지정하면, 생략가능함(매개변수명 mode 자료형 := 값create table emp_copy as

--create table dept_copy as
--select dept_id, dept_title
--from department;

--alter table dept_copy add constraint pk_dept_copy_dept_id primary key(dept_id);
--alter table dept_copy modify dept_id char(3);
--
--select * from dept_copy;
--
--create or replace procedure dept_copy(
--        p_flag 
--        p_dept_id dept_copy.dept_id%type,
--        p_dept_title dept_copy.dept_id%type
--)






-------------------------
--##CURSOR
-------------------------
--sql문의 result set(결과집합)을 가리키는 참조변수(포인터)
--하나이상의 row에 대해서 순차적으로 접근할 수 있다.
--OPEN ~ FETCH ~ CLOSE
--커서 종류
--1. 암시적커서 : 모든 sql문이 실행됨과 동시에 암시적커서가 생성되서 처리됨
-- 커서에 직접적으로 접근할 수 없다. 속성으로 처리는 가능
set serveroutput on
declare 
        v_emp_id employee.emp_id%type;
        v_emp employee%rowtype;
begin
        v_emp_id := '&emp_id';
        --쿼리실행
        select *
        into v_emp
        from employee
        where emp_id = v_emp_id;
        
        --커서접근
        if sql%found then
                dbms_output.put_line(v_emp_id || '사원 : ' || v_emp.emp_name);
                dbms_output.put_line('검색된  row수 = ' || sql%rowcount);  
        end if;
exception
        when no_data_found then dbms_output.put_line('검색결과가 없습니다.');
end;
/
--커서솔성
--sql%rowcount : 최근실행된 sql문의 결과행을 리턴
--sql%found : open후 fetch된 행이 있으면 true, 없으면 false;
--sql%notfound : open후 fetch된 행이 있으면 false, 없으면 true;
declare
        
begin
        update emp_copy set emp_name = emp_name||'-------'
        where dept_title ='&부서명'; 
        
        
        dbms_output.put_line(sql%rowcount || '행이 업데이트 되었음.');
        commit;
end;
/
select * from emp_copy;
--2. 명시적커서
--쿼리 결과집합에 직접 접근해서 처리할 피룡가 있을경우 커서를 선언해서 사용한다.
--(선언부)CURSOR
--(실행부)OPEN 
--(실행부)FETCH 
--(실행부)CLOSE
create table emp_cursor
as
select *
from employee;
--커서 선언
--1. 파라미터 없는 커서
declare
        v_emp emp_cursor%rowtype;
        --커서선언
        cursor mycursor
        is
        select *
        from emp_cursor;
begin
        open mycursor;
        loop
            fetch mycursor into v_emp;
            exit when mycursor%notfound;
            
            dbms_output.put_line('사번 : ' || v_emp.emp_id);
            dbms_output.put_line('사원명 : ' || v_emp.emp_name);
            dbms_output.put_line('급여 : ' || v_emp.salary);
            dbms_output.put_line('----------------------------------');
        end loop;
        close mycursor;
end;
/
--2. 파라미터 있는 커서
declare
        cursor myc(p_dept_code emp_cursor.dept_code%type)
        is
        select * from emp_cursor
        where dept_code = p_dept_code;
        
        --커서에서 fetch된 행을 담아둘 행변수
        v_emp emp_cursor%rowtype;
        --사용자 입력 부서코드를 담아둘 변수
        v_dept_code emp_cursor.dept_code%type;
begin
        v_dept_code := '&dept_code';
        
        open myc(v_dept_code);
        loop fetch myc into v_emp;
            exit when myc%notfound;--무한반복되지 않게 막아주는 코드
        dbms_output.put_line('사번 : ' || v_emp.emp_id);
        dbms_output.put_line('사원명 : ' || v_emp.emp_name);
        dbms_output.put_line('급여 : ' || v_emp.salary);
        dbms_output.put_line('----------------------------------');
        
        
        end loop;
        close myc;
end;
/
select* from employee;
--컬럼단위처리
declare
        cursor cs(p_dept_code emp_cursor.dept_code%type)
        is
        select emp_name, salary
        from emp_cursor
        where dept_code = p_dept_code;
        
        v_emp_name emp_cursor.emp_name%type;
        v_salary emp_cursor.salary%type;
begin
        open cs('&dept_code');
        loop fetch cs into v_emp_name, v_salary;
            exit when cs%notfound;
            dbms_output.put_line(v_emp_name || ', ' || v_salary);
        end loop;
        close cs;
end;
/
select * from emp_cursor;
--@실습문제 복습!
--직급명을 입력받고, 해당직급의 사원아이디, 사원명, 급여, 직급명을 출력하는 프로시져
--proc_emp_job
--커서명 :  cs_job
select * from job;
select * from emp_cursor;
create or replace procedure proc_emp_job(
    p_job_name job.job_name%type
)
is
   cursor cs_job(p_job_code job.job_name%type)
        is
        select emp_id, emp_name, salary, job_name
        
        from emp_cursor E join job J
        on E.job_code = J.job_code
        where job_name = p_job_name;
        
        v_emp_id emp_cursor.emp_id%type;
        v_emp_name emp_cursor.emp_name%type;
        v_salary emp_cursor.salary%type;
        v_job_name job.job_name%type;
        
begin
         open cs_job(p_job_name);
        loop fetch cs_job into v_emp_id,v_emp_name, v_salary,v_job_name;
            exit when cs_job%notfound;
            dbms_output.put_line(v_emp_id || ', ' || v_emp_name || ', ' || v_salary || ',' || v_job_name);
        end loop;
        close cs_job;
end;
/
exec proc_emp_job('&직급명');
--커서계의 혁명 : FOR IN LOOP
--FOR IN문이 OPEN FETCH CLOSE를 자동으로 해줌
/*
기존 for in 문
for 인덱스 변수 in 1....n loop
end loop;
커서 for in문
for 레코드변수 in 커서명(매개변수) loop
end loop;
레코드변수는 커서의 rowtype을 반영함.
레코드변수. 컬럼1식으로 사용할 수 있다.
*/
--특정부서사원만 출력
declare
        cursor cs_emp(p_dept_code employee.dept_code%type)
        is
        select emp_id, emp_name, nvl(dept_code,'인턴') my_dept_code
        from employee
        where dept_code = p_dept_code;
begin
        for v_emp in cs_emp('D5') loop
                dbms_output.put_line(v_emp.emp_id || ', ' || v_emp.emp_name);
        end loop;
end;
/
select * from location;
select * from employee;
select * from job;
select * from department;
--@실습문제
--부서명를 사용자한테 입력받고 해당부서의 모든 사원을 출력
-- 프로시저명 : proc_emp_dept
--사번 사원명 부서명 지점위치
create or replace procedure proc_emp_dept(
    p_dept_title department.dept_title%type
)
is
    cursor cs_department(p_dept_title department.dept_title%type)
    is
    select E.emp_id,E.emp_name, D.dept_title,L.national_code
    from employee E join department D
    on E.dept_code = D.dept_id
    join location L
    on D.location_id = L.local_code
    where dept_title = p_dept_title;
    
    
begin 
        for v_emp in cs_department(p_dept_title) loop
                dbms_output.put_line(v_emp.emp_id || ', ' || v_emp.emp_name || ', '|| v_emp.dept_title ||', '|| v_emp.national_code);
        end loop;
end;
/
exec proc_emp_dept('&부서명');


--------------------------------------------------
--## TRIGGER
--------------------------------------------------
--방아쇠, 연쇄반응
--특정이벤트, DDL, DML문이 실행되었을때,
--자동으로 어떤동작이 수행되도록 처리하는 객체.

--트리거종류
--1. dml trigger
--2. ddl trigger
--3. logon/logoff trigger

--회원테이블에 탈퇴가 발생하면, 탈퇴회원테이블에 추가하기.
--데이터변경이 있을때, 수정내역을 로그테이블에 추가하기


/*
create or replace trigger 트리거명
        before | after
        update or delete or insert on 테이블명
        [for each row] --> 행단위, 문장단위 옵션
begin
        (해당테이블에 dml을 실행시 처리로직)
end;
/

*/

create or replace trigger trg_emp_new
        after
        insert on emp_test1
        for each row
begin
        dbms_output.put_line('신입사원이 입사했습니다.');
end;
/

select * from emp_test1;
--신입사원 insert
insert into emp_test1
values('401', '길성춘', '690512-1111222', 'gil@kh.or.kr' , '01012345678', 'D5', 'J3', 'S5', 3000000, 0.1, 200, sysdate, null, default);
commit;



--급여변경 트리거
select * from emp_salary;

create or replace trigger trg_emp_sal
        after
        update on emp_salary
        for each row
begin
        --가상컬럼 :old, :new로부터 처리데이터 접근
        dbms_output.put_line('변경전 : ' || :old.salary );
        dbms_output.put_line('변경후 : ' || :new.salary );
end;
/

update emp_salary set salary = salary+500000
where emp_id = '205';

commit;

--화면출력버그
--alter trigger 트리거명 compile;

--로그내역
select * from user_constraints
where table_name = 'EMP_SALARY';

alter table emp_salary add constraint pk_emp_salary_emp_id
                                    primary key(emp_id);

--로그테이블생성
create table emp_salary_log(
        emp_id varchar2(3),
        salary number not null,
        log_date date default sysdate not null,
        constraint fk_emp_id foreign key(emp_id)
                                    references emp_salary(emp_id)
);



create or replace trigger trg_emp_sal
        after
        update on emp_salary
        for each row
begin
        --가상컬럼 :old, :new로부터 처리데이터 접근
        dbms_output.put_line('변경전 : ' || :old.salary );
        dbms_output.put_line('변경후 : ' || :new.salary );
        
        insert into emp_salary_log(emp_id, salary)
        values(:new.emp_id, :new.salary);
        
        --trigger안에는 commit문을 작성하지 않는다.
        --트리거 트랜잭션은 어차피 원 dml문과 함께 한다.
        --commit;
end;
/

--가상컬럼
--insert 트리거 : old = null, new = 새로 추가된 데이터
--update 트리거 : old = 수정전, new = 수정후
--delete 트리거 : old = 삭제전 데이터, new = null

update emp_salary set salary = salary+500000
where emp_id = '205';

commit;



select * from emp_salary
where emp_id = '205';


select * from emp_salary_log;

update emp_salary set salary = salary+500000
where emp_id = '205';

rollback;
commit;


--제품입출고
--product(상품관리-재고), product_io(입출고)

create table product(
        pcode number primary key,
        pname varchar2(30),
        brand varchar2(30),
        price number,
        stock number
);

create table product_io(
        iocode number primary key,
        pcode number, --제품번호(pk)
        pdate date,         --입출고일
        amount number, --수량
        status varchar2(10) check(status in ('IN','OUT')),
        constraint fk_product_io foreign key(pcode)
                                        references product(pcode)
);
drop table product_id;

create sequence seq_product;
create sequence seq_product_io;
                                       

--제품데이터입력
insert into product
values(seq_product.nextval, '갤럭시노트', '삼성', 1000000, 0);
insert into product
values(seq_product.nextval, '아이폰X', '애플', 1100000, 0);
insert into product
values(seq_product.nextval, '샤오미폰', '샤오미', 600000, 0);

select * from product;
select * from product_io;

create or replace trigger trg_product
        after
        insert on product_io
        for each row
begin
        if :new.status = 'IN' then
        
            update product set stock = stock + :new.amount
            where pcode = :new.pcode;
            
        elsif :new.status = 'OUT' then
        
            update product set stock = stock - :new.amount
            where pcode = :new.pcode;
            
        end if;


end;
/


select * from product;

--입출고 데이터입력
insert into product_io 
values(seq_product_io.nextval, 1, sysdate, 5, 'IN');
insert into product_io 

values(seq_product_io.nextval, 2, sysdate, 15, 'IN');
insert into product_io 
values(seq_product_io.nextval, 3, sysdate, 50, 'IN');
insert into product_io 
values(seq_product_io.nextval, 1, sysdate, 3, 'OUT');
insert into product_io 
values(seq_product_io.nextval, 2, sysdate, 7, 'OUT');
insert into product_io 
values(seq_product_io.nextval, 3, sysdate, 20, 'OUT');
commit;


--여러개의 dml 처리하기
create or replace trigger trg_emp_sal
        before
        insert or
        update of salary, dept_code or
        delete
        on emp_salary
        for each row
begin
        case
                when inserting then
                        dbms_output.put_line('inserting');  
                when updating('dept_code') then
                        dbms_output.put_line('updating dept_code'); 
                when updating then
                        dbms_output.put_line('updating');
                when deleting then
                        dbms_output.put_line('deleting');
        end case;

end;
/

--테스트
update emp_salary set salary = salary/2
where emp_id = '201';
commit;
update emp_salary set dept_code = 'D3'
where emp_id = '201';
commit;

select * from emp_salary;
delete from emp_salary where emp_id = '222';

































