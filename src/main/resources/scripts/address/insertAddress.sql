DELIMITER $$

CREATE PROCEDURE insert_address_if_not_in_table_and_return_id(IN street_address VARCHAR(50), IN city_id INT, zip_code VARCHAR(8), OUT address_id INT)
BEGIN
    DECLARE existing_address_id INT DEFAULT 0;

	SELECT a.address_id INTO existing_address_id
	  FROM address a
	 WHERE a.street_address = street_address
	   AND a.city_id = city_id
	   AND a.zip_code = zip_code;

	IF existing_address_id = 0 THEN
		INSERT INTO address (street_address, city_id, zip_code) VALUES (street_address , city_id , zip_code);
	    SELECT LAST_INSERT_ID() INTO address_id;
	ELSE
		SELECT existing_address_id INTO address_id;
	END IF;
END$$

DELIMITER ;