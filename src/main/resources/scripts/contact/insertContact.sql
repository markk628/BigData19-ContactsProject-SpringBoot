CREATE PROCEDURE insert_contact_if_not_in_table(IN contact_name VARCHAR(30),
                                                IN phone_number VARCHAR(11),
                                                IN street_address VARCHAR(50),
                                                IN zip_code VARCHAR(8),
                                                IN city VARCHAR(20),
                                                IN state VARCHAR(20),
                                                IN country VARCHAR(20),
                                                IN relationship VARCHAR(20),
                                                IN nationality VARCHAR(20),
                                                IN profession VARCHAR(50),
                                                IN company VARCHAR(50),
                                                IN work_street_address VARCHAR(50),
                                                IN work_zip_code VARCHAR(8),
                                                IN work_city VARCHAR(20),
                                                IN work_state VARCHAR(20),
                                                IN work_country VARCHAR(20),
                                                IN app_user_username VARCHAR(50))
BEGIN
    DECLARE existing_contact_id INT DEFAULT 0;
	DECLARE phone_number_id INT;
	DECLARE country_id INT;
	DECLARE state_id INT;
	DECLARE city_id INT;
	DECLARE address_id INT;
	DECLARE relationship_id INT;
	DECLARE nationality_id INT;
	DECLARE profession_id INT;
	DECLARE company_id INT;
	DECLARE work_country_id INT;
	DECLARE work_state_id INT;
	DECLARE work_city_id INT;
	DECLARE work_address_id INT;
	DECLARE job_id INT;

	SELECT c.contact_id INTO existing_contact_id
	  FROM contact c
	 INNER JOIN phone_number p
	 	ON c.phone_number_id = p.phone_number_id
	 WHERE c.app_user_username = app_user_username
	   AND p.phone_number = phone_number;

	IF existing_contact_id = 0 THEN
		CALL insert_phone_number_if_not_in_table_and_return_id(phone_number, phone_number_id);
		CALL insert_country_if_not_in_table_and_return_id(country, country_id);
		CALL insert_state_if_not_in_table_and_return_id(state, country_id, state_id);
		CALL insert_city_if_not_in_table_and_return_id(city, state_id, city_id);
		CALL insert_address_if_not_in_table_and_return_id(street_address, city_id, zip_code, address_id);
		CALL insert_relationship_if_not_in_table_and_return_id(relationship, relationship_id);
		CALL insert_country_if_not_in_table_and_return_id(nationality, nationality_id);
		CALL insert_profession_if_not_in_table_and_return_id(profession, profession_id);
		CALL insert_company_if_not_in_table_and_return_id(company, company_id);
		CALL insert_country_if_not_in_table_and_return_id(work_country, work_country_id);
		CALL insert_state_if_not_in_table_and_return_id(work_state, work_country_id, work_state_id);
		CALL insert_city_if_not_in_table_and_return_id(work_city, work_state_id, work_city_id);
		CALL insert_address_if_not_in_table_and_return_id(work_street_address, work_city_id, work_zip_code, work_address_id);
		CALL insert_job_if_not_in_table_and_return_id(profession_id, company_id, work_address_id, job_id);
		INSERT INTO contact (contact_name, phone_number_id, address_id, relationship_id, nationality_id, job_id, app_user_username)
		VALUES (contact_name, phone_number_id, address_id, relationship_id, nationality_id, job_id, app_user_username);
	ELSE
		SELECT existing_contact_id AS contact_id;
	END IF;
END$$

DELIMITER ;