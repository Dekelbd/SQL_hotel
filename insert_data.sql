-- values of the hotel propeties
insert into room_types (type_name)
values ('normal'),('suite'),('superior');

insert into status_types (status_name)
values ('free'),('occupied'),('need cleaning');

insert into buildings (building_name)
values ('star'),('diamond'),('lolipop');

insert into roles (role_name)
values ('valet'),('receptionist');

-- bulk data (employees info and roles)
insert into person (person_name,address)
values ('ofer elfassi','tel aviv, cordovero 20'),('dekel ben david','givataim, hod 12'),
('marselo shichman',' jerusalem, habonim 2'),('avivit levi','ranana, glik 28')
,('amit rash','kiryat gat, zof 55'),('igal hofner','givataim, sirkin 5'),
('itshak nodler','ranana, habonim 8'),('riva shalom','ariel, morag 23'),
('yonit rosho','hod hasharon, bazelet 2'),('moshe mosh','haifa, herzel 22');

insert into phones (person_id,phone)
values (1,'052-869-857'),(2,'055-333-222'),(3,'056-456-276'),(4,'053-234-507'),
(1,'050-889-886'),(2,'055-444-857'),(3,'051-545-887'),(4,'055-222-575')
,(3,'058-152-854'),(4,'052-224-262');

insert into staff (person_id,role_id)
values (1,2),(2,2),(3,1),(4,1);

-- bulk data (rooms and prices)
insert into rooms (type_id,building_id,floor_num,bed_count)
values (1,1,2,3),(2,1,1,2),(1,3,4,3),(3,1,6,4),(1,2,5,2),(2,2,8,2),(3,3,3,3),(3,2,3,2),(2,3,4,5),(2,1,5,2),
(1,2,5,3),(2,2,1,2),(3,1,4,5),(2,1,5,5);

insert into room_price(room_id,price)
values (1,2500),(2,5500),(3,3200),(4,5400),(5,4000),(6,4535),(7,5444),(8,5003),(9,6700),(10,8200)
,(11,2000),(12,7500),(13,4200),(14,1800);

-- bulk data (set all rooms to be free)
insert into room_status (room_id,status_id)
values (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1);

