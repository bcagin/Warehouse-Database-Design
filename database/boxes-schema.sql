--------------------
-----  Users  ------
--------------------

-- Warehouse managers
CREATE USER warehouse_manager 
    WITH 
        createrole 
        replication 
        createdb 
        superuser
    PASSWORD 'jw8s0F4';


-- Database Creation 
DROP DATABASE IF EXISTS boxes;
CREATE DATABASE boxes OWNER warehouse_manager ENCODING = 'UTF8';
COMMENT ON DATABASE boxes IS 'Database for managing boxes application of warehouse 
    management and e-commerce';

\connect boxes;

-- Create a new Schema
DROP SCHEMA IF EXISTS warehouse CASCADE;
CREATE SCHEMA warehouse;
    
-- This is needed to use the uuid type
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


--------------------
-- Custom Domains --
--------------------
CREATE DOMAIN warehouse.password AS VARCHAR(254) 
    CONSTRAINT proper_password CHECK (((VALUE)::text~* '[A-Za-z0-9._%!]{8,}'::text));
COMMENT ON DOMAIN warehouse.password IS 'Domain used for user passwords';

CREATE DOMAIN warehouse.email_address AS VARCHAR(254) 
    CONSTRAINT proper_email CHECK (((VALUE)::text~* '^[A-Za-z0-9._%]+@[A-Za-z0-9.]+[.][A-Za-z]+$'::text));
COMMENT ON DOMAIN warehouse.email_address IS 'Domain used for user email addresses';

CREATE DOMAIN warehouse.vat_number AS VARCHAR(15)
    CONSTRAINT proper_vat CHECK (((VALUE)::text~* '[A-Za-z0-9]{5,}'::text));
COMMENT ON DOMAIN warehouse.vat_number IS 'Domain used for seller vat numbers';

CREATE DOMAIN warehouse.iban AS VARCHAR(34)
    CONSTRAINT proper_iban CHECK (((VALUE)::text~* '[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}'::text));
COMMENT ON DOMAIN warehouse.iban IS 'Domain used for seller IBAN';

CREATE DOMAIN warehouse.priority AS SMALLINT
 DEFAULT 6 CHECK(VALUE >= 0 AND VALUE <= 10);
COMMENT ON DOMAIN warehouse.priority IS 'Domain used for ticket priority from 0 to 10';

-----------------------
-- Custom Data Types --
-----------------------
CREATE TYPE warehouse.ticket_status_type AS ENUM ( 
    'Open', 'Resolved', 'Closed'
);
COMMENT ON TYPE warehouse.ticket_status_type IS 'Domain used for enumerating all possible
    ticket statuses';

CREATE TYPE warehouse.position_type AS ENUM ( 
    'Shelf', 'Rack', 'Aisle', 'Floor'
);
COMMENT ON TYPE warehouse.position_type IS 'Domain used for all possible kinds of position
    in the warehouse and to create a tree hierarchy';

CREATE TYPE warehouse.loading_unit_type AS ENUM ( 
    'Palletized', 'Picking Point', 'Floor Loaded'
);
COMMENT ON TYPE warehouse.loading_unit_type IS 'Domain used for all possible type of 
    storage of loading unit in the warehouse';

CREATE TYPE warehouse.payment_method_type AS ENUM ( 
    'Credit Card', 'PayPal', 'Gift Card'
);
COMMENT ON TYPE warehouse.payment_method_type IS 'Domain used for all possible types
    of payment';

CREATE TYPE warehouse.country_code AS ENUM (
    'AD','AE','AF','AG','AI','AL','AM','AO','AQ','AR','AS','AT','AU','AW','AX','AZ','BA',
    'BB','BD','BE','BF','BG','BH','BI','BJ','BL','BM','BN','BO','BQ','BR','BS','BT','BV',
    'BW','BY','BZ','CA','CC','CD','CF','CG','CH','CI','CK','CL','CM','CN','CO','CR','CU',
    'CV','CW','CX','CY','CZ','DE','DJ','DK','DM','DO','DZ','EC','EE','EG','EH','ER','ES',
    'ET','FI','FJ','FK','FM','FO','FR','GA','GB','GD','GE','GF','GG','GH','GI','GL','GM',
    'GN','GP','GQ','GR','GS','GT','GU','GW','GY','HK','HM','HN','HR','HT','HU','ID','IE',
    'IL','IM','IN','IO','IQ','IR','IS','IT','JE','JM','JO','JP','KE','KG','KH','KI','KM',
    'KN','KP','KR','KW','KY','KZ','LA','LB','LC','LI','LK','LR','LS','LT','LU','LV','LY',
    'MA','MC','MD','ME','MF','MG','MH','MK','ML','MM','MN','MO','MP','MQ','MR','MS','MT',
    'MU','MV','MW','MX','MY','MZ','NA','NC','NE','NF','NG','NI','NL','NO','NP','NR','NU',
    'NZ','OM','PA','PE','PF','PG','PH','PK','PL','PM','PN','PR','PS','PT','PW','PY','QA',
    'RE','RO','RS','RU','RW','SA','SB','SC','SD','SE','SG','SH','SI','SJ','SK','SL','SM',
    'SN','SO','SR','SS','ST','SV','SX','SY','SZ','TC','TD','TF','TG','TH','TJ','TK','TL',
    'TM','TN','TO','TR','TT','TV','TW','TZ','UA','UG','UM','US','UY','UZ','VA','VC','VE',
    'VG','VI','VN','VU','WF','WS','YE','YT','ZA','ZM','ZW'
);
COMMENT ON TYPE warehouse.country_code IS 'Domain used to uniquely identify a country
    using ISO 3166-02';



---------------------
-- Tables Creation --
---------------------

-- Store
CREATE TABLE warehouse.store (
    url VARCHAR (2083) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(500) NOT NULL,
    logo VARCHAR(2083) NOT NULL
);
COMMENT ON TABLE warehouse.store IS 'Contain all the information of a store';
COMMENT ON COLUMN warehouse.store.url IS 'URL of the store';
COMMENT ON COLUMN warehouse.store.name IS 'Name of the store';
COMMENT ON COLUMN warehouse.store.description IS 'Description of the store';
COMMENT ON COLUMN warehouse.store.logo IS 'URL for the picture used as the store logo';


-- Final Customer
CREATE TABLE warehouse.final_customer (
    username VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    email warehouse.email_address NOT NULL,
    password warehouse.password NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(255),
    registration_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    country warehouse.country_code
);
COMMENT ON TABLE warehouse.final_customer IS 'Contain all the information of
    a final customer';
COMMENT ON COLUMN warehouse.final_customer.username IS 'Username of the final customer
    used as an identifier';
COMMENT ON COLUMN warehouse.final_customer.surname IS 'Surname of the final customer';
COMMENT ON COLUMN warehouse.final_customer.email IS 'Email of the final customer, used as 
    credential to login into the website';
COMMENT ON COLUMN warehouse.final_customer.password IS 'Password for the employee, used as 
    credential to login into the website';
COMMENT ON COLUMN warehouse.final_customer.phone_number IS 'Phone number of
    the final customer';
COMMENT ON COLUMN warehouse.final_customer.registration_date IS 'Date and time when the final 
    customer has been signed in';
COMMENT ON COLUMN warehouse.final_customer.country IS 'Country of the final customer';


-- Product
CREATE TABLE warehouse.product (
    product_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR (255) NOT NULL ,
    category VARCHAR (500) NOT NULL ,
    supplier VARCHAR (2083) NOT NULL ,
    price MONEY
);
COMMENT ON TABLE warehouse.product IS 'Contain all the information of a product';
COMMENT ON COLUMN warehouse.product.product_id IS 'ID of the product';
COMMENT ON COLUMN warehouse.product.name IS 'Name of the product';
COMMENT ON COLUMN warehouse.product.category IS 'Category of the product';
COMMENT ON COLUMN warehouse.product.supplier IS 'Name of the supplier of the product';
COMMENT ON COLUMN warehouse.product.price IS 'Price of the product ';


-- Invoice
CREATE TABLE warehouse.invoice (
    invoice_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    email warehouse.email_address NOT NULL,
    order_date TIMESTAMP WITH TIME ZONE NOT null,
    payment_amount MONEY,
    payment_method warehouse.payment_method_type NOT NULL,
    payment_date TIMESTAMP WITH TIME ZONE NOT NULL
);
COMMENT ON TABLE warehouse.invoice IS 'Contain all the information of an invoice';
COMMENT ON COLUMN warehouse.invoice.invoice_id IS 'Universally Unique Identifier used to
    represent the invoice';
COMMENT ON COLUMN warehouse.invoice.name IS 'Name of the final customer to whom the
    invoice belongs';
COMMENT ON COLUMN warehouse.invoice.surname IS 'Surname of the final customer to whom the
    invoice belongs';
COMMENT ON COLUMN warehouse.invoice.email IS 'Email of the final customer to whom the
    invoice belongs';
COMMENT ON COLUMN warehouse.invoice.order_date IS 'Date and time when the final customer
    has ordered a product';
COMMENT ON COLUMN warehouse.invoice.payment_amount IS 'Price information of the product';
COMMENT ON COLUMN warehouse.invoice.payment_method IS 'Payment method of the payment
    which the final customer has done';
COMMENT ON COLUMN warehouse.invoice.payment_date IS 'Date and time when the final customer
    has made the payment';


-- Customer Support
CREATE TABLE warehouse.customer_support (
    username VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    email warehouse.email_address NOT NULL,
    PRIMARY KEY (username)
);
COMMENT ON TABLE warehouse.customer_support IS 'Contain all the information related to
    customer support';
COMMENT ON COLUMN warehouse.customer_support.username IS 'Username of the customer support
    used as an identifier';
COMMENT ON COLUMN warehouse.customer_support.name IS 'Name of the customer support';
COMMENT ON COLUMN warehouse.customer_support.surname IS 'Surname of the customer support';
COMMENT ON COLUMN warehouse.customer_support.email IS 'Email of the customer support';


-- Employee
CREATE TABLE warehouse.employee (
    username VARCHAR(50) NOT NULL,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    email warehouse.email_address NOT NULL,
    password warehouse.password NOT NULL,
    PRIMARY KEY (username)
);
COMMENT ON TABLE warehouse.employee IS 'Contain all the information of an employee';
COMMENT ON COLUMN warehouse.employee.username IS 'Username of th employee used as
    an identifier';
COMMENT ON COLUMN warehouse.employee.name IS 'Name of the employee';
COMMENT ON COLUMN warehouse.employee.surname IS 'Surname of the employee';
COMMENT ON COLUMN warehouse.employee.email IS 'Email of the employee, used as
    credential to log-in into the system';
COMMENT ON COLUMN warehouse.employee.password IS 'Password for the employee, used
    as credential to log-in into the system';


-- Package
CREATE TABLE warehouse.package (
    package_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    surname VARCHAR(20) NOT NULL,
    email warehouse.email_address NOT NULL,
    address VARCHAR(255) NOT NULL,
    shipping_date TIMESTAMP WITH TIME ZONE NOT NULL,
    weight FLOAT,
    tracking_code VARCHAR(22),
    id_invoice uuid NOT NULL,
    employee_username VARCHAR(50),
    FOREIGN KEY(id_invoice) REFERENCES warehouse.invoice(invoice_id),
    FOREIGN KEY(employee_username) REFERENCES warehouse.employee(username)
);
COMMENT ON TABLE warehouse.package IS 'Contains all the information about
    packages that will be delivered to the customer with the courier';
COMMENT ON COLUMN warehouse.package.package_id IS 'Universally Unique Identifier used 
    to represent the package';
COMMENT ON COLUMN warehouse.package.name IS 'Name of the final customer who will
    receive the package';
COMMENT ON COLUMN warehouse.package.surname IS 'The surname of recipient';
COMMENT ON COLUMN warehouse.package.email IS 'Email of the final customer';
COMMENT ON COLUMN warehouse.package.address IS 'Address that
    coincides with the destination of the package. Several times it is the same
    of the final customer';
COMMENT ON COLUMN warehouse.package.shipping_date IS 'The date the package is shipped';
COMMENT ON COLUMN warehouse.package.weight IS 'The weight of the package';
COMMENT ON COLUMN warehouse.package.tracking_code IS 'The code that identifies
    the package during shipment';
COMMENT ON COLUMN warehouse.package.id_invoice IS 'Identification of the invoice
    issued during the purchase of the item';
COMMENT ON COLUMN warehouse.package.employee_username IS 'Username of the employee
    who will pack the item';


-- Ticket
CREATE TABLE warehouse.ticket (
    ticket_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    final_customer VARCHAR(50) NOT NULL,
    creation_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    subject VARCHAR NOT NULL,
    description VARCHAR NOT NULL,
    deleted BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY(final_customer) REFERENCES warehouse.final_customer(username)
);
COMMENT ON TABLE warehouse.ticket IS 'A request for support created by the user';
COMMENT ON COLUMN warehouse.ticket.ticket_id IS 'Universally Unique Identifier used
    to represent the ticket';
COMMENT ON COLUMN warehouse.ticket.final_customer IS 'The username of the Final Customer who
    created the ticket';
COMMENT ON COLUMN warehouse.ticket.creation_date IS 'Date and time when the ticket
    has been created';
COMMENT ON COLUMN warehouse.ticket.subject IS 'Title of the ticket';
COMMENT ON COLUMN warehouse.ticket.description IS 'Content of the ticket in plain text';
COMMENT ON COLUMN warehouse.ticket.deleted IS 'Flag to say that the ticket is trashed';


-- Seller
CREATE TABLE warehouse.seller (
    username VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    email warehouse.email_address NOT NULL,
    password warehouse.password NOT NULL,
    phone VARCHAR (50),
    address VARCHAR (50) NOT NULL,
    country warehouse.country_code NOT NULL,
    iban warehouse.iban NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    registration_date TIMESTAMP WITH TIME ZONE,
    store_url VARCHAR (2083) NOT NULL,
    FOREIGN KEY (store_url) REFERENCES warehouse.store(url)
);
COMMENT ON TABLE warehouse.seller IS 'Contain all the information of a seller';
COMMENT ON COLUMN warehouse.seller.username IS 'Username of the seller used as
    an identifier';
COMMENT ON COLUMN warehouse.seller.name IS 'Name of the seller';
COMMENT ON COLUMN warehouse.seller.surname IS 'Surname of the seller';
COMMENT ON COLUMN warehouse.seller.email IS 'Email of the seller, used as
    credential to log-in into the system';
COMMENT ON COLUMN warehouse.seller.password IS 'Password for the seller,
    used as credential to log-in into the system';
COMMENT ON COLUMN warehouse.seller.phone IS 'Phone number of the seller';
COMMENT ON COLUMN warehouse.seller.address IS 'Address of the seller';
COMMENT ON COLUMN warehouse.seller.country IS 'Country where seller is located';
COMMENT ON COLUMN warehouse.seller.iban IS 'IBAN of the seller';
COMMENT ON COLUMN warehouse.seller.active IS 'Activity status of the seller';
COMMENT ON COLUMN warehouse.seller.registration_date IS 'The data when the seller was
    registered in the system';
COMMENT ON COLUMN warehouse.seller.store_url IS 'URL of the store that belongs
    to the seller';


-- Frequently Asked Question
CREATE TABLE warehouse.frequently_asked_question (
    faq_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    question VARCHAR NOT NULL,
    answer VARCHAR NOT NULL,
    created_by_username VARCHAR(50),
    FOREIGN KEY ( created_by_username ) REFERENCES warehouse.customer_support ( username )
);
COMMENT ON TABLE warehouse.frequently_asked_question IS 'Contain a series of answers
    to the typical questions that customers ask the Warehouse.';
COMMENT ON COLUMN warehouse.frequently_asked_question.faq_id IS 'Universally Unique
    Identifier used to represent a FAQ.';
COMMENT ON COLUMN warehouse.frequently_asked_question.question IS 'The question that
    is typically asked of the warehouse.';
COMMENT ON COLUMN warehouse.frequently_asked_question.answer IS 'The solution to the
    problem posed in the question.';
COMMENT ON COLUMN warehouse.frequently_asked_question.created_by_username IS 'Username
    of the Customer Support who mange the question and its answer.';


-- Ticket Status
CREATE TABLE warehouse.ticket_status (
    ticket_id uuid NOT NULL,
    creation_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    previous_status_id uuid,
    previous_status_creation_date TIMESTAMP WITH TIME ZONE,
    next_status_id uuid,
    next_status_creation_date TIMESTAMP WITH TIME ZONE,
    status warehouse.ticket_status_type NOT NULL
        DEFAULT 'Open'::warehouse.ticket_status_type,
    priority warehouse.priority,
    note VARCHAR,
    PRIMARY KEY (ticket_id, creation_date)
); 

ALTER TABLE warehouse.ticket_status 
    ADD CONSTRAINT fk_ticket_previous_status 
        FOREIGN KEY (previous_status_id, previous_status_creation_date) 
        REFERENCES warehouse.ticket_status (ticket_id, creation_date);

ALTER TABLE warehouse.ticket_status 
    ADD CONSTRAINT fk_ticket_next_status 
        FOREIGN KEY (next_status_id, next_status_creation_date) 
        REFERENCES warehouse.ticket_status (ticket_id, creation_date);

COMMENT ON TABLE warehouse.ticket_status IS 'A specific snapshot of the status of a ticket';
COMMENT ON COLUMN warehouse.ticket_status.ticket_id IS 'The reference for a specific ticket';
COMMENT ON COLUMN warehouse.ticket_status.creation_date IS 'Date and time when the ticket 
    status was created';
COMMENT ON COLUMN warehouse.ticket_status.previous_status_id IS 'Reference to the ticket_id
    of the previous ticket status';
COMMENT ON COLUMN warehouse.ticket_status.previous_status_creation_date IS 'Reference to the
    timestamp of the previous ticket status';
COMMENT ON COLUMN warehouse.ticket_status.next_status_id IS 'Reference to the ticket_id of
    the next ticket status';
COMMENT ON COLUMN warehouse.ticket_status.next_status_creation_date IS 'Reference to the
    timestamp of the next ticket status';
COMMENT ON COLUMN warehouse.ticket_status.priority IS 'A value used to escalate tickets in
    importance';
COMMENT ON COLUMN warehouse.ticket_status.note IS 'A note that can be added to explain the
    action performed or the status change reasons';


-- Position
CREATE TABLE warehouse.position (
    position_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    type_pos warehouse.position_type NOT NULL DEFAULT 'Shelf'::warehouse.position_type,
    name_pos VARCHAR(50) NOT NULL,
    parent uuid,
    seller_username VARCHAR(50),
    FOREIGN KEY (seller_username) REFERENCES warehouse.seller(username),
    FOREIGN KEY (parent) REFERENCES warehouse.position(position_id)
); 
COMMENT ON TABLE warehouse.position IS 'A specific snapshot of a warehouse position';
COMMENT ON COLUMN warehouse.position.position_id IS 'The reference for a specific
    warehouse position';
COMMENT ON COLUMN warehouse.position.type_pos IS 'Type of the position considered';
COMMENT ON COLUMN warehouse.position.name_pos IS 'Define the precise position in the
    warehouse';
COMMENT ON COLUMN warehouse.position.parent IS 'Define the structure for modelling a 
    hierarchy of positions';
COMMENT ON COLUMN warehouse.position.seller_username IS 'Defines the username of the seller';


-- Loading Unit
CREATE TABLE warehouse.loading_unit (
    id_load_unit uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    type_load_unit warehouse.loading_unit_type NOT NULL
        DEFAULT 'Floor Loaded'::warehouse.loading_unit_type,
    wrapped BOOLEAN NOT NULL DEFAULT FALSE,
    position uuid,
    FOREIGN KEY (position) REFERENCES warehouse.position(position_id)
);

COMMENT ON TABLE warehouse.loading_unit IS 'A specific snapshot of a loading unit';
COMMENT ON COLUMN warehouse.loading_unit.id_load_unit IS 'The reference for a specific
    loading unit';
COMMENT ON COLUMN warehouse.loading_unit.type_load_unit IS 'Defines the type of storage
    of the loading unit in the warehouse';
COMMENT ON COLUMN warehouse.loading_unit.wrapped IS 'Identifies if the loading unit
    has been wrapped';
COMMENT ON COLUMN warehouse.loading_unit.position IS 'Identifies the position where
    the loading unit is stored';


-- Elaborate
CREATE TABLE warehouse.elaborate (
    cs_username VARCHAR(50) NOT NULL,
    invoice_id uuid PRIMARY KEY,
    order_date TIMESTAMP WITH TIME ZONE,
    ticket_id uuid NOT NULL,
    ticket_creation_date TIMESTAMP WITH TIME ZONE NOT NULL,
FOREIGN KEY ( cs_username ) REFERENCES warehouse.customer_support ( username ),
FOREIGN KEY ( invoice_id ) REFERENCES warehouse.invoice ( invoice_id ),
FOREIGN KEY ( ticket_id, ticket_creation_date )
    REFERENCES warehouse.ticket_status ( ticket_id, creation_date )
);
COMMENT ON TABLE warehouse.elaborate IS 'Relates each member of the customer support
    to the ticket he/she is working on';
COMMENT ON COLUMN warehouse.elaborate.cs_username IS 'Username of the Customer Support
    who manage the ticket';
COMMENT ON COLUMN warehouse.elaborate.invoice_id IS 'Universally Unique Identifier
    used to represent the invoice, NULL if the ticket is not related to an order';
COMMENT ON COLUMN warehouse.elaborate.order_date IS 'Date and time of the invoice,
    NULL if the ticket is not related to an order';
COMMENT ON COLUMN warehouse.elaborate.ticket_id IS 'Universally Unique Identifier
    used to represent the ticket';
COMMENT ON COLUMN warehouse.elaborate.ticket_creation_date IS 'Date and time the
    ticket was created';


-- Item
CREATE TABLE warehouse.item (
    sku VARCHAR(50) PRIMARY KEY,
    product_id uuid,
    id_load_unit uuid,
    package_id uuid DEFAULT NULL,
    FOREIGN KEY (product_id) REFERENCES warehouse.product (product_id),
    FOREIGN KEY (id_load_unit) REFERENCES warehouse.loading_unit (id_load_unit),
    FOREIGN KEY (package_id) REFERENCES warehouse.package (package_id)
);
COMMENT ON TABLE warehouse.item IS 'Contain all the information of the item';
COMMENT ON COLUMN warehouse.item.sku IS 'Text to keep track of stock levels';
COMMENT ON COLUMN warehouse.item.product_id IS 'ID of the product ';
COMMENT ON COLUMN warehouse.item.id_load_unit IS 'Reference to the loading unit where
    the item is stored';
COMMENT ON COLUMN warehouse.item.package_id IS 'Reference to the package where a specific
    item is boxed';


-- Order
CREATE TABLE warehouse.fc_order (
    invoice_id uuid NOT NULL,
    sku VARCHAR(50) NOT NULL,
    fc_username VARCHAR(50) NOT NULL,
    order_date TIMESTAMP WITH TIME ZONE NOT NULL,
    FOREIGN KEY (fc_username) REFERENCES warehouse.final_customer (username),
    FOREIGN KEY (sku) REFERENCES warehouse.item (sku),
    FOREIGN KEY (invoice_id) REFERENCES warehouse.invoice (invoice_id),
    PRIMARY KEY (invoice_id, sku)
);

COMMENT ON TABLE warehouse.fc_order IS 'It defines the action of purchasing
    an item by a customer';
COMMENT ON COLUMN warehouse.fc_order.fc_username IS 'Username of the Final Customer
    who completes the order';
COMMENT ON COLUMN warehouse.fc_order.sku IS 'the SKU (Stock Keeping Unit) of the item';
COMMENT ON COLUMN warehouse.fc_order.invoice_id IS 'Universally Unique Identifier
    used to represent the invoice';
COMMENT ON COLUMN warehouse.fc_order.order_date IS 'Date and time of the invoice';
