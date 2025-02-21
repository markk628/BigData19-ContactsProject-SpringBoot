DELIMITER $$

CREATE PROCEDURE insert_city_if_not_in_table_and_return_id(IN city VARCHAR(20), IN state_id INT, OUT city_id INT)
BEGIN
    DECLARE existing_city_id INT DEFAULT 0;

	SELECT a.city_id INTO existing_city_id
	  FROM city a
	 WHERE a.city = city
	   AND a.state_id = state_id;

	IF existing_city_id = 0 THEN
		INSERT INTO city (city, state_id) VALUES (city, state_id);
	    SELECT LAST_INSERT_ID() INTO city_id;
	ELSE
		SELECT existing_city_id INTO city_id;
	END IF;
END$$

DELIMITER ;