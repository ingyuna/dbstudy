-- 1. 모든 사원의 last_name, salary, 본인이 근무하는 부서의 평균연봉(SALARY)을 조회하시오.
-- 1)스칼라 서브쿼리
-- t : 전체 테이블의 데이터
-- d : 같은 부서의 데이터 
SELECT t.last_name
     , t.salary
     , (SELECT ROUND(AVG(d.salary))
          FROM employees d
         WHERE d.department_id = t.department_id) AS 평균연봉
  FROM employees t;      
  
  
-- 2) 외부조인 (department_id가 없는 사원도 조회할 수 있도록)  
 SELECT t.last_name
      , t.salary
      , ROUND(AVG(d.salary)) AS 평균연봉
   FROM employees t LEFT OUTER JOIN employees d
     ON t.department_id = d.department_id
  GROUP BY t.last_name, t.salary;  

    
-- 2. 부서(department_id)별로 department_id, department_name, 평균연봉을 조회하시오.
-- 1) 스칼라 서브쿼리
SELECT d.department_id
     , d.department_name
     , (SELECT ROUND(AVG(e.salary))
          FROM employees e
         WHERE e.department_id = d.department_id) AS 평균연봉
  FROM departments d;

-- 2) 외부조인
SELECT d.department_id
     , d.department_name
     , ROUND(AVG(e.salary)) AS 평균연봉
FROM departments d LEFT OUTER JOIN employees e
  ON d.department_id = e.department_id
 GROUP BY d.department_id, d.department_name;


-- 3. 모든 사원들의 employee_id, last_name, department_name 을 조회하시오.
-- 1) 스칼라 서브쿼리
SELECT e.employee_id
     , e.last_name
     , (SELECT d.department_name
          FROM departments d
         WHERE d.department_id = e.department_id) AS 부서명
  FROM employees e;


-- 2) 외부 조인
SELECT e.employee_id
     , e.last_name
     , d.department_name
  FROM departments d RIGHT OUTER JOIN employees e
    ON d.department_id = e.department_id;


-- 4. 평균연봉 이상의 연봉을 받는 사원들의 정보를 조회하시오.
select last_nmae
     , salary
  FROM employees
 WHERE salary >= (SELECT AVG(salary)
                    FROM employees);


-- 5. Patrick Sully 와 같은 부서에 근무하는 모든 사원정보를 조회하시오.
-- first_name : Patrick
-- last_name : Sully 
-- 서브쿼리 : Patrick Sully의 부서, 다중 행 서브쿼리
SELECT first_name
     , last_name
     , department_id
  FROM employees
 WHERE department_id IN(SELECT department_id
                          FROM employees
                         WHERE first_name = 'Patrick'
                            AND last_name = 'Sully');


-- 6. 부서번호(department_id)가 20인 사원들 중에서 평균연봉(salary) 이상의 연봉을 받는 사원정보를 조회하시오.
SELECT last_name
     , salary
     , department_id
  FROM employees
 WHERE department_id = 20
   AND salary >= (SELECT AVG(salary)
                    FROM employees);
   

-- 7. 직업(job_id)이 'PU_MAN'인 사원들의 최대연봉(salary)보다 더 많은 연봉을 받은 사원들의 정보를 조회하시오.
-- 1) 다중 행 서브쿼리
SELECT last_name
     , salary
     , job_id
  FROM employees
 WHERE salary > ALL(SELECT salary
                      FROM employees
                     WHERE job_id = 'PU_MAN');
                     

-- 2) 단일 행 서브쿼리
SELECT last_name
     , salary
     , job_id
  FROM employees
 WHERE salary > (SELECT MAX(salary)
                      FROM employees
                     WHERE job_id = 'PU_MAN');                


-- 8. 사원번호(employee_id)가 131인 사원의 job_id와 salary가 모두 일치하는 사원들의 정보를 조회하시오.
SELECT last_name
     , job_id
     , salary
  FROM employees
 WHERE job_id = (SELECT job_id
                   FROM employees
                  WHERE employee_id = 131)
   AND salary = (select salary
                   FROM employees
                  WHERE employee_id = 131);
          
SELECT last_name
     , job_id
     , salary
  FROM employees
 WHERE (job_id, salary) = (SELECT job_id, salary
                             FROM employees
                            WHERE employee_id = 131);


-- 9. location_id가 1000~1900인 국가들의 country_id와 country_name을 조회하시오.
SELECT country_id
     , country_name
  FROM countries
 WHERE country_id IN(SELECT DISTINCT country_id
                       FROM locations
                      WHERE location_id between 1000 and 1900);
                      

-- 10. 부서(department_name)가 'Executive'인 모든 사원들의 정보를 조회하시오.
-- 서브쿼리 : 부서이름이 'Exectuive'인 부서들의 department_id
-- 서브쿼리의 WHERE 절에서 사용한 DEPARTMENT_NAME은 PK, UQ가 아니므로 서브쿼리의 결과는 여러 개이다.
SELECT last_name
     , department_id
  FROM employees
 WHERE department_id IN(SELECT department_id
                          FROM departments
                         WHERE department_name = 'Executive');
                         
                         
-- 11. 부서번호(department_id)가 30인 사원들 중에서 부서번호가 50인 사원들의 최대연봉보다 더 많은 연봉을 받는 사원들을 조회하시오.
-- 1) 다중 행 서브쿼리
SELECT last_name
     , salary
  FROM employees
 WHERE department_id = 30
   AND salary > ALL(SELECT salary
                      FROM employees
                     WHERE department_id = 50);
             
-- 2) 단일 행 서브쿼리 
SELECT last_name
     , salary
  FROM employees
 WHERE department_id = 30
   AND salary > (SELECT MAX(salary)
                   FROM employees
                  WHERE department_id = 50);            
             
              
-- 12. MANAGER가 아닌 사원들의 정보를 조회하시오.
-- manager는 manager_id를 가지고 있다.
-- 서브쿼리의 결과는 NULL 값을 가질 수 없다.

SELECT employee_id
     , last_name
  FROM employees
 WHERE employee_id NOT IN(SELECT DISTINCT manager_id
                            FROM employees
                           WHERE manager_id IS NOT NULL);


-- 13. 근무지(city)가 'Southlake'인 사원들의 정보를 조회하시오.
-- 서브쿼리1 : 근무지(city)가 'Southlake'인 location_id를 locations 테이블에서 조회
-- 서브쿼리2 : 모든 사원들의 location_id (employees와 departments의 조인)
/*
employees         - departments                  - locations
department_id     - department_id, location_id   - location_id, city
*/
-- 1) 서브쿼리 
SELECT employee_id
     , last_name
  FROM employees e
 WHERE (SELECT location_id
          FROM departments d 
         WHERE d.department_id = e.department_id) IN(SELECT location_id
                                                      FROM locations
                                                     WHERE city = 'Southlake');

-- 2) 내부조인
SELECT employee_id
     , last_name
  FROM locations l, departments d, employees e
 WHERE l.location_id = d.location_id
   AND d.department_id = e.department_id
   AND l.city = 'Southlake';


-- 14. 부서명(department_name)의 가나다순(오름차순)으로 모든 사원의 정보를 조회하시오.
SELECT employee_id
     , last_name
  FROM employees e
 ORDER BY (SELECT d.department_name
             FROM departments d
            WHERE d.department_id = e.department_id);


-- 15. 가장 많은 사원들이 근무하고 있는 부서번호(department_id)와 근무하는 인원수를 조회하시오.
-- 근무 중인 부서의 사원수
-- 최대 인원이 근무하는 사원수
SELECT department_id
     , COUNT(*) AS 부서별사원수
  FROM employees
 WHERE department_id IS NOT NULL
 GROUP BY department_id
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                    FROM employees
                   GROUP BY department_id);
 



