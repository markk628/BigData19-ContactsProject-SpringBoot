DELIMITER $$

CREATE PROCEDURE insert_profession_if_not_in_table_and_return_id(IN profession VARCHAR(50), OUT profession_id INT)
BEGIN
    DECLARE existing_profession_id INT DEFAULT 0;

	SELECT p.profession_id INTO existing_profession_id
	  FROM profession p
	 WHERE p.profession = profession;

	IF existing_profession_id = 0 THEN
		INSERT INTO profession (profession) VALUES (profession);
	    SELECT LAST_INSERT_ID() INTO profession_id;
	ELSE
		SELECT existing_profession_id INTO profession_id;
	END IF;
END$$

DELIMITER ;