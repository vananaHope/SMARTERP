CREATE sequence apv_seq;

INSERT INTO APPROVAL values(
	apv||'-'||apv_seq,
	#{order_id},
	#{approval_date},
	#{approval_type},
	#{drafter},
	#{approver},
	#{subject},
	#{contents},
	#{approval_status}
)

SELECT * FROM APPROVAL a ;

ALTER TABLE HIMAN.APPROVAL MODIFY APPROVAL_STATUS NUMBER;


SELECT DISTINCT HOP.PROPERTIES_NUM, PP.COLOR, bi.ITEM_NAME  
FROM HEAD_OFFICE_PRODUCT hop 
JOIN PRODUCT_PROPERTIES pp ON HOP.PROPERTIES_NUM = PP.PROPERTIES_NUM
JOIN BRAND_ITEM bi ON hop.ITEM_NUM = bi.ITEM_NUM 
WHERE PP.REF_NUM = 100
AND bi.ITEM_NUM = 1001;


SELECT oe.order_id
FROM ORDER_ERP oe 
WHERE ORDER_ID NOT IN (
	SELECT a.order_id
	FROM APPROVAL a 
	JOIN ORDER_ERP oe2 ON a.ORDER_ID = oe2.ORDER_ID  
)
ORDER BY oe.ORDER_ID desc;

		SELECT e.EMPLOYEE_NUM , e.EMPLOYEE_NAME, s.STORE_NAME 
		FROM EMPLOYEE e, STORE s  
		WHERE EMPLOYEE_NAME like '%'||''||'%'
		AND e.STORE_NUM = s.STORE_NUM
		order by s.store_name;