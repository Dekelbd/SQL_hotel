-- create orders 
call create_order('5','2','1','2021-07-19','2021-07-21');
call create_order('5','3','1','2021-07-19','2021-07-21');
call create_order('6','2','2','2021-07-21','2021-07-25');
call create_order('7','5','1','2021-08-10','2021-08-17');
call create_order('7','6','1','2021-08-10','2021-08-17');
call create_order('7','7','1','2021-08-10','2021-08-15');
call create_order('8','3','1','2021-08-19','2021-08-25');
call create_order('9','10','2','2021-09-02','2021-09-09');
call create_order('9','9','2','2021-09-02','2021-09-09');
call create_order('10','8','1','2021-10-08','2021-10-12');
call create_order('6','7','1','2022-03-01','2022-03-06');
call create_order('5','3','2','2021-08-01','2021-08-06');
call create_order('6','11','2','2021-11-01','2021-11-06');
call create_order('5','11','1','2021-12-01','2021-12-06');
call create_order('7','12','2','2021-07-08','2021-07-16');
call create_order('8','13','2','2021-09-01','2021-09-12');
call create_order('10','14','1','2021-08-11','2021-08-22');
call create_order('10','14','1','2021-07-16','2021-07-20');
call create_order('10','14','2','2023-07-16','2023-07-20');

-- set cleaning data 
call update_cleaning(1,3,"start");
call update_cleaning(1,3,"finish");
call update_cleaning(2,3,"start");
call update_cleaning(2,3,"finish");
call update_cleaning(3,3,"start");
call update_cleaning(3,3,"finish");
call update_cleaning(4,3,"start");
call update_cleaning(4,3,"finish");
call update_cleaning(5,3,"start");
call update_cleaning(5,3,"finish");
call update_cleaning(6,3,"start");
call update_cleaning(6,3,"finish");
call update_cleaning(7,3,"start");
call update_cleaning(7,3,"finish");
call update_cleaning(9,4,"start");
call update_cleaning(9,4,"finish");
call update_cleaning(14,4,"start");
call update_cleaning(14,4,"finish");
call update_cleaning(11,4,"start");
call update_cleaning(11,4,"finish");
call update_cleaning(8,4,"start");
call update_cleaning(8,4,"finish");
call update_cleaning(10,4,"start");
call update_cleaning(10,4,"finish");
call update_cleaning(12,4,"start");
call update_cleaning(12,4,"finish");
call update_cleaning(13,2,"start");
call update_cleaning(13,2,"finish");


-- update room status
call update_room_status(1);
call update_room_status(2);
call update_room_status(3);
call update_room_status(4);
call update_room_status(5);
call update_room_status(6);
call update_room_status(7);
call update_room_status(8);
call update_room_status(9);
call update_room_status(10);
call update_room_status(11);
call update_room_status(12);
call update_room_status(13);
call update_room_status(14);



-- show all rooms status
select rooms.id, room_types.type_name as Room_Type , buildings.building_name as Building_Name, rooms.floor_num as Floor, rooms.bed_count as Bed_Count, status_types.status_name as Room_Status from rooms 
inner join room_status
on room_status.room_id = rooms.id 
inner join status_types 
on room_status.status_id = status_types.id
inner join room_types
on  rooms.type_id =  room_types.id
inner join buildings
on  rooms.building_id =  buildings.id;

-- show 10 most ordered rooms
SELECT room_id, COUNT(orders.room_id) as Order_Count,
 room_types.type_name as Room_Type , buildings.building_name as Building_Name, rooms.floor_num as Floor, rooms.bed_count as Bed_Count
 FROM orders
 inner join rooms on rooms.id = orders.room_id
 inner join buildings on  rooms.building_id =  buildings.id
 inner join room_types on  rooms.type_id =  room_types.id
 GROUP BY  room_id
 ORDER BY COUNT(room_id) desc limit 10;
 
 -- show orders from last 14 days
 select * from orders 
 where date_in >= DATE_ADD(CURDATE(), INTERVAL -14 DAY)
 and orders.date_in <= now();

-- show the employee who cleaned the most
SELECT clean_by, COUNT(clean_by) as Clean_Count, person.person_name as Employee_Name
FROM cleaning_table 
inner join person
on clean_by = person.id
 GROUP BY  clean_by
 ORDER BY COUNT(clean_by) desc limit 1;

-- show ongoing orders
 select orders.id as order_id, person.person_name as Customer_Name from orders 
 inner join person on customer_id = person.id
 where CURDATE() BETWEEN date_in AND date_out;
 
 -- show returning orders
 SELECT  COUNT(orders.customer_id) as Order_Count,person.person_name as Customer_Name
 FROM orders
 inner join person on customer_id = person.id
 GROUP BY  orders.customer_id having  Order_Count >1;
 
 -- show income by month
 select date_format(date_in, '%Y-%m') Date ,SUM(orders.price) Income
 from orders
 group by date_format(date_in, '%Y-%m')
 order by Date


