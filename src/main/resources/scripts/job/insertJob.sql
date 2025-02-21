DELIMITER $$

CREATE PROCEDURE insert_job_if_not_in_table_and_return_id(IN profession_id INT, IN company_id INT, IN work_address_id INT, OUT job_id INT)
BEGIN
    DECLARE existing_job_id INT DEFAULT 0;

	SELECT j.job_id INTO existing_job_id
	  FROM job j
	 WHERE j.profession_id = profession_id
	   AND j.company_id = company_id
	   AND j.work_address_id = work_address_id;

	IF existing_job_id = 0 THEN
		INSERT INTO job (profession_id, company_id, work_address_id) VALUES (profession_id, company_id, work_address_id);
	    SELECT LAST_INSERT_ID() INTO job_id;
	ELSE
		SELECT existing_job_id INTO job_id;
	END IF;
END$$

DELIMITER ;