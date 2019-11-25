SELECT name,value,isses_modifiable,issys_modifiable
FROM v$parameter
WHERE name like '%sga%';


