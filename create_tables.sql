CREATE TABLE room_types (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
type_name VARCHAR(40) NOT NULL,
unique(type_name)
);

CREATE TABLE buildings (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
building_name VARCHAR(40) NOT NULL,
unique(building_name)
);

CREATE TABLE status_types (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
status_name VARCHAR(40) NOT NULL,
unique(status_name)
);

CREATE TABLE roles (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
role_name VARCHAR(40) NOT NULL,
unique(role_name)
);

CREATE TABLE person (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
person_name VARCHAR(40) NOT NULL,
address VARCHAR(40) NOT NULL,
unique(person_name,address)
);
CREATE TABLE phones (
person_id INT  NOT NULL,
phone VARCHAR(40) NOT NULL,
PRIMARY KEY(person_id,phone),
FOREIGN KEY (person_id) REFERENCES person(id) on update cascade on delete cascade
);

CREATE TABLE staff (
person_id INT NOT NULL,
role_id INT NOT NULL,
PRIMARY KEY(person_id,role_id),
unique(person_id),
FOREIGN KEY (person_id) REFERENCES person(id) on update cascade on delete cascade,
FOREIGN KEY (role_id) REFERENCES roles(id) on update cascade on delete cascade
);

CREATE TABLE rooms (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
type_id INT NOT NULL,
building_id INT NOT NULL,
floor_num INT NOT NULL,
bed_count INT NOT NULL,
FOREIGN KEY (type_id) REFERENCES room_types(id) on update cascade on delete cascade,
FOREIGN KEY (building_id) REFERENCES buildings(id) on update cascade on delete cascade
);

create TABLE room_price (
room_id int NOT NULL,
price int NOT NULL,
unique(room_id),
foreign key (room_id) references rooms(id) on update cascade on delete cascade
);

CREATE TABLE orders (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
customer_id INT NOT NULL,
room_id INT NOT NULL,
date_in DATE NOT NULL,
date_out DATE NOT NULL,
price INT NOT NULL,
employee_id INT NOT NULL,
unique(room_id,date_in,date_out),
constraint check_dates check(date_in <= date_out),
FOREIGN KEY (customer_id) REFERENCES person(id) on update cascade on delete cascade,
FOREIGN KEY (employee_id) REFERENCES staff(person_id) on update cascade on delete cascade,
FOREIGN KEY (room_id) REFERENCES rooms(id) on update cascade on delete cascade
);

 create TABLE room_status (
 room_id int NOT NULL,
 status_id int NOT NULL,
 change_date datetime default now() NOT NULL,
 PRIMARY KEY(room_id),
 foreign key (room_id) references rooms(id) on update cascade on delete cascade,
 foreign key (status_id) references status_types(id) on update cascade on delete cascade
 );

 create TABLE cleaning_table (
 room_id int NOT NULL,
 clean_start_time datetime default now() NOT NULL,
 clean_end_time datetime ,
 clean_by int NOT NULL,
 PRIMARY KEY(room_id,clean_start_time,clean_by),
 foreign key (room_id) references rooms(id) on update cascade on delete cascade,
 foreign key (clean_by) references staff(person_id) on update cascade on delete cascade
 );

