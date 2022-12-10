--SCHEME creation
create SCHEMA vehicle_fleet AUTHORIZATION qmtfaidw;

-- TABLES CREATION AND CONSTRAINTS


create table vehicle_fleet.business_group(

	id_group VARCHAR(10) not null, --PK
	group_name VARCHAR(50) not null 
);


alter table vehicle_fleet.business_group
add constraint group_pk primary key (id_group);



create table vehicle_fleet.group_brands(

	id_brand VARCHAR(10) not null, --PK
	brand_name VARCHAR(50) not null, --PK
	id_group VARCHAR(10) not null -- FK 
);


alter table vehicle_fleet.group_brands
add constraint brand_pk primary key (id_brand,brand_name);

alter table vehicle_fleet.group_brands
add constraint brand_un unique (id_brand);

alter table vehicle_fleet.group_brands
add constraint brand_FK foreign key (id_group)
references vehicle_fleet.business_group (id_group);



create table vehicle_fleet.group_brand_model(

	id_group VARCHAR(10) not null, --PK,FK
	id_brand VARCHAR(10) not null, --PK,FK
	id_model VARCHAR(10) not null, -- PK 
	model_name VARCHAR(50)not null
);


alter table vehicle_fleet.group_brand_model
add constraint model_pk primary key (id_group,id_brand,id_model);

alter table vehicle_fleet.group_brand_model
add constraint group_FK foreign key (id_group)
references vehicle_fleet.business_group (id_group);

alter table vehicle_fleet.group_brand_model
add constraint id_brand_FK foreign key (id_brand)
references vehicle_fleet.group_brands (id_brand);

alter table vehicle_fleet.group_brand_model
add constraint model_un unique (id_model);



create table vehicle_fleet.insurance_companies(

	insur_company VARCHAR(10) not null, --PK
	ins_comp_name VARCHAR(50) not null, --PK
	ins_comp_CIF VARCHAR(20) not null -- PK 
);


alter table vehicle_fleet.insurance_companies
add constraint insur_comp_pk primary key (insur_company,ins_comp_name,ins_comp_CIF);

alter table vehicle_fleet.insurance_companies
add constraint insur_comp_un unique (insur_company);



create table vehicle_fleet.insurance_types(

	insur_type VARCHAR(10) not null, --PK
	insur_name VARCHAR(100) not null 
);


alter table vehicle_fleet.insurance_types
add constraint insur_type_pk primary key (insur_type);



create table vehicle_fleet.vehicle_insurance(

	id_insur_pol VARCHAR(20) not null, --PK
	insur_company VARCHAR(10) not null, --FK
	insur_type VARCHAR(10) not null, -- FK 
	start_date DATE not null,
	end_date DATE not null
	
);


alter table vehicle_fleet.vehicle_insurance
add constraint vehicle_insur primary key (id_insur_pol);

alter table vehicle_fleet.vehicle_insurance
add constraint insur_company_FK foreign key (insur_company)
references vehicle_fleet.insurance_companies (insur_company);

alter table vehicle_fleet.vehicle_insurance
add constraint insur_type_FK foreign key (insur_type)
references vehicle_fleet.insurance_types (insur_type);

alter table vehicle_fleet.vehicle_insurance
add constraint date_check check (end_date > start_date);



create table vehicle_fleet.colors(

	id_color VARCHAR(10) not null, --PK
	color_name VARCHAR(50) not null 
);


alter table vehicle_fleet.colors
add constraint id_color_pk primary key (id_color);



create table vehicle_fleet.status(

	vehicle_status VARCHAR(20) not null, --PK
	description VARCHAR(50) not null 
);


alter table vehicle_fleet.status
add constraint status_pk primary key (vehicle_status);


create table vehicle_fleet.fleet_vehicle(

	id_vehicle VARCHAR(10) not null, --PK
	id_insur_pol VARCHAR(20) not null, --PK,FK
	purchase_date DATE not null, -- PK 
	id_group VARCHAR(10)not null, --FK
	id_brand VARCHAR(10)not null, --FK
	id_model VARCHAR(10)not null, --FK
	id_color VARCHAR(10)not null, --FK
	insur_company VARCHAR(10)not null, --FK
	reg_num VARCHAR(20)not null,
	km_num INTEGER not null,
	vehicle_status VARCHAR(20)not null, --FK
	additional_comment VARCHAR(100)
);


alter table vehicle_fleet.fleet_vehicle
add constraint fleet_vehicle_pk primary key (id_vehicle,id_insur_pol,purchase_date);

alter table vehicle_fleet.fleet_vehicle
add constraint insur_pol_FK foreign key (id_insur_pol)
references vehicle_fleet.vehicle_insurance (id_insur_pol);

alter table vehicle_fleet.fleet_vehicle
add constraint id_group_FK foreign key (id_group)
references vehicle_fleet.business_group (id_group);

alter table vehicle_fleet.fleet_vehicle
add constraint id_brand_FK foreign key (id_brand)
references vehicle_fleet.group_brands (id_brand);

alter table vehicle_fleet.fleet_vehicle
add constraint id_model_FK foreign key (id_model)
references vehicle_fleet.group_brand_model (id_model);

alter table vehicle_fleet.fleet_vehicle
add constraint id_color_FK foreign key (id_color)
references vehicle_fleet.colors (id_color);

alter table vehicle_fleet.fleet_vehicle
add constraint insur_company_FK foreign key (insur_company)
references vehicle_fleet.insurance_companies (insur_company);

alter table vehicle_fleet.fleet_vehicle
add constraint vehicle_status_FK foreign key (vehicle_status)
references vehicle_fleet.status (vehicle_status);

alter table vehicle_fleet.fleet_vehicle
add constraint id_vehicle_un unique (id_vehicle);



create table vehicle_fleet.vehicle_service_types(

	service_type VARCHAR(50) not null, --PK
	service_description VARCHAR(100)not null 
);


alter table vehicle_fleet.vehicle_service_types
add constraint service_type_pk primary key (service_type);



create table vehicle_fleet.currency(

	id_currency VARCHAR(10) not null, --PK
	currency_name VARCHAR(20)not null 
);


alter table vehicle_fleet.currency
add constraint id_currency_pk primary key (id_currency);



create table vehicle_fleet.vehicle_service_historical(

	id_vehicle VARCHAR(10) not null, --PK,FK
	service_type VARCHAR(50) not null, --PK,FK
	service_date DATE not null, -- PK 
	id_currency VARCHAR(10)not null, --FK
	amount NUMERIC(8,2)not null, 
	km_service INTEGER not null 
	
);


alter table vehicle_fleet.vehicle_service_historical
add constraint service_historical_pk primary key (id_vehicle,service_type,service_date);

alter table vehicle_fleet.vehicle_service_historical
add constraint id_vehicle_FK foreign key (id_vehicle)
references vehicle_fleet.fleet_vehicle (id_vehicle);

alter table vehicle_fleet.vehicle_service_historical
add constraint service_type_FK foreign key (service_type)
references vehicle_fleet.vehicle_service_types (service_type);

alter table vehicle_fleet.vehicle_service_historical
add constraint id_currency_FK foreign key (id_currency)
references vehicle_fleet.currency (id_currency);



-- DATA INSERTION

--TABLE business_group
insert into vehicle_fleet.business_group
(id_group,group_name)
values ('VAN','Volkswagen Group');

insert into vehicle_fleet.business_group
(id_group,group_name)
values ('HYU','Hyundai Group');

insert into vehicle_fleet.business_group
(id_group,group_name)
values ('RNI','Renault Nissan Group');


--TABLE group_brands

insert into vehicle_fleet.group_brands
(id_brand,brand_name,id_group)
values ('VW','Volkswagen','VAN');

insert into vehicle_fleet.group_brands
(id_brand,brand_name,id_group)
values ('SKO','Skoda','VAN');

insert into vehicle_fleet.group_brands
(id_brand,brand_name,id_group)
values ('KIA','Kia','HYU');

insert into vehicle_fleet.group_brands
(id_brand,brand_name,id_group)
values ('NIS','Nissan','RNI');

insert into vehicle_fleet.group_brands
(id_brand,brand_name,id_group)
values ('REN','Renault','RNI');

--TABLE group_brand_model

insert into vehicle_fleet.group_brand_model
(id_group,id_brand,id_model,model_name)
values ('VAN','VW','POL','Polo');

insert into vehicle_fleet.group_brand_model
(id_group,id_brand,id_model,model_name)
values ('VAN','VW','NIV','Nivus');

insert into vehicle_fleet.group_brand_model
(id_group,id_brand,id_model,model_name)
values ('VAN','SKO','OCT','Octavia');

insert into vehicle_fleet.group_brand_model
(id_group,id_brand,id_model,model_name)
values ('VAN','SKO','FAB','Fabia');

insert into vehicle_fleet.group_brand_model
(id_group,id_brand,id_model,model_name)
values ('HYU','KIA','SPO','Sportage');

insert into vehicle_fleet.group_brand_model
(id_group,id_brand,id_model,model_name)
values ('RNI','NIS','JUK','Juke');

insert into vehicle_fleet.group_brand_model
(id_group,id_brand,id_model,model_name)
values ('RNI','REN','AUS','Austral');


--TABLE insurance_companies

insert into vehicle_fleet.insurance_companies
(insur_company,ins_comp_name,ins_comp_cif)
values ('MPF','Mapfre Seguros','A28141935');

insert into vehicle_fleet.insurance_companies
(insur_company,ins_comp_name,ins_comp_cif)
values ('AXA','AXA Seguros','A60917978');


--TABLE insurance_types

insert into vehicle_fleet.insurance_types
(insur_type,insur_name)
values ('liab','liability insurance');


insert into vehicle_fleet.insurance_types
(insur_type,insur_name)
values ('liab_col','liability and collision coverage');


--TABLE vehicle_insurance

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('100817','MPF','liab','2019-01-27','2025-01-25');

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('110845','MPF','liab','2019-09-08','2025-09-06');

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('653172','MPF','liab','2019-11-13','2025-11-11');

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('715248','MPF','liab','2019-12-02','2025-11-30');

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('749801','MPF','liab','2020-01-22','2026-01-20');

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('831743','AXA','liab_col','2021-03-04','2027-03-03');

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('879164','AXA','liab_col','2021-09-12','2027-09-11');

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('918567','AXA','liab_col','2021-12-17','2027-12-16');

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('925241','AXA','liab_col','2022-02-27','2028-02-26');

insert into vehicle_fleet.vehicle_insurance
(id_insur_pol,insur_company,insur_type,start_date,end_date)
values ('946152','AXA','liab_col','2022-10-15','2028-10-13');


-- TABLE colors

insert into vehicle_fleet.colors
(id_color,color_name)
values ('white','full white');

insert into vehicle_fleet.colors
(id_color,color_name)
values ('black','full black');

insert into vehicle_fleet.colors
(id_color,color_name)
values ('blue','full blue');

insert into vehicle_fleet.colors
(id_color,color_name)
values ('d_grey','full dark grey');

insert into vehicle_fleet.colors
(id_color,color_name)
values ('l_grey','full light grey');


--TABLE status

insert into vehicle_fleet.status
(vehicle_status,description)
values ('active','vehicle suitable for use');

insert into vehicle_fleet.status
(vehicle_status,description)
values ('inactive','vehicle not suitable, under repair');


--TABLE fleet vehicle

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('001','100817','2019-01-20','VAN','VW','POL','black','MPF','0843JWC',45000,'active');

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('002','110845','2019-09-01','VAN','VW','NIV','l_grey','MPF','1152KFP',40000,'active');

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('003','653172','2019-11-06','VAN','SKO','OCT','blue','MPF','1274KPL',38000,'active');

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('004','715248','2019-11-25','VAN','SKO','FAB','d_grey','MPF','1368KRW',38000,'active');

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('005','749801','2020-01-15','HYU','KIA','SPO','white','MPF','1509KSD',33000,'inactive');

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('006','831743','2021-02-25','RNI','NIS','JUK','d_grey','AXA','2124KZY',20000,'active');

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('007','879164','2021-09-05','RNI','NIS','JUK','white','AXA','2301LDS',16000,'active');

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('008','918567','2021-12-10','RNI','REN','AUS','white','AXA','2368LFN',12000,'active');

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('009','925241','2022-02-20','RNI','REN','AUS','blue','AXA','3176LTG',8000,'active');

insert into vehicle_fleet.fleet_vehicle
(id_vehicle,id_insur_pol,purchase_date,id_group,id_brand,id_model,
id_color,insur_company,reg_num,km_num,vehicle_status)

values ('010','946152','2022-10-08','VAN','VW','POL','black','AXA','4017LWH',2000,'active');


--TABLE vehicle_service_types

insert into vehicle_fleet.vehicle_service_types
(service_type,service_description)
values ('periodic_general','general  vehicle check up every 10000 - 15000 KM');

insert into vehicle_fleet.vehicle_service_types
(service_type,service_description)
values ('preventive _specific','check up of specific component');


--TABLE currency

insert into vehicle_fleet.currency
(id_currency,currency_name)
values ('EUR','Euro');

insert into vehicle_fleet.currency
(id_currency,currency_name)
values ('USD','U.S Dollar');


-- TABLE vehicle_service_historical

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('001','periodic_general','2020-01-27','EUR',165.50,15000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('001','periodic_general','2021-01-26','EUR',165.50,30000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('001','periodic_general','2022-01-26','EUR',165.50,45000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('002','periodic_general','2020-10-12','EUR',165.50,15000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('002','periodic_general','2021-12-13','EUR',165.50,30000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('003','periodic_general','2020-11-26','EUR',165.50,15000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('003','periodic_general','2022-01-27','EUR',165.50,30000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('004','periodic_general','2020-12-06','EUR',165.50,15000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('004','periodic_general','2022-02-06','EUR',165.50,30000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('005','periodic_general','2021-02-05','EUR',165.50,15000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('005','periodic_general','2022-02-10','EUR',165.50,30000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('005','preventive _specific','2022-12-03','EUR',100.75,33000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('006','periodic_general','2022-05-20','EUR',160.50,15000);

insert into vehicle_fleet.vehicle_service_historical
(id_vehicle,service_type,service_date,id_currency,amount,km_service)

values ('007','periodic_general','2022-10-17','USD',162.50,15000);



