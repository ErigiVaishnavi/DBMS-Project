/*select * from tc08_customer;
select * from tc08_vehicle;
select * from tc08_claim;
select * from tc08_claim_settlement;
select * from tc08_incident_report;
select * from tc08_premium_payment;
select * from tc08_insurance_company;
select * from tc08_product;
select * from tc08_department;
select * from tc08_office;
select * from tc08_coverage;
select* from tc08_application;
select * from tc08_quote;
select * from tc08_insurance_policy;
select * from tc08_receipt;
select * from tc08_staff;*/

/*1*/
select TC08_customer.*,TC08_vehicle.*
FROM TC08_customer
INNER JOIN TC08_vehicle
ON TC08_customer.cust_id = TC08_vehicle.cust_id
INNER JOIN TC08_claim
ON TC08_customer.cust_id = TC08_claim.cust_id
WHERE TC08_claim.incident_id IS NOT NULL
AND TC08_claim.claim_status LIKE "pending";

/*2*/
SELECT TC08_customer.*
FROM TC08_Customer
inner JOIN TC08_premium_payment
ON TC08_customer.cust_id = TC08_premium_payment.cust_id 
WHERE premium_payment_amount > (SELECT SUM(cust_id) FROM TC08_customer);

/*3*/
select tc08_insurance_company.* from tc08_insurance_company 
inner join tc08_department on tc08_insurance_company.company_name = tc08_department.company_name
inner join tc08_product  on tc08_insurance_company.company_name = tc08_product.company_name
group by company_name
having count( distinct department_name) < count( distinct product_number) and count( distinct company_location) >1;


/*4*/
select tc08_customer.* from tc08_customer,tc08_premium_payment,tc08_incident_report
where (tc08_customer.cust_id= tc08_premium_payment.cust_id and
tc08_customer.cust_id= tc08_incident_report.cust_id and
tc08_incident_report.incident_type like 'ACCIDENT' and 
tc08_premium_payment.receipt_id is null and
tc08_customer.cust_id in (select cust_id from tc08_vehicle group by cust_id having count(cust_id)>1));


/*5*/
Select tc08_premium_payment.cust_id, tc08_premium_payment.premium_payment_amount,  
tc08_vehicle.vehicle_id,  tc08_vehicle.vehicle_number
From tc08_premium_payment
inner join tc08_vehicle
on  tc08_vehicle.cust_id = tc08_premium_payment.cust_id
where (tc08_premium_payment.premium_payment_amount >  tc08_vehicle.vehicle_number);

/*6*/
select tc08_customer.* from tc08_customer where cust_id in (
SELECT distinct(tc08_customer.cust_id)
FROM TC08_customer, TC08_vehicle, TC08_claim  , TC08_coverage , TC08_claim_settlement 
WHERE tc08_vehicle.cust_id = tc08_customer.cust_id AND
      tc08_claim.cust_id = tc08_customer.cust_id AND
	  tc08_claim_settlement.claim_id = tc08_claim.claim_id AND
      tc08_claim.claim_amount < tc08_coverage.coverage_amount AND
      tc08_claim.claim_amount > (tc08_claim_settlement.claim_settlement_id + 
                                       tc08_vehicle.vehicle_id + tc08_claim.claim_id + tc08_customer.cust_id)
);


