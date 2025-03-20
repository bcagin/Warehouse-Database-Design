-----------------------
-- Insert operations --
-----------------------

-- Store
INSERT INTO warehouse.store
    (url, name, description, logo)
VALUES
    (
        'https://www.universeoftoys.com/',
        'Universe of Toys',
        'The Finest Toy Shop in the World.Our expert toy-testers have been hard at work to
            select the ultimate gifts for teeny toddlers, tech-loving pre-teens, and everyone
            in between!',
        'https://storelogo.com/universeoftoys-logo.html'
    ), (
        'https://www.bioshop.com/',
        'Bioshop',
        'Ecological cleaning products and natural cosmetics, of the best
            certified eco brands. We are looking for ECO BIO, NATURAL and
            CRUELTY FREE products.',
        'https://storelogo.com/bioshop-logo.html'
    );

-- Final Customer
INSERT INTO warehouse.final_customer
    (
        username,
        name,
        surname,
        email,
        password,
        phone_number,
        address,
        registration_date,
        country
    )
VALUES
    (   
        'ermete97',
        'Ermete',
        'Alesi',
        'ermete_alesi@gmail.com',
        'Ermes!x2',
        '3547415968',
        'Via Ognissanti 52, Padova',
        '2021-12-12 18:57:01+1'::timestamptz,
        'IT'
    ),
    (   
        'pippo',
        'Pippo aka Wilhelmina',
        'Zaal',
        'wil.zaal@hotmail.com',
        'PppppippoBBello34',
        '+0676185757',
        'Roggestraat 174, Putten',
        '2021-10-26 11:06:47+1'::timestamptz,
        'NL'
    ),
    (
        'kienna12',
        'Kienna',
        'Elfrida',
        'ki.elfrida@yahoo.com',
        'Knn123!lXrr',
        '3345859636',
        'Piazza Pilastri 17, Merate',
        '2022-11-18 07:42:18+1'::timestamptz,
        'IT'
    );

-- Product
INSERT INTO warehouse.product
    (product_id, name, category, supplier, price)
VALUES
    (
        uuid('500bd6b1-3b4e-4ca1-b5ed-792d2020d491'),
        'CC Cream SPF30',
        'Makeup',
        'Kess',
        35.5
    ), (
        uuid('437c5e05-59a0-4696-a8ab-29c3c3dd8cde'),
        'Liquid Eyeliner',        
        'Makeup',
        'Kess',
        19              
    ), (
        uuid('5e566baa-630a-4749-9c75-c83a23a773eb'),
        'Monopoly in viaggio per il mondo',        
        'Table games',
        'Monopoly',
        25              
    ), (
        uuid('238091ab-f74b-4310-baec-3baa50228b52'),
        'Snow Chains',        
        'Auto',
        'Goodyear',
        49.9              
    ), (
        uuid('ae3097bf-8707-4259-9ff8-d9601267da64'),
        'Fire TV Stick Lite',        
        'Amazon devices',
        'Amazon',
        26.99            
    ), (
        uuid('362c3266-ab5a-4f61-bb37-924c2a8b9850'),
        'Google Pixel 7 - 128GB',        
        'Electronics',
        'Google',
        649              
    );


-- Invoice
INSERT INTO warehouse.invoice
    (
        invoice_id,
        name,
        surname,
        email,
        order_date,
        payment_amount,
        payment_method,
        payment_date
    )
VALUES
    (
        uuid('c685c1cb-81b1-4a8c-877f-af1052d75590'),
        'Pippo aka Wilhelmina',
        'Zaal',
        'wil.zaal@hotmail.com',
        '2022-12-11 05:13:22+1'::timestamptz,
        33.60,
        'Credit Card',
        '2022-12-11 05:15:22+1'::timestamptz
    ), (
        uuid('bab09938-b8c3-45d8-b6b8-ab46bb5b77e6'),
        'Ermete',
        'Alesi',
        'ermete_alesi@gmail.com',
        '2022-12-11 06:21:22+1'::timestamptz,
        12.80,
        'Credit Card',
        '2022-12-11 06:23:22+1'::timestamptz
    ), (
        uuid('b43f1d12-704a-441d-ba71-a6aaa74e723c'),
        'Kienna',
        'Elfrida',
        'ki.elfrida@yahoo.com',
        '2022-12-01 17:25:22+1'::timestamptz,
        18.00,
        'Gift Card',
        '2022-12-01 17:29:22+1'::timestamptz
    );



-- Customer Support
INSERT INTO warehouse.customer_support
    (username,name,surname,email)
VALUES
    (
       'rita.esposito',
       'Rita',
       'Esposito',
       'rita.esposito.88@yahoo.com'
    ),
    (
       'andrea.rossi',
       'Andrea',
       'Rossi',
       'andreared_77@gmail.com'
    ),
    (
       'alyson.smith',
       'Alyson',
       'Smith',
       'alysonflower@gmail.com'
    ),
    (
       'li.yang',
       'Li',
       'Yang',
       'thegreatwall80@microsoft.com'
    );

-- Employee
INSERT INTO warehouse.employee
    (
        username,
        name,
        surname,
        email,
        password
    )
VALUES
    (   
        'manlio68',
        'Manlio',
        'Ghirardini',
        'manlio.ghirardini@gmail.com',
        'Manl10!!!'
    ),
    (   
        'tere00',
        'Teresa',
        'Wozniak',
        'tere0000@gmail.com',
        'terter333'
    );


-- Package
INSERT INTO warehouse.package
    (
        package_id,
        name,
        surname,
        email,
        address,
        shipping_date,
        weight,
        tracking_code,
        id_invoice,
        employee_username
    )
VALUES
    (
        uuid('ad8a816e-c21e-4bfd-acfd-c64cf8d202e7'),
        'Pippo aka Wilhelmina',
        'Zaal',
        'wil.zaal@hotmail.com',
        'Roggestraat 174, Putten',
        '2022-12-14 11:37:20+1'::timestamptz,
        51.53,
        '1945345345634665332894',
        uuid('bab09938-b8c3-45d8-b6b8-ab46bb5b77e6'),
        'manlio68'
    ), (
        uuid('3d33aed3-c269-417d-ad2d-07fcf9dcef66'),
        'Kienna',
        'Elfrida',
        'ki.elfrida@yahoo.com',
        'Piazza Pilastri 17, Merate',
        '2022-11-14 16:11:56+1'::timestamptz,
        1.27,
        '2045345665634669992895',
        uuid('b43f1d12-704a-441d-ba71-a6aaa74e723c'),
        'tere00'
    ), (
        uuid('f6c89b23-3aa3-435e-b2d0-dcd1b2525fa0'),
        'Ermete',
        'Alesi',
        'ermete_alesi@gmail.com',
        'Via Ognissanti 52, Padova',
        '2022-12-15 14:21:40+1'::timestamptz,
        10.70,
        '5748345875835655972675',
        uuid('c685c1cb-81b1-4a8c-877f-af1052d75590'),
        'tere00'
    );


-- Ticket
INSERT INTO warehouse.ticket
    (ticket_id, final_customer, creation_date, subject, description, deleted)
VALUES
    (
        uuid('c2d29867-3d0b-d497-9191-18a9d8ee7830'),
        'pippo',
        '2022-12-10 09:15:22+1'::timestamptz,
        'Issue when updating the shopping cart',
        'Every time I try to shop in my favorite store,
            I try to add my favorite item in the cart
            and nothing happens. Please help!',
        FALSE
    ), (
        uuid('85605ec3-2bb2-42bd-b0e6-c148d976dec1'),
        'pippo',
        '2022-12-05 18:23:14+1'::timestamptz,
        'Issue with login screen',
        'Access to the site is blocked',
        FALSE
    ), (
        uuid('62b052fd-b441-497f-b1ad-62be5159edf8'),
        'pippo',
        '2022-12-08 04:21:10+1'::timestamptz,
        'I do not like the style of the website',
        'I do not like the style of the website! It is boring.',
        FALSE
    );


-- Seller
INSERT INTO warehouse.seller
    (
        username,
        name,
        surname,
        email,
        password,
        phone,
        address,
        country,
        iban,
        active,
        registration_date,
        store_url
    )
VALUES
    (
        'Amanda88Fox',
        'Amanda',
        'Fox',
        'amanda.fox@gmail.com',
        'SnowWhite2004',
        '+442074797399',
        '185-193 Regent St., London W1B 5BT',
        'GB',
        'GB26MID40051512445674',
        TRUE,
        '2005-10-10 18:15:22+1'::timestamptz,
        'https://www.universeoftoys.com/'
    ), (
        'PiotrPszoniak20',
        'Piotr',
        'Pszoniak',
        'Piotr.Pszoniak@gmail.com',
        '!PiotrPk2020.',
        '+48532741917',
        '1al. Jerozolimskie 176, 02-222 Warszawa',
        'PL',
        'PL10105000997603123466789123',
        TRUE,
        '2020-07-05 16:15:22+1'::timestamptz,
        'https://www.bioshop.com/'
    );

-- Frequently Asked Question
INSERT INTO warehouse.frequently_asked_question
    (faq_id, question, answer, created_by_username)
VALUES
    (
        uuid('1a4d8a7a-2b6a-4444-a04b-3efef6775ca9'),
        'Will my goods be safe in your warehouse?',
        'All of our safe warehouses are equipped with the highest level
            of security for your goods, including: 24/7 state-of-the-art
            video monitoring with 30+ day retention, cell connected
            security systems, as well as patrolled yards.',
        'li.yang'
    ),
    (
        uuid('c2890b44-ff76-4cfe-a384-73d77b333a94'),
        'How are claims for damaged products handled?',
        'The goods are always checked by the operators before any shipment.
            If the product is found to be damaged on arrival and there is
            a potential claim, the customer can request the return of the
            goods for replacement or refund.',
        'andrea.rossi'
    ),
    (
        uuid('8465b0e7-3e69-4051-91d6-ea364496b62c'),
        'What can I sell in Boxes store as a new seller?',
        'There are many opportunities for new sellers in Boxes store. 
            What you can sell depends on the product, the category, and the brand.
            Certain products require approval to sell and other categories include 
            products that cannot be sold by third-party sellers.',
        'alyson.smith'
    ),
    (
        uuid('86b6b2f1-4391-476e-8b6c-494a6c65908d'),
        'How do I sell products on Boxes?', 
        'Getting started is simple: complete the registration on the site, 
            making sure you have access to your bank account number, 
            debitable credit card and phone number.',
        'alyson.smith'
    );

-- Ticket Status
INSERT INTO warehouse.ticket_status
    (
        ticket_id,
        creation_date,
        previous_status_id,
        previous_status_creation_date,
        next_status_id,
        next_status_creation_date,
        status,
        priority,
        note
    ) 
VALUES
    (
        uuid('c2d29867-3d0b-d497-9191-18a9d8ee7830'),
        '2022-12-10 09:15:22+1'::timestamptz,
        NULL,
        NULL,
        NULL,
        NULL,
        'Open',
        7,
        'This ticket was marked as urgent by the triage'
    ),(
        uuid('85605ec3-2bb2-42bd-b0e6-c148d976dec1'),
        '2022-12-05 18:23:14+1'::timestamptz,
        NULL,
        NULL,
        uuid('85605ec3-2bb2-42bd-b0e6-c148d976dec1'),
        '2022-12-05 22:08:04+1'::timestamptz,
        'Open',
        9,
        'Many people are facing the same issue'
    ),(
        uuid('85605ec3-2bb2-42bd-b0e6-c148d976dec1'),
        '2022-12-05 22:08:04+1'::timestamptz,
        uuid('85605ec3-2bb2-42bd-b0e6-c148d976dec1'),
        '2022-12-05 18:23:14+1'::timestamptz,
        NULL,
        NULL,
        'Resolved',
        0,
        'The ticket was resolved by rebooting the auth server'
    ),(
        uuid('62b052fd-b441-497f-b1ad-62be5159edf8'),
        '2022-12-10 09:15:22+1'::timestamptz,
        NULL,
        NULL,
        NULL,
        NULL,
        'Open',
        2,
        'This complain is not even worth a reply. Maybe somebody else has time to do it?'
    );

-- Position
INSERT INTO warehouse.position
    (position_id, type_pos, name_pos, parent, seller_username)
VALUES
    (
      uuid('42095151-57ed-4c20-b4e1-b8930979de95'),
      'Floor',
      'Floor 1',
      NULL,
      'PiotrPszoniak20'
    ), (
      uuid('7708b37c-94a3-48bc-beae-9b48cb2dd977'),
      'Aisle',
      'Aisle A',
      uuid('42095151-57ed-4c20-b4e1-b8930979de95'),
      'PiotrPszoniak20'
    ), (
      uuid('5fc2006a-3c7e-49d5-9218-eecb2369e426'),
      'Rack',
      'Rack A1',
      uuid('7708b37c-94a3-48bc-beae-9b48cb2dd977'),
      'Amanda88Fox'
    ), (
      uuid('99116ea4-fc23-4a14-8239-2d8c9340be6b'),
      'Shelf',
      'Shelf A1.1',
      uuid('5fc2006a-3c7e-49d5-9218-eecb2369e426'),
      'Amanda88Fox'
    ), (
      uuid('486d7ec6-aba5-48dc-add5-5ff86c6d91fc'),
      'Shelf',
      'Shelf A1.2',
      uuid('5fc2006a-3c7e-49d5-9218-eecb2369e426'),
      'PiotrPszoniak20'
    ), (
      uuid('08cb3360-6112-4715-8b94-ba896de74c12'),
      'Aisle',
      'Aisle B',
      uuid('42095151-57ed-4c20-b4e1-b8930979de95'),
      'PiotrPszoniak20'
    ), (
      uuid('2d37d260-8fec-4885-a215-703ec321b817'),
      'Rack',
      'Rack A2',
      uuid('08cb3360-6112-4715-8b94-ba896de74c12'),
      'Amanda88Fox'
    ), (
      uuid('b70fffe1-b654-4bcd-9879-ba881ab1e7e5'),
      'Shelf',
      'Shelf A2.1',
      uuid('2d37d260-8fec-4885-a215-703ec321b817'),
      'PiotrPszoniak20'
    ), (
      uuid('a81effe1-aa10-ef57-f0f5-fa482a01e6a8'),
      'Shelf',
      'Shelf A2.2',
      uuid('2d37d260-8fec-4885-a215-703ec321b817'),
      'PiotrPszoniak20'
    ), (
      uuid('66633900-dca0-4231-a166-edbb9a44f9e0'),
      'Shelf',
      'Shelf A2.3',
      uuid('2d37d260-8fec-4885-a215-703ec321b817'),
      NULL
    ), (
      uuid('8e9a63d0-99f1-409a-9d9c-e15cb7001723'),
      'Shelf',
      'Shelf A2.4',
      uuid('2d37d260-8fec-4885-a215-703ec321b817'),
      NULL
    );

-- Loading Unit
INSERT INTO warehouse.loading_unit
    (id_load_unit, type_load_unit, wrapped, position)
VALUES
    (
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      'Picking Point',
      FALSE,
      uuid('486d7ec6-aba5-48dc-add5-5ff86c6d91fc')
    ), (
      uuid('29b8d7cb-a1ef-4093-bb05-262295cfe60e'),
      'Floor Loaded',
      FALSE,
      uuid('b70fffe1-b654-4bcd-9879-ba881ab1e7e5')
    ), (
      uuid('5fc2006a-3c7e-49d5-9218-eecb2369e426'),
      'Palletized',
      TRUE,
      uuid('99116ea4-fc23-4a14-8239-2d8c9340be6b')
    );

-- Elaborate
INSERT INTO warehouse.elaborate
    (cs_username, invoice_id, order_date, ticket_id, ticket_creation_date)
VALUES
    (
        'rita.esposito',
        uuid('c685c1cb-81b1-4a8c-877f-af1052d75590'),
        '2022-12-11 06:21:22+1'::timestamptz,
        uuid('c2d29867-3d0b-d497-9191-18a9d8ee7830'),
        '2022-12-10 09:15:22+1'::timestamptz
    ), (
        'alyson.smith',
        uuid('bab09938-b8c3-45d8-b6b8-ab46bb5b77e6'),
        '2022-12-11 05:13:22+1'::timestamptz,
        uuid('85605ec3-2bb2-42bd-b0e6-c148d976dec1'),
        '2022-12-05 18:23:14+1'::timestamptz
    );

-- Item
INSERT INTO warehouse.item
    (sku, product_id, id_load_unit, package_id)
VALUES
    (
      '849-5555-241-010',
      uuid('238091ab-f74b-4310-baec-3baa50228b52'),
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      uuid('ad8a816e-c21e-4bfd-acfd-c64cf8d202e7')
    ), (
      '849-5555-241-011',
      uuid('ae3097bf-8707-4259-9ff8-d9601267da64'),
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      NULL
    ), (
      '849-5555-241-012',
      uuid('362c3266-ab5a-4f61-bb37-924c2a8b9850'),
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      NULL
    ), (
      '849-5555-241-013',
      uuid('362c3266-ab5a-4f61-bb37-924c2a8b9850'),
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      NULL
    ), (
      '849-5555-241-014',
      uuid('362c3266-ab5a-4f61-bb37-924c2a8b9850'),
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      NULL
    ), (
      '849-5555-241-015',
      uuid('362c3266-ab5a-4f61-bb37-924c2a8b9850'),
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      NULL
    ), (
      '849-5555-241-016',
      uuid('362c3266-ab5a-4f61-bb37-924c2a8b9850'),
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      NULL
    ), (
      '849-5555-241-017',
      uuid('362c3266-ab5a-4f61-bb37-924c2a8b9850'),
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      NULL
    ), (
      '849-5555-241-018',
      uuid('500bd6b1-3b4e-4ca1-b5ed-792d2020d491'),
      uuid('517b8c48-68dd-40b6-951a-5af1ad44d65a'),
      NULL
    ), (
      '849-5555-240-004',
      uuid('437c5e05-59a0-4696-a8ab-29c3c3dd8cde'),
      uuid('29b8d7cb-a1ef-4093-bb05-262295cfe60e'),
      uuid('f6c89b23-3aa3-435e-b2d0-dcd1b2525fa0')
    ), (
      '849-5555-241-007',
      uuid('5e566baa-630a-4749-9c75-c83a23a773eb'),
      uuid('5fc2006a-3c7e-49d5-9218-eecb2369e426'),
      uuid('3d33aed3-c269-417d-ad2d-07fcf9dcef66')
    );

-- Order
INSERT INTO warehouse.fc_order
    (fc_username, sku, invoice_id, order_date) 
VALUES
    (
        'ermete97',
        '849-5555-241-010',
        uuid('bab09938-b8c3-45d8-b6b8-ab46bb5b77e6'),
        '2022-12-11 05:13:22+1'::timestamptz
    ), (
        'pippo',
        '849-5555-240-004',
        uuid('c685c1cb-81b1-4a8c-877f-af1052d75590'),
        '2022-12-11 06:21:22+1'::timestamptz
    ), (
        'kienna12',
        '849-5555-241-007',
        uuid('b43f1d12-704a-441d-ba71-a6aaa74e723c'),
        '2022-12-01 17:29:22+1'::timestamptz
    ), (
        'kienna12',
        '849-5555-241-012',
        uuid('b43f1d12-704a-441d-ba71-a6aaa74e723c'),
        '2022-12-01 17:35:22+1'::timestamptz
    )
    , (
        'kienna12',
        '849-5555-241-013',
        uuid('b43f1d12-704a-441d-ba71-a6aaa74e723c'),
        '2022-12-01 17:41:22+1'::timestamptz
    );  
