
-- 13. Retorne o nome do país e o total de idiomas que nele se falam
select country.name, count(*) from countrylanguage
 inner join country
 where CountryCode=country.Code
 group by country.Name;
 
 -- 14. Retorne o nome do país e o total de idiomas que nele se falam. Limite o resultado apenas aos
-- países nos quais se fala mais que 10 idiomas. 
select country.name, count(*)
from countrylanguage
 inner join country
 where CountryCode=country.Code
 group by country.Name
 having count(*)>10;
 
 -- 15. Retorne o nome do país e o total de cidades que nele existem
 select country.name, count(*)
 from city
 inner join country
 where country.code=CountryCode
 group by country.name;
 
 -- 16. Retorne o nome do país em conjunto com a média de população das cidades (do país).
select country.Name, avg(population)
from country
group by Name;

-- 17. Retorne o nome do país em conjunto com a média de população das cidades (do país). Ordene
-- da menor a maior pela média da população.
select name, avg(population)
from country
group by Name
order by Population asc;


-- 18. Retorne o nome do país em conjunto com a média de população das cidades (do país). Limite
-- o resultado apenas pelos países cuja média de população das cidades seja maior que 70000.
-- Ordene o resultado de forma ascendente.
 select name, avg(population) as 'my avg'
 from country 
 where 'my avg' >70000
 group by Name
 order by Population asc;
 
 