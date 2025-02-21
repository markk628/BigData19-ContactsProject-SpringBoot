DELIMITER $$

CREATE PROCEDURE insert_company_if_not_in_table_and_return_id(IN company VARCHAR(50), OUT company_id INT)
BEGIN
    DECLARE existing_company_id INT DEFAULT 0;

	SELECT c.company_id INTO existing_company_id
	  FROM company c
	 WHERE c.company = company;

	IF existing_company_id = 0 THEN
		INSERT INTO company (company) VALUES (company);
	    SELECT LAST_INSERT_ID() INTO company_id;
	ELSE
		SELECT existing_company_id INTO company_id;
	END IF;
END$$

DELIMITER ;