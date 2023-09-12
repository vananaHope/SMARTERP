SELECT * FROM store;

SELECT store_num, store_name FROM store
WHERE store_num LIKE '%'||'0'||'%';
SELECT store_num, store_name FROM store
WHERE store_name LIKE '%'||''||'%';

SELECT store_num, store_name FROM store;
SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
				e.phone_num, e.hire_date, e.resignation_day	
		FROM EMPLOYEE e, STORE s 
		WHERE e.store_num = s.STORE_NUM
		ORDER BY e.employee_num, e.resignation_day DESC;

	
SELECT * FROM EMPLOYEE;
SELECT * FROM employee WHERE employee_name='동동이';
SELECT emp_seq.NEXT	val FROM dual;
SELECT emp_seq.currval-1 FROM dual;
SELECT emp_seq.currval FROM dual;

SELECT store_num, store_name FROM store
ORDER BY store_num;
WHERE store_num = 8;
SELECT employee_num, employee_name, employee_photo FROM employee;
ALTER TABLE HIMAN.EMPLOYEE MODIFY EMPLOYEE_PHOTO VARCHAR2(150);

SELECT e.employee_num, e.employee_name, s.store_num, s.store_name, e.password, e.email, e.job_level, 
				e.hire_date, e.hire_type, e.resignation_day, e.phone_num, e.employee_photo 	
		FROM EMPLOYEE e, STORE s 
		WHERE e.store_num = s.STORE_NUM
		AND e.employee_num=32;
	
update employee set employee_photo = 'ababab'
		where employee_num=81 and employee_name='실험용6';	
SELECT * FROM EMPLOYEE e WHERE EMPLOYEE_NUM =92;

SELECT * FROM store;

SELECT s.store_num, e.job_level
FROM EMPLOYEE e left OUTER join STORE s 
on e.STORE_NUM =s.STORE_NUM;
where e.JOB_LEVEL= '점주';


SELECT * FROM employee WHERE job_level='점주';
SELECT * FROM employee WHERE job_level='매니저';

-- 점포에서 직위 점주 확인
SELECT s.store_num ,s.store_name, e.employee_name, e.job_level
FROM employee e,STORE s  WHERE e.STORE_NUM=s.STORE_NUM AND  e.job_level='점주';

-- 점포에서 권한2 이상(점주) 확인
SELECT s.store_num ,s.store_name, e.employee_name, e.job_level, e.auth
FROM employee e,STORE s  WHERE e.STORE_NUM=s.STORE_NUM AND  e.auth=2
ORDER BY store_num;
SELECT * FROM employee WHERE auth<=2;
-- 전체 조회
SELECT * FROM EMPLOYEE;

SELECT * FROM employee WHERE employee_name='김네이버2';

-- 플래시백 쿼리
INSERT INTO employee
(SELECT * FROM
employee
AS OF TIMESTAMP(SYSDATE-(1/24)/1)
);
SELECT * FROM employee 
AS OF TIMESTAMP(SYSDATE-(1/24)/1);

-- 경로 저장을 위한 글자수 제한 늘리기
ALTER TABLE HIMAN.EMPLOYEE MODIFY EMPLOYEE_PHOTO VARCHAR2(1000);

-- 업데이트 예시
UPDATE employee SET STORE_NUM = #{store_num}, EMPLOYEE_NAME = #{employee_name}, id =#{employee_name}, password=#{password}, 
		email=#{email}, PHONE_NUM=#{phone_num}, job_level=#{job_level}, 
		HIRE_DATE=#{hire_date}, hire_type=#{hire_type},resignation_day=#{resignation_day}, auth=#{auth}
		WHERE employee_num=142;
		
SELECT * FROM employee WHERE employee_num=146;	
SELECT employee_num, employee_name, employee_photo FROM;
DELETE employee WHERE employee_name='황티즐';

SELECT * FROM employee WHERE employee_photo LIKE '%/%';
UPDATE employee SET employee_photo ='143_김티모.png' WHERE employee_num=143;
UPDATE employee SET hire_type='본사' WHERE STORE_NUM =0;
UPDATE employee SET hire_type='점포' WHERE STORE_NUM >=1;
SELECT e.store_num, s.store_name, e.employee_num, e.employee_name, e.hire_type, e.job_level, e.auth FROM EMPLOYEE e , STORE s WHERE e.STORE_NUM =s.STORE_NUM  ORDER BY store_num;
SELECT * FROM store;
SELECT * FROM employee WHERE employee_num=143;
UPDATE employee SET RESIGNATION_DAY = '2023-08-26' WHERE employee_num = 163;

SELECT * from employee WHERE auth = 4;
SELECT * FROM employee;
SELECT * FROM employee WHERE employee_name='오빠닭';
-- DELETE FROM employee WHERE auth =4;

select e.store_num, store_name, employee_name, id, password, phone_num, job_level
		from employee e ,STORE s
		where e.store_num = s.STORE_NUM and employee_name= '강남' and password='5785' AND phone_num = '010-7412-5785';

update employee set store_num= 0, employee_name = '까마귀2', id = '까마귀', password = '147852', 
		email = 'karas@naver.com', phone_num = '010-4812-4452', job_level = '직원', 
		hire_date = '2023-08-25', hire_type = '본사', resignation_day = '', auth = 3
		where employee_num = 222;
SELECT * FROM employee WHERE employee_num = 222;

DELETE FROM employee WHERE employee_num=221 and employee_name='김티모2' AND RESIGNATION_DAY = '';
DELETE FROM employee WHERE employee_num=233;
SELECT * FROM employee WHERE employee_num=228;
SELECT * FROM employee WHERE employee_num>=236;
SELECT * FROM employee WHERE employee_name='김버증';
select employee_num, e.store_num, store_name, employee_name, password, job_level
		from employee e ,STORE s
		where e.store_num=s.store_num AND  id='김버증' and password='6789';
SELECT * FROM employee WHERE employee_num = 238;
SELECT * FROM store;
UPDATE employee SET job_level = '본사직원' WHERE hire_type='본사'AND auth=3;
SELECT * FROM employee WHERE job_level='사장';

SELECT * FROM store;
SELECT job_level, hire_type, employee_num
		FROM employee WHERE store_num=5 AND auth=2;
		
SELECT store_num, store_name FROM store
		WHERE store_name LIKE '%'||#{store_name}||'%'
		ORDER BY store_num	
	
SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
				e.phone_num, e.hire_date, e.resignation_day	
		FROM EMPLOYEE e, STORE s 
		WHERE e.store_num = s.STORE_NUM 
		AND employee_num LIKE '%'||''||'%'
		ORDER BY e.resignation_day desc, e.employee_num; 	
	
SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
				e.phone_num, e.hire_date, e.resignation_day	
		FROM EMPLOYEE e, STORE s 
		WHERE e.store_num = s.STORE_NUM 
		AND to_char(hire_date,'YYYY-MM-DD') LIKE '%'||17||'%'
		ORDER BY resignation_day desc;

SELECT count(*)	
		FROM EMPLOYEE e, STORE s 
		WHERE e.store_num = s.STORE_NUM 
		AND store_name LIKE '%%';
		ORDER BY e.resignation_day desc, e.employee_num;	
	
SELECT count(*)	
		FROM EMPLOYEE e, STORE s 
		WHERE e.store_num = s.STORE_NUM 
		AND to_char(resignation_day,'YYYY-MM-DD') LIKE '%'||2023||'%';
	
SELECT * FROM employee WHERE employee_name = '황수아';
SELECT count(*) FROM employee;	
SELECT* FROM employee;	

SELECT emp_seq.currval FROM dual;
SELECT emp_seq.nextval FROM dual;
SELECT employee_seq.currval FROM dual;
SELECT employee_seq.NEXTval FROM dual;


SELECT * FROM store;
CREATE SEQUENCE emp_seq START WITH 24;
DROP SEQUENCE emp_seq;
DROP SEQUENCE employee_seq;

INSERT INTO EMPLOYEE (employee_num, store_num, employee_name, id, password, email, phone_num, job_level, hire_date, hire_type, auth) 
		VALUES (3252, 1, '화긴화긴화긴', '화긴화긴화긴', '7894','',
				'', '직원', sysdate, '점포', '4');	
	
	
SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
				e.phone_num, e.hire_date, e.resignation_day	
		FROM EMPLOYEE e, STORE s 
		WHERE 1=1 AND e.store_num = s.store_num 
		AND employee_num LIKE '%'||''||'%'
		AND employee_name LIKE '%'||''||'%'
		AND STORE_name LIKE '%'||'점'||'%'
		AND JOB_LEVEL LIKE '%'||''||'%'
		AND PHONE_NUM LIKE '%'||''||'%'
		ORDER BY e.resignation_day desc, e.employee_num;
	
	
SELECT * FROM (SELECT rownum cnt, a.* FROM (	
		SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
				e.phone_num, e.hire_date, e.resignation_day	
		FROM EMPLOYEE e, STORE s 
		WHERE e.store_num = s.store_num 
		AND employee_name LIKE '%'||'서아이'||'%'
		ORDER BY e.resignation_day desc, e.employee_num
		)a
		)
		WHERE cnt BETWEEN 1 AND 20;
	
		SELECT * FROM (
			SELECT rownum cnt, a.* FROM (
				SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
						e.phone_num, e.hire_date, e.resignation_day	
				FROM EMPLOYEE e, STORE s 
				WHERE e.store_num = s.STORE_NUM 
				AND to_char(hire_date,'YYYY-MM-DD') LIKE '%'||'2023'||'%'
				ORDER BY resignation_day DESC, hire_date DESC, employee_num desc
			)a
		) WHERE cnt BETWEEN 1 AND 30;
	
	SELECT count(*)	
		FROM EMPLOYEE e, STORE s 
		WHERE e.store_num = s.STORE_NUM 
		AND to_char(resignation_day,'YYYY-MM-DD') LIKE '%'||'2023'||'%';
	
	
	SELECT * FROM (
			SELECT rownum cnt, a.* FROM (
					SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
							e.phone_num, e.hire_date, e.resignation_day	
					FROM EMPLOYEE e, STORE s 
					WHERE e.store_num = s.store_num 
					AND s.store_name LIKE '%'||''||'%'
					ORDER BY e.resignation_day DESC, e.store_num, auth, e.employee_name
			)a
		) WHERE  cnt BETWEEN 1 AND 30;
	
	SELECT * FROM (
			SELECT rownum cnt, a.* FROM (
					SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
							e.phone_num, e.hire_date, e.resignation_day	
					FROM EMPLOYEE e, STORE s 
					WHERE e.store_num = s.store_num 
					AND phone_num LIKE '%'||'12'||'%'
					ORDER BY e.resignation_day desc, phone_num,  e.employee_name
			)a
		) WHERE cnt BETWEEN 1 AND 30;
	
	SELECT * FROM (
			SELECT rownum cnt, a.* FROM (
				SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
						e.phone_num, e.hire_date, e.resignation_day	
				FROM EMPLOYEE e, STORE s 
				WHERE e.store_num = s.STORE_NUM 
				AND to_char(resignation_day,'YYYY-MM-DD') LIKE '%'||''||'%'
				ORDER BY resignation_day DESC, employee_name
			)a
		) WHERE cnt BETWEEN 1 AND 30;
		
	
	SELECT * FROM (
			SELECT rownum cnt, a.* FROM (
					SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
							e.phone_num, e.hire_date, e.resignation_day	
					FROM EMPLOYEE e, STORE s 
					WHERE e.store_num = s.store_num 
					AND s.store_name LIKE '%'||''||'%'
					ORDER BY e.resignation_day DESC, e.store_num, auth, e.employee_name
			)a
		) WHERE  cnt BETWEEN 1 AND 30;
		
	
	SELECT * FROM (
    SELECT rownum cnt, a.* FROM (
        SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
                e.phone_num, e.hire_date, e.resignation_day    
        FROM EMPLOYEE e, STORE s 
        WHERE e.store_num = s.STORE_NUM 
        AND EXTRACT(MONTH FROM hire_date) = 9 -- 여기서 2는 조회하려는 월 (예: 2월)
        ORDER BY resignation_day DESC, hire_date DESC, employee_num DESC
    ) a
) WHERE cnt BETWEEN 1 AND 30;

SELECT * FROM (
    SELECT rownum cnt, a.* FROM (
        SELECT e.employee_num, e.employee_name, s.store_name, e.job_level, 
                e.phone_num, e.hire_date, e.resignation_day    
        FROM EMPLOYEE e, STORE s 
        WHERE e.store_num = s.STORE_NUM 
        AND EXTRACT(YEAR FROM hire_date) =2023 
        ORDER BY resignation_day DESC, hire_date DESC, employee_num DESC
    ) a
) WHERE cnt BETWEEN 1 AND 30;

SELECT count(*)	
		FROM EMPLOYEE e, STORE s 
		WHERE e.store_num = s.STORE_NUM 
		AND EXTRACT(YEAR FROM hire_date) =2023;

SELECT * FROM store;
SELECT * FROM EMPLOYEE;
UPDATE employee SET password = '1234' WHERE EMPLOYEE_NUM =54;
SELECT * FROM employee WHERE employee_num=54;

SELECT job_level, employee_num, store_num, auth, hire_type
		FROM employee WHERE store_num=8 AND job_level='점주'; AND auth=2;
