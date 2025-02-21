DELIMITER $$

CREATE PROCEDURE delete_relationship_with_no_child()
BEGIN
	-- delete relationship with no child
	WITH relationship_to_delete AS (
		SELECT r.relationship_id
	  	  FROM contact c
	 	 RIGHT JOIN relationship r
	 		ON c.relationship_id = r.relationship_id
	 	 WHERE c.contact_id IS NULL
	)
	DELETE r
	  FROM relationship r
	 INNER JOIN relationship_to_delete rd
	 	ON r.relationship_id = rd.relationship_id
	;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_address_with_no_child()
BEGIN
	-- delete address with no child
	WITH contact_address AS (
		SELECT a.address_id
	  	  FROM contact c
	 	 RIGHT JOIN address a
	  		ON c.address_id = a.address_id
	 	 WHERE c.contact_id IS NULL
	),
	contact_job_address AS (
		SELECT ca.address_id
	  	  FROM job j
		 RIGHT JOIN contact_address ca
	 		ON j.work_address_id = ca.address_id
	  	  LEFT JOIN contact c
	 		ON c.job_id = j.job_id
		 WHERE c.contact_id IS NULL
	)
	DELETE a
	  FROM address a
	 INNER JOIN contact_job_address c
	 	ON a.address_id = c.address_id
	;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_city_with_no_child()
BEGIN
	-- delete city with no child
	WITH city_to_delete AS (
		SELECT c.city_id
	  	  FROM address a
		 RIGHT JOIN city c
	 		ON a.city_id = c.city_id
		 WHERE a.address_id IS NULL
	)
	DELETE c
	  FROM city c
	 INNER JOIN city_to_delete cd
	 	ON c.city_id = cd.city_id
	;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_state_with_no_child()
BEGIN
	-- delete state with no child
	WITH state_to_delete AS (
		SELECT s.state_id
		  FROM city c
		 RIGHT JOIN state s
		   ON s.state_id = c.state_id
		 WHERE c.city_id IS NULL
	)
	DELETE s
	  FROM state s
	 INNER JOIN state_to_delete sd
	 	ON s.state_id = sd.state_id
	;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_country_with_no_child()
BEGIN
	-- delete country with no child
	WITH country_to_delete AS (
		SELECT c.country_id
	  	  FROM state s
	 	 RIGHT JOIN country c
			ON s.country_id = c.country_id
	  	  LEFT JOIN contact ct
	 		ON c.country_id = ct.nationality_id
	 	 WHERE s.state_id IS NULL
	   	   AND ct.contact_id IS NULL
	)
	DELETE c
	  FROM country c
	 INNER JOIN country_to_delete cd
	 	ON c.country_id = cd.country_id
	;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_job_with_no_child()
BEGIN
	-- delete job with no child
	WITH job_to_delete AS (
		SELECT j.job_id
	  	  FROM contact c
	 	 RIGHT JOIN job j
	 		ON c.job_id = j.job_id
	 	 WHERE c.contact_id IS NULL
	)
	DELETE j
	  FROM job j
	 INNER JOIN job_to_delete jd
	 	ON j.job_id = jd.job_id
	;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_company_with_no_child()
BEGIN
	-- delete company with no child
	WITH company_to_delete AS (
		SELECT c.company_id
	  	  FROM job j
	 	 RIGHT JOIN company c
	 		ON j.company_id = c.company_id
	 	 WHERE j.job_id IS NULL
	)
	DELETE c
	  FROM company c
	 INNER JOIN company_to_delete cd
	 	ON c.company_id = cd.company_id
	;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_profession_with_no_child()
BEGIN
	-- delete profession with no child
	WITH profession_to_delete AS (
		SELECT p.profession_id
	  	  FROM job j
	 	 RIGHT JOIN profession p
	 		ON j.profession_id = p.profession_id
	 	 WHERE j.job_id IS NULL
	)
	DELETE p
	  FROM profession p
	 INNER JOIN profession_to_delete pd
	 	ON p.profession_id = pd.profession_id
	;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_phone_number_with_no_child()
BEGIN
	WITH phone_number_to_delete AS (
		SELECT p.phone_number_id
		  FROM contact c
		 RIGHT JOIN phone_number p
		 	ON c.phone_number_id = p.phone_number_id
		 WHERE c.contact_id IS NULL
	)
	DELETE p
	  FROM phone_number p
	 INNER JOIN phone_number_to_delete pd
	 	ON p.phone_number_id = pd.phone_number_id
	;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_parents_with_no_child(IN did_change_phone_number TINYINT,
											  IN did_change_street_address_or_zip_code TINYINT,
											  IN did_change_city TINYINT,
											  IN did_change_state TINYINT,
											  IN did_change_country TINYINT,
											  IN did_change_relationship TINYINT,
											  IN did_change_profession TINYINT,
											  IN did_change_company TINYINT)
BEGIN
	IF did_change_phone_number = 1 THEN
		CALL delete_phone_number_with_no_child();
	END IF;
	IF did_change_profession = 1 OR did_change_company = 1 THEN
		CALL delete_job_with_no_child();
	END IF;
	IF did_change_profession = 1 THEN
		CALL delete_profession_with_no_child();
	END IF;
	IF did_change_company = 1 THEN
		CALL delete_company_with_no_child();
	END IF;
	IF did_change_street_address_or_zip_code = 1 THEN
		CALL delete_address_with_no_child();
	END IF;
	IF did_change_city = 1 THEN
		CALL delete_city_with_no_child();
	END IF;
	IF did_change_state = 1 THEN
		CALL delete_state_with_no_child();
	END IF;
	IF did_change_country = 1 THEN
		CALL delete_country_with_no_child();
	END IF;
	IF did_change_relationship = 1 THEN
		CALL delete_relationship_with_no_child();
	END IF;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE delete_contact(IN contact_id INT)
BEGIN
	DELETE FROM contact c
	 WHERE c.contact_id = contact_id;
	CALL delete_parents_with_no_child(1,1,1,1,1,1,1,1);
END$$

DELIMITER $$