-- function for retreuving room status id by room id
SET GLOBAL log_bin_trust_function_creators = 1;
 DELIMITER $$
create function get_room_status(
in_room_id int)  RETURNS INTEGER
begin
declare current_status int default 0;
select status_id into current_status from room_status where room_id = in_room_id;
return current_status;
end$$
 DELIMITER ;