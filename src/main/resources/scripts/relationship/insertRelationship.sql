DELIMITER $$

CREATE PROCEDURE insert_relationship_if_not_in_table_and_return_id(IN relationship VARCHAR(20), OUT relationship_id INT)
BEGIN
	DECLARE existing_relationship_id INT DEFAULT 0;

	SELECT c.relationship_id INTO existing_relationship_id
	  FROM relationship c
	 WHERE c.relationship = relationship;

	IF existing_relationship_id = 0 THEN
		INSERT INTO relationship (relationship) VALUES (relationship);
	    SELECT LAST_INSERT_ID() INTO relationship_id;
	ELSE
		SELECT existing_relationship_id INTO relationship_id;
	END IF;
END$$

DELIMITER ;