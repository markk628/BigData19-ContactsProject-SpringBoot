DELIMITER $$

CREATE PROCEDURE insert_state_if_not_in_table_and_return_id(IN state VARCHAR(20), IN country_id INT, OUT state_id INT)
BEGIN
    DECLARE existing_state_id INT DEFAULT 0;

	SELECT s.state_id INTO existing_state_id
	  FROM state s
	 WHERE s.state = state
	   AND s.country_id = country_id;

	IF existing_state_id = 0 THEN
		INSERT INTO state (state, country_id) VALUES (state, country_id);
	    SELECT LAST_INSERT_ID() INTO state_id;
	ELSE
		SELECT existing_state_id INTO state_id;
	END IF;
END$$

DELIMITER ;