-- 1.	Email-i olmayan müştərilərin telefon nömrələrini göstərin.
select phone_number from hr.employees where email is null;




-- 2.	İstifadəçinin adını əgər varsa email-ni, yoxdursa telefon nömrəsini əlaqa vasitəsi kimi göstərin.

select first_name, 
CASE
WHEN email IS NULL THEN phone_number
else email
END as Contact
from hr.employees;





-- 3.	2-ci ən yüksək maaş alan işçinin adını qaytaracaq query yazın. ?

select first_name,salary from hr.employees where salary = (select  min(salary) from (select salary from hr.employees where rownum <= 2 order by salary));





-- 4.	Ən çox maaş alan 10 işçinin adını və soyadını qaytaracaq query yazın. ?
select salary,first_name,last_name from hr.employees where rownum <=10 order by salary;






-- 5. Adının uzunluğu 5-dən böyük və ya soyadının uzunluğu 6-dan böyük olan və 
-- maaşı 1500-dən böyük olan işçilərin adını, soyadını və maaşını qaytaracaq query yazın.

select first_name,last_name,salary from (select first_name,last_name,salary from hr.employees where  salary > 1500) where length(first_name)>5 or length(last_name)>6;





--  6.	Manager_id-si null olmayan, Department_id 100 və ya 101 olan,  job_id-si ad_press olmayan işçilərin adını və soyadını çıxarın. Sıralama maaşa görə olmalıdır


select first_name,last_name,salary,department_id from (select first_name, last_name,salary,department_id from hr.employees where manager_id is not null and JOB_ID != 'AD_PRES') where department_id =100 or department_id =101 order by salary; 


-- 7 Commision_pct və ya manager_id-si null olan, maaşı 2000-3000 arasında olan işçilərin adını, soyadını və maaşını çıxarın.

select first_name, last_name,salary from (select first_name,last_name, salary,commission_pct,manager_id from hr.employees  
where salary between 2000 and 3000)
where commission_pct is null or manager_id is null;


-- 8.	Maaşı 1500-3000 arasında olan işçilərin adını qaytaran query yazın. Sıralama soyad sütunun son 3 hərfinə əsasən olsun.
select salary,first_name,last_name,substr(last_name,length(last_name)-2,3) from hr.employees where salary between 1500 and 3000 order by substr(last_name,length(last_name)-3,3);


-- 9. Ad və soyad sütunlarını birləşdirərək tam ad şəklində qaytaran query yazın. Sıralama maaşa görə azalan sırada olsun və ilk 3 sətir çıxmaq şərti ilə növbəti 10 sətir qaytarılsın.?


select tam_ad,salary from (select concat(concat(first_name,' '),last_name) as tam_ad,salary from hr.employees order by salary desc) offset 3 rows fetch next 10 rows only;



-- 10.	hr.employees table-ından manager_id-si null olmayan hər bir job_id-nin ortalama maaşını və həmin id-də olan işçi sayını göstərin. İşçi sayı yalnız 2-dən çox olan job_id-lər göstərilsin. ?


select avg(salary),count(first_name),job_id from (select * from hr.employees where manager_id is not null) group by job_id having count(first_name) >2;



-- 11.	Hr.employees table-ındakı işçilərin illik əmək haqqını göstərin.

select first_name, last_name, salary*12 as illik from hr.employees;


--12.	Ad və soyad sütunlarını birləştirərək tam ad olaraq göstərin, lakin ad və soyad arasında boşluq olsun


select concat(concat(first_name,' '),last_name) as tam_ad from hr.employees;



-- 13 Manager_id-si 100 olan işçilərin adını əmək haqqına görə azdan çoxa doğru sıralanmış şəkildə göstərin.

select first_name,salary from hr.employees where manager_id =100 order by salary;


-- 14.	Manager_id-si 100 və 200 olan işçilərin adını əmək haqqına görə azdan çoxa doğru sıralanmış şəkildə göstərin.

select first_name, salary,manager_id from hr.employees where manager_id = 100 or manager_id=200 order by salary;


-- 15.	Əmək haqqı 4000-dən çox olan işçilərin məlumatlarını əmək haqqına görə azdan çoxa sıralanmış şəkildə göstərin.

select * from hr.employees where salary>4000 order by salary;


--16. Adı “E” ilə başlayan işçilərin məlumatlarını göstərin. Həm like ilə, həm də substr() ilə edin.

select * from hr.employees where first_name like 'E%';
SELECT * from hr.employees where substr(first_name,1,1)='E';



-- 17.	 Hər job-un mamsimum əmək haqqını göstərin.


select max(salary),job_id from hr.employees group by job_id;




-- 18.	 Ortalama əmək haqqı 6000-dən çox olan job id-sini göstərin.

select avg(salary),job_id from hr.employees group by job_id having avg(salary) > 6000;



-- 19.	 Hər departamentdəki ortalama əmək haqqlarını department_id-si 100 olanlar xaric göstərin və ən yüksək ortalamdan ən aşağı ortalamaya doğru sıralayın.

select avg(salary),department_id from (select * from hr.employees where department_id !=100) group by department_id order by avg(salary) desc;


-- 20.	 Ən çox əmək haqqı alan 2-ci işçinin adənı və soyadını göstərin.?

select first_name,last_name,salary from hr.employees where salary = (select  min(salary) from (select salary from hr.employees where rownum <= 2 order by salary));



-- 21.	Hər department-də minimum maaş alan işçilərin adlarını göstərin.

select first_name ,salary, department_id from hr.employees where (salary,department_id) in (select min(salary),department_id from hr.employees group by department_id);


-- 22.	100 nömrəli departamentdə çalışan hər işçidən daha çox əmək haqqı alan işçilərin adını göstərin.?


select * from hr.employees where salary > (select max(salary) from hr.employees where department_id = 100);


-- 23.	 İşçiləri adına görə, adı eyni olanları isə əmək haqqına görə sıralayın.

select * from  hr.employees order by first_name,salary;



-- 24.	40 nömrəli departamantdə çalışan işçilərin ortalama maaşından daha çox ortalama maaşı olan olan departamentləri göstərin.?


select avg(salary),department_id from hr.employees group by department_id having avg(salary) > (select avg(salary) from hr.employees where department_id = 40);


-- 25.	 Hər işçinin adını, əmək haqqını və illik əmək haqqını illik kimi göstərin.

select first_name, salary, salary*12 as illik from hr.employees;


-- 26.	 Bütün işçilərin adını, soyadını və departament adını göstərin.

select emp.first_name,emp.last_name,dep.department_name from hr.employees emp inner join hr.departments dep on emp.department_id = dep.department_id;


-- 27.	hr.employees table-ında neçə fərqli job_id olduğunu göstərin.
select count(distinct job_id) from hr.employees;




