-- triger for ensuring there will be no overlaping dated for the same room in the ordrs table
DELIMITER $$
CREATE TRIGGER test_dates
BEFORE INSERT ON orders
FOR EACH ROW 
BEGIN
  IF EXISTS ( SELECT * FROM orders as b 
                    WHERE
                        NEW.room_id = b.room_id
                        AND ((NEW.date_in > b.date_in
                        AND NEW.date_in < b.date_out) 
                        OR
                        (NEW.date_in < b.date_in
                        AND NEW.date_in > b.date_in
                        ))
                        ) 
  THEN
   SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Warning: dates overlap!';   
  END IF;
END$$
DELIMITER ;

-- DROP TRIGGER test_dates;
