DELIMITER $$

CREATE PROCEDURE select_contacts(IN app_user_username VARCHAR(50))
BEGIN
    WITH full_address AS (
	SELECT a.address_id,
		   a.street_address,
		   c.city,
		   s.state,
		   a.zip_code,
		   ct.country
	  FROM address a
	 INNER JOIN city c
	 	ON a.city_id = c.city_id
	 INNER JOIN state s
	 	ON c.state_id = s.state_id
	 INNER JOIN country ct
	 	ON s.country_id = ct.country_id
	),
	nationality AS (
		SELECT c.contact_id,
			   ct.country AS nationality
		  FROM contact c
		 INNER JOIN country ct
		 	ON c.nationality_id = ct.country_id
	),
	jobs AS (
		SELECT j.job_id,
			   j.work_address_id,
			   p.profession,
			   c.company,
			   a.street_address AS job_street_address,
			   a.city AS job_city,
			   a.state AS job_state,
			   a.zip_code AS job_zip_code,
			   a.country AS job_country
		  FROM job j
		 INNER JOIN profession p
		 	ON j.profession_id = p.profession_id
		 INNER JOIN company c
		 	ON j.company_id = c.company_id
		  LEFT JOIN full_address a
		 	ON j.work_address_id = a.address_id
	),
	contact_phone_number AS (
		SELECT c.contact_id,
			   c.contact_name,
			   p.phone_number,
			   c.address_id,
			   c.relationship_id,
			   c.job_id,
			   c.app_user_username
		  FROM contact c
		 INNER JOIN phone_number p
		 	ON c.phone_number_id = p.phone_number_id
	),
	contacts_list_contact AS (
		SELECT c.contact_id,
			   c.contact_name,
			   c.phone_number,
			   CONCAT(a.street_address, ', ', a.city, ', ', a.state, ', ', a.zip_code, ', ', a.country) AS address,
			   r.relationship,
			   n.nationality,
			   j.profession,
			   j.company,
			   CONCAT(j.job_street_address, ', ', j.job_city, ', ', j.job_state, ', ', j.job_zip_code, ', ', j.job_country) AS job_address
	  FROM contact_phone_number c
	 INNER JOIN relationship r
	 	ON c.relationship_id = r.relationship_id
	  LEFT JOIN full_address a
	 	ON c.address_id = a.address_id
	 INNER JOIN nationality n
	 	ON c.contact_id = n.contact_id
	  LEFT JOIN jobs j
	 	ON c.job_id = j.job_id
	 WHERE c.app_user_username = app_user_username
	)
	SELECT *
	  FROM contacts_list_contact;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE select_contacts_with_name(IN app_user_username VARCHAR(50), IN contact_name VARCHAR(30))
BEGIN
    WITH full_address AS (
	SELECT a.address_id,
		   a.street_address,
		   c.city,
		   s.state,
		   a.zip_code,
		   ct.country
	  FROM address a
	 INNER JOIN city c
	 	ON a.city_id = c.city_id
	 INNER JOIN state s
	 	ON c.state_id = s.state_id
	 INNER JOIN country ct
	 	ON s.country_id = ct.country_id
	),
	nationality AS (
		SELECT c.contact_id,
			   ct.country AS nationality
		  FROM contact c
		 INNER JOIN country ct
		 	ON c.nationality_id = ct.country_id
	),
	jobs AS (
		SELECT j.job_id,
			   j.work_address_id,
			   p.profession,
			   c.company,
			   a.street_address AS job_street_address,
			   a.city AS job_city,
			   a.state AS job_state,
			   a.zip_code AS job_zip_code,
			   a.country AS job_country
		  FROM job j
		 INNER JOIN profession p
		 	ON j.profession_id = p.profession_id
		 INNER JOIN company c
		 	ON j.company_id = c.company_id
		  LEFT JOIN full_address a
		 	ON j.work_address_id = a.address_id
	),
	contact_phone_number AS (
		SELECT c.contact_id,
			   c.contact_name,
			   p.phone_number,
			   c.address_id,
			   c.relationship_id,
			   c.job_id,
			   c.app_user_username
		  FROM contact c
		 INNER JOIN phone_number p
		 	ON c.phone_number_id = p.phone_number_id
	),
	full_info AS (
		SELECT c.contact_id,
			   c.contact_name,
			   c.phone_number,
			   CONCAT(a.street_address, ', ', a.city, ', ', a.state, ', ', a.zip_code, ', ', a.country) AS address,
			   r.relationship,
			   n.nationality,
			   j.profession,
			   j.company,
			   CONCAT(j.job_street_address, ', ', j.job_city, ', ', j.job_state, ', ', j.job_zip_code, ', ', j.job_country) AS job_address
	  FROM contact_phone_number c
	 INNER JOIN relationship r
	 	ON c.relationship_id = r.relationship_id
	  LEFT JOIN full_address a
	 	ON c.address_id = a.address_id
	 INNER JOIN nationality n
	 	ON c.contact_id = n.contact_id
	  LEFT JOIN jobs j
	 	ON c.job_id = j.job_id
	 WHERE c.app_user_username = app_user_username
	   AND c.contact_name LIKE CONCAT('%', contact_name, '%')
	)
	SELECT *
	  FROM full_info;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE select_contact(IN app_user_username VARCHAR(50), IN contact_id INT)
BEGIN
    WITH full_address AS (
	SELECT a.address_id,
		   a.street_address,
		   c.city,
		   s.state,
		   a.zip_code,
		   ct.country
	  FROM address a
	 INNER JOIN city c
	 	ON a.city_id = c.city_id
	 INNER JOIN state s
	 	ON c.state_id = s.state_id
	 INNER JOIN country ct
	 	ON s.country_id = ct.country_id
	),
	nationality AS (
		SELECT c.contact_id,
			   ct.country AS nationality
		  FROM contact c
		 INNER JOIN country ct
		 	ON c.nationality_id = ct.country_id
	),
	jobs AS (
		SELECT j.job_id,
			   j.work_address_id,
			   p.profession,
			   c.company,
			   a.street_address AS job_street_address,
			   a.city AS job_city,
			   a.state AS job_state,
			   a.zip_code AS job_zip_code,
			   a.country AS job_country
		  FROM job j
		 INNER JOIN profession p
		 	ON j.profession_id = p.profession_id
		 INNER JOIN company c
		 	ON j.company_id = c.company_id
		  LEFT JOIN full_address a
		 	ON j.work_address_id = a.address_id
	),
	contact_phone_number AS (
		SELECT c.contact_id,
			   c.contact_name,
			   p.phone_number,
			   c.address_id,
			   c.relationship_id,
			   c.job_id,
			   c.app_user_username
		  FROM contact c
		 INNER JOIN phone_number p
		 	ON c.phone_number_id = p.phone_number_id
	),
	full_info AS (
		SELECT c.contact_id,
			   c.contact_name,
			   c.phone_number,
			   CONCAT(a.street_address, ', ', a.city, ', ', a.state, ', ', a.zip_code, ', ', a.country) AS address,
			   r.relationship,
			   n.nationality,
			   j.profession,
			   j.company,
			   CONCAT(j.job_street_address, ', ', j.job_city, ', ', j.job_state, ', ', j.job_zip_code, ', ', j.job_country) AS job_address
	  FROM contact_phone_number c
	 INNER JOIN relationship r
	 	ON c.relationship_id = r.relationship_id
	  LEFT JOIN full_address a
	 	ON c.address_id = a.address_id
	 INNER JOIN nationality n
	 	ON c.contact_id = n.contact_id
	  LEFT JOIN jobs j
	 	ON c.job_id = j.job_id
	 WHERE c.app_user_username = app_user_username
	   AND c.contact_id = contact_id
	)
	SELECT *
	  FROM full_info;
END$$

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE select_contact_to_update(IN app_user_username VARCHAR(50), IN contact_id INT)
BEGIN
    WITH full_address AS (
	SELECT a.address_id,
		   a.street_address,
		   c.city,
		   s.state,
		   a.zip_code,
		   ct.country
	  FROM address a
	 INNER JOIN city c
	 	ON a.city_id = c.city_id
	 INNER JOIN state s
	 	ON c.state_id = s.state_id
	 INNER JOIN country ct
	 	ON s.country_id = ct.country_id
	),
	nationality AS (
		SELECT c.contact_id,
			   ct.country AS nationality
		  FROM contact c
		 INNER JOIN country ct
		 	ON c.nationality_id = ct.country_id
	),
	jobs AS (
		SELECT j.job_id,
			   j.work_address_id,
			   p.profession,
			   c.company,
			   a.street_address AS job_street_address,
			   a.city AS job_city,
			   a.state AS job_state,
			   a.zip_code AS job_zip_code,
			   a.country AS job_country
		  FROM job j
		 INNER JOIN profession p
		 	ON j.profession_id = p.profession_id
		 INNER JOIN company c
		 	ON j.company_id = c.company_id
		  LEFT JOIN full_address a
		 	ON j.work_address_id = a.address_id
	),
	contact_phone_number AS (
		SELECT c.contact_id,
			   c.contact_name,
			   p.phone_number,
			   c.address_id,
			   c.relationship_id,
			   c.job_id,
			   c.app_user_username
		  FROM contact c
		 INNER JOIN phone_number p
		 	ON c.phone_number_id = p.phone_number_id
	),
	full_info AS (
		SELECT c.contact_id,
			   c.contact_name,
			   c.phone_number,
			   a.street_address,
			   a.city,
			   a.state,
			   a.zip_code,
			   a.country,
			   r.relationship,
			   n.nationality,
			   j.profession,
			   j.company,
			   j.job_street_address,
			   j.job_city,
			   j.job_state,
			   j.job_zip_code,
			   j.job_country
	  FROM contact_phone_number c
	 INNER JOIN relationship r
	 	ON c.relationship_id = r.relationship_id
	  LEFT JOIN full_address a
	 	ON c.address_id = a.address_id
	 INNER JOIN nationality n
	 	ON c.contact_id = n.contact_id
	  LEFT JOIN jobs j
	 	ON c.job_id = j.job_id
	 WHERE c.app_user_username = app_user_username
	   AND c.contact_id = contact_id
	)
	SELECT *
	  FROM full_info;
END$$

DELIMITER ;