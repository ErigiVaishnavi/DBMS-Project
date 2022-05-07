create database TC08_insurance_company; 
use TC08_insurance_company; 

create table TC08_customer( 
cust_id varchar(20) primary key,
cust_fname varchar(20) not null,
cust_lname varchar(20) ,
cust_dob date,
cust_gender char(5),
cust_address varchar(40),
cust_mob_number varchar(20)  not null,
cust_email varchar(30),
cust_passport_number varchar(30) ,
cust_marital_status char(10),
cust_pps_number varchar(20) );

create table TC08_vehicle(
vehicle_id varchar(20) primary key,
cust_id varchar(20)  not null,
policy_id varchar(20),
vehicle_registration_number varchar(20) not null,
vehicle_value varchar(10),
vehicle_type varchar(20),
vehicle_size varchar(10),
vehicle_number_of_seat integer,
vehicle_manufacturer varchar(20),
vehicle_engine_number integer,
vehicle_chasis_number integer,
vehicle_number varchar(30) not null,
vehicle_model_number varchar(30));
 
CREATE table TC08_claim(
claim_id varchar(20)  primary key,
cust_id varchar(20)   not null,
agreement_id varchar(20)   not null,
claim_amount int  ,
incident_id varchar(20)  not null,
date_of_claim date  not null,
damage_type varchar(20)  not null,
claim_status char(10)  not null);

create table TC08_claim_settlement(
claim_settlement_id varchar(20)  primary key,
claim_id varchar(20)  not null,
cust_id varchar(20)  not null,
vehicle_id varchar(20)  not null,
date_settled date,
amount_paid int,
coverage_id varchar(20)  not null);

create table TC08_incident_report (
incident_report_id varchar(20) primary key,
cust_id varchar(20)  not null,
incident_inspector varchar(30),
incident_cost integer,
incident_type char(20)  not null,
incident_date date,
incident_report_description varchar(100));

create table TC08_application(
application_id varchar(20) primary key,
customer_id varchar(20) not null,
vehicle_id varchar(20) not null,
application_status char(20) not null,
coverage varchar(60) not null);

create table TC08_insurance_policy(
agreement_id varchar(20) primary key,
application_id varchar(20) not null,
cust_id varchar(20) not null,
department_name varchar(20),
policy_number varchar(20) not null,
start_date date,
expiry_date date,
term_condition_description varchar(100));

create table TC08_premium_payment
(premium_payment_id varchar(20) primary key,
cust_id varchar(20) not null,
policy_number varchar(20) not null,
premium_payment_schedule date not null,
premium_payment_amount integer not null,
receipt_id varchar(20) );

create table TC08_insurance_company(
company_name varchar(40)primary key,
company_address varchar(40) ,
company_contact_number integer ,
company_fax integer ,
company_email varchar(30) ,
company_website varchar(30),
company_location varchar(30) ,
company_department_name varchar(30) ,
company_office_name varchar(30) );

create table TC08_staff(
staff_id varchar(20) primary key,
company_name varchar(40)  not null,
staff_fname varchar(10) not null,
staff_lname varchar(10),
staff_address varchar(20),
staff_contact varchar(15) not null,
staff_gender char(10),
staff_marital_status char(15),
staff_nationality char(15),
staff_qualification varchar(20),
staff_allowance integer,
staff_pps_number integer);

create table TC08_product(
product_number varchar(20) primary key,
company_name varchar(40) not null,
product_price integer ,
product_type char(30));

create table TC08_department(
department_name varchar(20) primary key,
company_name varchar(40) not null,
office varchar(20) ,
contact_information varchar(20),
department_staff varchar(50) ,
department_leader varchar(20));

create table TC08_office(
office_name varchar (20) primary key,
office_leader varchar (20) not null,
contact_information varchar (20) not null,
address varchar (20) not null,
admin_cost integer ,
department_name varchar (20) not null,
company_name  varchar (40) not null);

create table TC08_coverage(
coverage_id varchar(20) primary key,
coverage_amount integer not null,
coverage_type char(50) not null,
coverage_level char(50) not null,
product_id varchar(20) not null,
coverage_description varchar(100) not null,
coverage_terms varchar(50) not null,
company_name varchar(40) not null);
 
create table TC08_quote(
quote_id varchar (20) primary key,
issue_date date not null,
valid_from_date date not null,
valid_till_date date not null,
description varchar (100) ,
product_id varchar (20) not null,
coverage_level varchar (20) not null,
application_id varchar (20) not null,
cust_id varchar (20) not null);
  
  -- alter table to assign previously unassigned foreign key relations

alter table TC08_vehicle 
add foreign key (cust_id) references TC08_customer (cust_id);

alter table TC08_claim
add foreign key (cust_id) references TC08_customer (cust_id);

set foreign_key_checks=0;

alter table TC08_claim_settlement
add foreign key (cust_id) references TC08_customer (cust_id),
add foreign key (claim_id) references TC08_claim (claim_id);

alter table TC08_incident_report
add foreign key (cust_id) references TC08_customer (cust_id);

alter table tc08_application
add foreign key(customer_id) references tc08_customer(cust_id);

alter table TC08_insurance_policy
add foreign key (cust_id) references TC08_customer (cust_id);

alter table TC08_insurance_policy
add foreign key(application_id) references TC08_application(application_id);

alter table tc08_premium_payment
add foreign key(cust_id) references tc08_customer(cust_id);


alter table tc08_staff
add foreign key(company_name) references tc08_insurance_company(company_name);

alter table tc08_product
add foreign key(company_name) references tc08_insurance_company(company_name);

alter table tc08_department
add foreign key(company_name) references tc08_insurance_company(company_name);

alter table tc08_office
add foreign key(department_name) references tc08_department(department_name);

alter table tc08_office
add foreign key(company_name) references tc08_insurance_company(company_name);

alter table tc08_coverage
add foreign key(company_name) references tc08_insurance_company(company_name);


alter table tc08_quote
add foreign key(cust_id) references tc08_customer(cust_id),
add foreign key(application_id) references tc08_application(application_id);







      
      
