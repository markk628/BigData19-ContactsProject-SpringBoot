CREATE TABLE country (
	country_id 	INT AUTO_INCREMENT,
	country 	VARCHAR(20) NOT NULL UNIQUE,
	PRIMARY KEY (country_id)
);

CREATE TABLE state (
	state_id 	INT AUTO_INCREMENT,
	state 		VARCHAR(20) NOT NULL,
	country_id 	INT NOT NULL,
	PRIMARY KEY (state_id),
	FOREIGN KEY (country_id)
			REFERENCES country(country_id)
);

CREATE TABLE city (
	city_id 	INT AUTO_INCREMENT,
	city 		VARCHAR(20) NOT NULL,
	state_id 	INT NOT NULL,
	PRIMARY KEY (city_id),
	FOREIGN KEY (state_id)
			REFERENCES state(state_id)
);

CREATE TABLE address (
	address_id 	    INT AUTO_INCREMENT,
	street_address 	VARCHAR(50) NOT NULL,
	city_id 	    INT NOT NULL,
	zip_code 	    VARCHAR(8),
	PRIMARY KEY (address_id),
	FOREIGN KEY (city_id)
			REFERENCES city(city_id)
);

CREATE TABLE relationship (
	relationship_id 	INT AUTO_INCREMENT,
	relationship 		VARCHAR(20) NOT NULL UNIQUE,
	PRIMARY KEY (relationship_id)
);

CREATE TABLE company (
	company_id 	INT AUTO_INCREMENT,
	company 	VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY (company_id)
);

CREATE TABLE profession (
	profession_id		INT AUTO_INCREMENT,
	profession			VARCHAR(20) NOT NULL UNIQUE,
	PRIMARY KEY (profession_id)
);

CREATE TABLE job (
	job_id				INT AUTO_INCREMENT,
	profession_id		INT NOT NULL,
	company_id 			INT NOT NULL,
	work_address_id		INT,
	PRIMARY KEY (job_id),
	FOREIGN KEY (profession_id)
			REFERENCES profession(profession_id),
	FOREIGN KEY (company_id)
			REFERENCES company(company_id),
	FOREIGN KEY (work_address_id)
			REFERENCES address(address_id)
);

-- TODO encrypt password
CREATE TABLE app_user (
	app_user_username 	VARCHAR(50),
	app_user_email 		VARCHAR(50) NOT NULL UNIQUE,
	app_user_password 	VARCHAR(100) NOT NULL,
	PRIMARY KEY (app_user_username)
);

CREATE TABLE phone_number (
	phone_number_id INT AUTO_INCREMENT,
	phone_number 	VARCHAR(11) NOT NULL UNIQUE,
	PRIMARY KEY (phone_number_id)
);

-- TODO add contact_picture VARCHAR
CREATE TABLE contact (
	contact_id 			INT AUTO_INCREMENT,
	contact_name 		VARCHAR(30) NOT NULL,
	phone_number_id 	INT NOT NULL,
	address_id 			INT,
	relationship_id 	INT NOT NULL,
	nationality_id 		INT NOT NULL,
	job_id 				INT,
	app_user_username 	VARCHAR(50) NOT NULL,
	PRIMARY KEY (contact_id),
	FOREIGN KEY (phone_number_id)
			REFERENCES phone_number(phone_number_id),
	FOREIGN KEY (address_id)
			REFERENCES address(address_id),
	FOREIGN KEY (relationship_id)
			REFERENCES relationship(relationship_id),
	FOREIGN KEY (nationality_id)
			REFERENCES country(country_id),
	FOREIGN KEY (job_id)
			REFERENCES job(job_id),
	FOREIGN KEY (app_user_username)
			REFERENCES app_user(app_user_username)
);