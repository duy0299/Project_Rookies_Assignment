-- create database
CREATE DATABASE IF NOT EXISTS shopdb CHARACTER SET utf8 COLLATE utf8_general_cs;


-- CREATE TABLES
CREATE TABLE product_style(
    id          VARCHAR(20) NOT NULL,
    name        VARCHAR(50) NOT NULL,
    price_root  Decimal(8,2) NOT NULL,
    description VARCHAR(200) NOT NULL,
    status      BIT NOT NULL,
    time_create DATETIME NOT NULL,
    time_update DATETIME NOT NULL
);

CREATE TABLE categories(
    id          VARCHAR(20) NOT NULL,
    name        VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL,
    status      BIT NOT NULL,
    time_create DATETIME NOT NULL,
    time_update DATETIME NOT NULL
);

CREATE TABLE categories_product_style(
    id               VARCHAR(20) NOT NULL,
    product_style_id VARCHAR(20) NOT NULL,
    categories_id    VARCHAR(20) NOT NULL,
    status           BIT NOT NULL,
    time_create DATETIME NOT NULL,
    time_update DATETIME NOT NULL
);

CREATE TABLE size(
    id          VARCHAR(20) NOT NULL,
    name        VARCHAR(50) NOT NULL,
    status      BIT NOT NULL,
    time_create DATETIME NOT NULL,
    time_update DATETIME NOT NULL
);

CREATE TABLE product(
    id          VARCHAR(20) NOT NULL,
    product_style_id VARCHAR(20) NOT NULL,
    size_id     VARCHAR(20) NOT NULL,
    name 		varchar(50) NOT NULL,
    avatar      VARCHAR(50) NOT NULL,
    sale_type 	varchar(10) NOT NULL,
    price_sale 	Decimal(8,2)  NOT NULL default 0,
    quantity 		int  NOT NULL,
    sold_product_quantity 	int  NOT NULL default 0,
    time_create 	datetime NOT NULL,
    time_update 	datetime NOT NULL,
    CONSTRAINT `check_Quantity_Product` CHECK(quantity>0 OR quantity=0),
    CONSTRAINT `check_price_sale_Product` CHECK(price_sale>0 OR price_sale=0),
    CONSTRAINT `check_sale_type_Product` check((sale_type = 'percent') OR (sale_type = 'direct')  OR (sale_type = 'plus')  OR (sale_type = 'not'))
);

CREATE TABLE product_image (
    id 			int NOT NULL AUTO_INCREMENT,
    product_style_id 	varchar(20) NOT NULL ,
    name 		varchar(50) NOT NULL
); 

CREATE TABLE user_info (
    id 			    int NOT NULL AUTO_INCREMENT,
    first_name 	    varchar(20) NOT NULL,
    last_name 	    varchar(20) NOT NULL,
    phone_number 	varchar(15) NOT NULL,
    gender 		    varchar(10) NOT NULL check((gender = 'nam') OR (gender = 'nữ')),
    email 		    varchar(50) NOT NULL,
    avatar 		    varchar(35) NOT NULL,
    status		    varchar(20)  NOT NULL,
    time_create 	datetime NOT NULL,
    time_update 	datetime NOT NULL
); 

CREATE TABLE password (
	  user_id 		int NOT NULL,
	  password 	    varchar(20) NOT NULL,
	  time_create 	datetime NOT NULL,
	  time_update 	datetime NOT NULL
  );
  
CREATE TABLE admin (
	  user_id 		int NOT NULL,
	  status		bit  NOT NULL
  );

CREATE TABLE rating(
    id              int NOT NULL AUTO_INCREMENT,
    product_style_id 	varchar(20) NOT NULL ,
    user_id 		int NOT NULL,
    content 		varchar(200) NOT NULL,
    rating 		    int  NOT NULL,
    status		    varchar(20)  NOT NULL,
    time_create 	datetime NOT NULL,
    time_update 	datetime NOT NULL
);

CREATE TABLE contact (
    id 		    varchar(10) NOT NULL,
    address 	varchar(70) NOT NULL,
    hotline 	varchar(15) NOT NULL,
    email 	    varchar(50) NOT NULL,
    facebook 	varchar(100) NOT NULL,
    time_open  time,
    time_close time,
    time_update datetime NOT NULL,
    view_page		INT 	NOT NULL,
    contact_content 	varchar(400) NOT NULL,
    brand_story 	varchar(500) NOT NULL
);

CREATE TABLE contact_phone (
    id 			    int NOT NULL AUTO_INCREMENT,
    contact_id 	    varchar(10) NOT NULL,
    phone_number 	varchar(15) NOT NULL
);

CREATE TABLE feedback (
    id 			    int NOT NULL AUTO_INCREMENT,
    user_id 		int NOT NULL,
    phone_number 	varchar(15) NOT NULL,
    content 		varchar(500) NOT NULL,
    status 		    varchar(35) NOT NULL,
    time_create 	datetime NOT NULL,
    time_update 	datetime NOT NULL
);

CREATE TABLE wishlist (
    id 			    int NOT NULL AUTO_INCREMENT,
    product_style_id 	varchar(20) NOT NULL ,
    user_id 		int NOT NULL,
    content 		varchar(500) NOT NULL,
    status 		    varchar(35) NOT NULL,
    time_create 	datetime NOT NULL,
    time_update 	datetime NOT NULL
);

CREATE TABLE `order` (
    id 			    varchar(15) NOT NULL,
    email 	        varchar(50) NOT NULL,
    phone_number 	varchar(15) NOT NULL,
    address 	    varchar(100) NOT NULL,
    first_name 	    varchar(20) NOT NULL,
    last_name 	    varchar(20) NOT NULL,
    note            VARCHAR(200),
    status 		    varchar(35) NOT NULL,
    time_create 	datetime NOT NULL,
    time_update 	datetime NOT NULL
);

CREATE TABLE order_item (
    id 			    int NOT NULL AUTO_INCREMENT,
    order_id        varchar(15) NOT NULL,
    product_id      VARCHAR(20) NOT NULL,
    quantity 		int NOT NULL,
    time_create 	datetime NOT NULL,
    time_update 	datetime NOT NULL,
    CONSTRAINT `check_Quantity_order_item` CHECK(quantity>0 OR quantity=0)
);

CREATE TABLE bill (
    id 			    int NOT NULL AUTO_INCREMENT,
    order_id        varchar(15) NOT NULL,
    payment_method  VARCHAR(20) NOT NULL,
    total           Decimal(8,2) NOT NULL, 
    status 		    varchar(35) NOT NULL,
    time_create 	datetime NOT NULL
);


/* Add  Primary key for tables */
ALTER TABLE product_style
    ADD PRIMARY KEY (id);

ALTER TABLE categories
    ADD PRIMARY KEY (id);

ALTER TABLE categories_product_style
    ADD PRIMARY KEY (id);

ALTER TABLE size
    ADD PRIMARY KEY (id);
    
ALTER TABLE product
    ADD PRIMARY KEY (id);

ALTER TABLE product_image
    ADD PRIMARY KEY (id);

ALTER TABLE contact
    ADD PRIMARY KEY (id);

ALTER TABLE phone_contact
    ADD PRIMARY KEY (id);

ALTER TABLE user_info
    ADD PRIMARY KEY (id);

ALTER TABLE `password`
    ADD PRIMARY KEY (user_id);

ALTER TABLE addmin
    ADD PRIMARY KEY (user_id);

ALTER TABLE rating
    ADD PRIMARY KEY (id);

ALTER TABLE feedback
    ADD PRIMARY KEY (id);

ALTER TABLE wishlist
    ADD PRIMARY KEY (id);

ALTER TABLE `order`
    ADD PRIMARY KEY (id);

ALTER TABLE order_item
    ADD CONSTRAINT PRIMARY KEY (id);

ALTER TABLE bill
    ADD CONSTRAINT PRIMARY KEY (id);


/* Add Foreign key for tables */
ALTER TABLE `categories_product_style`
    ADD CONSTRAINT `pk_CPS_product_style` FOREIGN KEY (`product_style_id`) REFERENCES `product_style` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `pk_CPS_categories` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `product`
    ADD CONSTRAINT `pk_product_size` FOREIGN KEY (`size_id`) REFERENCES `size` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `product_image`
    ADD CONSTRAINT `pk_product_image_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `password`
    ADD CONSTRAINT `pk_password_user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `addmin`
    ADD CONSTRAINT `pk_addmin_user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `phone_contact`
    ADD CONSTRAINT `pk_phone_contact_contact` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `rating`
    ADD CONSTRAINT `pk_rating_product_style` FOREIGN KEY (`product_style_id`) REFERENCES `product_style` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `pk_rating_user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `feedback`
    ADD CONSTRAINT `pk_feedback_user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `wishlist`
    ADD CONSTRAINT `pk_wishlist_product_style` FOREIGN KEY (`product_style_id`) REFERENCES `product_style` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `pk_wishlist_user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `order_item`
    ADD CONSTRAINT `pk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `pk_order_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `bill`
    ADD CONSTRAINT `pk_bill_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)  ON DELETE CASCADE ON UPDATE CASCADE;
INSERT INTO contact(id, address, hotline, email, facebook, time_open, time_close, time_update) 
values('root', '9/25 thống nhất, phường 15, quận gò vấp', '0372466127', 'hoperay000@gmail.com', 'https://www.facebook.com/', '8:00:00' , '20:00:00', '2022-03-15 13:50:33');


