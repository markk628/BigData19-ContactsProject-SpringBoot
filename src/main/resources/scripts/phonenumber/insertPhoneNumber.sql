DELIMITER $$

CREATE PROCEDURE insert_phone_number_if_not_in_table_and_return_id(IN phone_number VARCHAR(11), OUT phone_number_id INT)
BEGIN
	DECLARE existing_phone_number_id INT DEFAULT 0;

	SELECT c.phone_number_id INTO existing_phone_number_id
	  FROM phone_number c
	 WHERE c.phone_number = phone_number;

	IF existing_phone_number_id = 0 THEN
		INSERT INTO phone_number (phone_number) VALUES (phone_number);
	    SELECT LAST_INSERT_ID() INTO phone_number_id;
	ELSE
		SELECT existing_phone_number_id INTO phone_number_id;
	END IF;
END$$

DELIMITER ;