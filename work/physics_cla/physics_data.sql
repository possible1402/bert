/****** Script for SelectTopNRows command from SSMS  ******/
/*物理学领域数据*/

SELECT id,title,abstract,classification FROM article_info where classification like 'O47%' and isUniCla=1 and language='chi' and id not in (select id from cla_test_100) order by id
SELECT id,title,abstract,classification FROM article_info where (classification like 'O4%' or classification like 'O5%') and isUniCla=1 and language='chi' and id not in (select id from cla_test_100) order by id

