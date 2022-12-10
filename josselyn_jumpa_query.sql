--QUERY

--List of Keep Coding's active company vehicles. 
--As one of the vehicles is currently inactive, the list includes only 9 vehicles.

select id_insur_pol,
vehicle_fleet.insurance_companies.ins_comp_name,
purchase_date,
reg_num,
km_num,
vehicle_fleet.fleet_vehicle.id_group,
vehicle_fleet.group_brands.brand_name,
vehicle_fleet.group_brand_model.model_name,
vehicle_fleet.colors.color_name
from vehicle_fleet.fleet_vehicle
inner join vehicle_fleet.insurance_companies
on vehicle_fleet.fleet_vehicle.insur_company = vehicle_fleet.insurance_companies.insur_company
inner join vehicle_fleet.group_brands
on vehicle_fleet.fleet_vehicle.id_brand = vehicle_fleet.group_brands.id_brand
inner join vehicle_fleet.group_brand_model
on vehicle_fleet.fleet_vehicle.id_model = vehicle_fleet.group_brand_model.id_model
inner join vehicle_fleet.colors
on vehicle_fleet.fleet_vehicle.id_color = vehicle_fleet.colors.id_color
where vehicle_status = 'active'; --filter for active vehicles only
