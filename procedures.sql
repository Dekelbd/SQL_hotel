-- procedure for order creation - 
-- ensure only recepioniest will set the order and calculate total price
DELIMITER $$
create procedure create_order(
in in_client_id INT,
in in_room_id INT,
in in_employee_id INT,
in in_in_date DATE,
in in_out_date DATE)
begin
declare price_per_day int default 0;
declare total_days int default 0;
  IF EXISTS ( SELECT * FROM staff as s 
					inner join roles on roles.id = s.role_id
                    and roles.role_name = "receptionist"
                    WHERE
						s.person_id = in_employee_id)
                        then
select DATEDIFF(in_out_date,in_in_date) into total_days;
select price into price_per_day from room_price where room_id = in_room_id;
insert into orders (customer_id,room_id,date_in,date_out,price,employee_id)
VALUES (in_client_id,in_room_id,in_in_date,in_out_date,(price_per_day*total_days),in_employee_id);
END IF;
end $$
DELIMITER ;


-- procedure for updating room cleaning status
-- ensure only valet staf member will clean the room 
-- updates room start cleaning time and end cleaning time
-- update room status table on finish cleaning
DELIMITER $$
create procedure update_cleaning(
in in_room_id INT,
in in_employee_id INT,in in_clean_state varchar(10))
begin
  IF EXISTS ( SELECT * FROM staff as s 
					inner join roles on roles.id = s.role_id
                    and roles.role_name = "valet"
                    WHERE
						s.person_id = in_employee_id)
                        then
								if(in_clean_state = "start")
								then
									insert into cleaning_table(room_id,clean_by,clean_end_time)
									values (in_room_id,in_employee_id,null);
								END IF;
								if(in_clean_state = "finish")
								then
									update cleaning_table
									set clean_end_time = now()
									where room_id=in_room_id and clean_by=in_employee_id and clean_end_time is null;
									INSERT INTO room_status (room_id, change_date, status_id)
                                    VALUES(in_room_id, now(), 1) ON DUPLICATE KEY UPDATE
									change_date = now() ,status_id = 1;
								END IF;
END IF;
end $$
DELIMITER ;


-- procedure for updating room staus
-- updating room status based on wether the room is reserved for the current date
-- set status to ocupied if room is ocupied and set to fneed cleaning if room is empty
DELIMITER $$
create procedure update_room_status(
in in_room_id INT)
begin
  IF EXISTS ( SELECT * FROM orders as o 
                    WHERE
						o.room_id = in_room_id
                        and CURDATE() BETWEEN o.date_in AND o.date_out)
 then
 INSERT INTO room_status (room_id, change_date, status_id) 
 VALUES(in_room_id, now(), 2) ON DUPLICATE KEY UPDATE
change_date = now() ,status_id = 2; -- ocupied
else
 INSERT INTO room_status (room_id, change_date, status_id) 
 VALUES(in_room_id, now(), 3) ON DUPLICATE KEY UPDATE
change_date = now() ,status_id = 3; -- free waiting for clean
END IF;
end $$
DELIMITER ;
