Select employees.first_name, employees.last_name, 
salaries.from_date, 
salaries.to_date, salaries.salary
 from employees 
 inner join salaries
 on salaries.emp_no=employees.emp_no
where employees.emp_no=10006 order by salaries.from_date
;


select employees.first_name, employees.last_name,
dept_emp.from_date, dept_emp.to_date, dept_emp.dept_no, departments.dept_name
from employees
inner join dept_emp
on employees.emp_no=dept_emp.emp_no	

inner join departments
on dept_emp.dept_no = departments.dept_no;												


select employees.first_name, employees.last_name, departments.dept_name
from employees
left join dept_manager
on employees.emp_no= dept_manager.emp_no

left join departments
on dept_manager.dept_no=departments.dept_no
where employees.emp_no=110022 || employees.emp_no=110085 || employees.emp_no=10006;

insert into departments values('d99', 'Compras internas');

Select departments.dept_name, employees.first_name, employees.last_name
from employees
right join dept_manager
on dept_manager.emp_no= employees.emp_no

right join departments
on departments.dept_no=dept_manager.dept_no;
