DELIMITER $$

CREATE PROCEDURE insert_country_if_not_in_table_and_return_id(IN country VARCHAR(20), OUT country_id INT)
BEGIN
    DECLARE existing_country_id INT DEFAULT 0;

	SELECT c.country_id INTO existing_country_id
	  FROM country c
	 WHERE c.country = country;

	IF existing_country_id = 0 THEN
		INSERT INTO country (country) VALUES (country);
	    SELECT LAST_INSERT_ID() INTO country_id;
	ELSE
		SELECT existing_country_id INTO country_id;
	END IF;
END$$

DELIMITER ;