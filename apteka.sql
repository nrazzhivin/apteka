CREATE DATABASE pharmacy_net
	use pharmacy_net;

CREATE TABLE pharmacies(
	pharm_num serial PRIMARY KEY, 
	address text NOT NULL,
	number integer NOT NULL,
	nearest_metropolitan text NOT NULL);
	
CREATE TABLE medicines(
	med_num serial PRIMARY KEY,
	name text UNIQUE NOT NULL,
	dosage integer NOT NULL,
	amount integer,
	producer text NOT NULL,
	need_recept text NOT NULL check(need_recept in ('yes', 'no')),
	category text NOT NULL,
	price integer NOT NULL,
	cat_num integer
	);

CREATE TABLE pharmacists(
	pharmst_num serial PRIMARY KEY,
	last_name text NOT NULL,
	first_name text NOT NULL,
	second_name text,
	birthday date NOT NULL,
	inn integer NOT NULL,
	series_and_number_of_passport integer NOT NULL,
	pharm_id integer NOT NULL,
	
	CONSTRAINT pt_pharm_num FOREIGN KEY (pharm_id) 
                    REFERENCES pharmacies(pharm_num)
	);
	
CREATE TABLE presence_info(
	pi_num serial PRIMARY KEY,
	pharm_id integer NOT NULL,
	med_id integer NOT NULL,
	UNIQUE (pharm_id, med_id),	
	number_of_packages integer NOT NULL,
	
	CONSTRAINT pi_pharm_num FOREIGN KEY (pharm_id) 
            REFERENCES pharmacies(pharm_num),
	CONSTRAINT pi_med_num FOREIGN KEY (med_id) 
			REFERENCES medicines(med_num)
	);

CREATE TABLE sale_info(
	si_num serial PRIMARY KEY,
	pharm_id integer NOT NULL,
	med_id integer NOT NULL,
	pharmasist_id integer NOT NULL,
	date_of_sale date NOT NULL,
	number_of_packages integer NOT NULL,
	
	CONSTRAINT si_pharm_num FOREIGN KEY (pharm_id) 
            REFERENCES pharmacies(pharm_num),
	CONSTRAINT si_med_num FOREIGN KEY (med_id) 
			REFERENCES medicines(med_num),
	CONSTRAINT si_pharst_num FOREIGN KEY (pharmasist_id) 
			REFERENCES pharmacists(pharmst_num)
);

CREATE TABLE medcateg(
	medcat_num serial PRIMARY KEY,
	medcat_name text NOT NULL,	
	medcat_id integer NOT NULL,

	CONSTRAINT mc_med_num FOREIGN KEY (medcat_id) 
			REFERENCES medicines(med_num)
);