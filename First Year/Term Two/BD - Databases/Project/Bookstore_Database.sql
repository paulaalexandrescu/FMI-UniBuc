drop table contain;
drop table categories;
drop table written;
drop table authors;
drop table contained;
drop table books;
drop table suppliers;
drop table publishers;
drop table pay_on_delivery;
drop table paypal_payment;
drop table payment_methods;
drop table courier_shipment;
drop table postal_shipment;
drop table shipment_methods;
drop table processed;
drop table orders;
drop table employees;  
drop table clients;


-- CREAREA TABELELOR, ADAUGAREA CONSTRANGERILOR DE INTEGRITATE

create table clients
       (client_id       number(5)       not null    primary key,
        last_name       varchar(55)     not null,
        first_name      varchar(55)     not null, 
        address         varchar(100),
        email           varchar(55),
        phone_number    varchar2(11)
        );
        
create table employees
       (employee_id     number(5)       not null    primary key,
        last_name       varchar(55)     not null,
        first_name      varchar(55)     not null,
        address         varchar(100),
        email           varchar(55),
        phone_number    varchar2(11),
        salary          number(10)      not null,    
        position        varchar(155)
        ); 

create table orders
       (order_id                        number(5)       not null,
        client_id                       number(5)       not null,
        employee_id                     number(5)       not null,
        number_order                    varchar2(5)     not null,
        sum_order                       number(10,2)    not null,
        expected_date_of_shipment       date            not null,
        expected_date_of_arrival        date,
        payment_status                  varchar(22)     not null,
        AWB                             varchar(21),
        constraint PK_orders  primary key (order_id),
        foreign key(client_id) references clients(client_id) on delete cascade,
        foreign key(employee_id) references employees(employee_id) on delete cascade
        ); 
        
create table processed
      (employee_id number(5) not null references employees(employee_id),
       order_id number(5) not null references orders(order_id),
       constraint PK_processed primary key (employee_id, order_id)
       ); 
    
create table shipment_methods
       (shipment_method_id    number(5)         not null    primary key,
        order_id              number(5)         not null,
        price                 number(10, 2),
        constraint fk_shipment_methods foreign key(order_id) references orders(order_id)  on delete cascade
        );
    
create table courier_shipment
       (courier_shipment_id number(5) not null references shipment_methods(shipment_method_id),
        primary key(courier_shipment_id)
        );
    
create table postal_shipment
       (postal_shipment_id number(5) not null references shipment_methods(shipment_method_id),
        primary key(postal_shipment_id)
        ); 
        
create table payment_methods
       (payment_methods_id    number(5)  not null   primary key,
        order_id              number(5)  not null,
        constraint fk_payment_methods foreign key(order_id) references orders(order_id)  on delete cascade
        );

create table paypal_payment
       (paypal_payment_id number(5) not null references payment_methods(payment_methods_id),
        primary key(paypal_payment_id)
        );

create table pay_on_delivery
       (pay_on_delivery_id number(5) not null references payment_methods(payment_methods_id),
        primary key(pay_on_delivery_id)
        );

create table suppliers
       (supplier_id     number(5)       not null    primary key,
        name            varchar(55)     not null,
        address         varchar(100),
        email           varchar(55),
        phone_number    varchar2(11)
        ); 
        
create table publishers
       (publisher_id    number(5)       not null    primary key,
        name            varchar(55)     not null,
        address         varchar(100),
        email           varchar(55)
        ); 
    
create table books
       (book_id                        number(5)       not null,
        supplier_id                    number(5)       not null,
        publisher_id                   number(5)       not null,
        title                          varchar(1000)   not null,
        stock                          number(38)      not null,
        price                          number(10, 2)    not null,
        language                       varchar(200),
        type                           varchar(22),
        number_of_pages                number(5),
        ISBN                           varchar(21),
        constraint PK_books  primary key (book_id),
        foreign key(supplier_id) references suppliers(supplier_id) on delete cascade,
        foreign key(publisher_id) references publishers(publisher_id) on delete cascade
        ); 

create table contained
      (book_id number(5) not null references books(book_id),
       order_id number(5) not null references orders(order_id),
       number_of_copies number(5),
       constraint PK_contained primary key (book_id, order_id)
       ); 

create table authors
       (author_id                   number(5)           not null,
        last_name                   varchar(55)         not null,
        first_name                  varchar(55)         not null,
        constraint PK_authors  primary key (author_id)
       );
    
create table written
      (book_id number(5) not null references books(book_id),
       author_id number(5) not null references authors(author_id),
       date_of_publication date,
       constraint PK_written primary key (book_id, author_id)
       ); 

create table categories
       (category_id                   number(5)           not null,
        genre                         varchar(55)         not null,
        age_range                     varchar(55),
        constraint PK_categories      primary key (category_id)
       );
    
create table contain
      (book_id number(5) not null references books(book_id),
       category_id number(5) not null references categories(category_id),
       constraint PK_contain primary key (book_id, category_id)
       ); 

insert into clients values (1,'Robertson', 'Ophelia', ' Apt. 553, 43875-9486, South Lelamouth, Arizona', 'ophelia_robertson@yahoo.com', '3799861682');
insert into clients values (2,'Moonstone', 'Octavia', 'Suite 056, 85096-5981, Libbytown, Wisconsin', 'octavia_moony@gmail.com', '2395684582');
insert into clients values (3,'Silver', 'Mina', null, null, null);
insert into clients values (4,'Redington', 'Sandra', 'Suite 058, 80954, Grahamfort, Missouri', 'sandra_red@yahoo.com', '27888124852');
insert into clients values (5,'Pitt', 'Stacy', 'Apt. 335, 61702, Fernefort, Maine', 'stacypitt@gmail.com', '2335185385');
insert into clients values (6,'Peterson', 'Zoe', 'Apt. 190, 23586, East Wilburnland, Nebraska', 'peterson_zoe@yahoo.com', '2228534804');
insert into clients values (7,'Vanderwood', 'Lucas', 'Suite 543, 72498-7178, North Lindseychester, Massachusetts', 'lucas_van@gmail.com', '3299572348');
insert into clients values (8,'StClaire', 'Etienne', 'Suite 024, 79189-8803, West Breanne, Pennsylvania', null, '2184621684');
insert into clients values (9,'Besson', 'Blanche', 'Suite 205, 29868-2941, Lake Vivianne, Tennessee', 'bb_blanche@gmail.com', null);
insert into clients values (10,'Weasley', 'George', null, 'george_prackster@gmail.com', '3236593547');
insert into clients values (11,'Miller', 'Hannah', 'Suite 136, 52213, Hillsside, Utah', 'hannahmiller@yahoo.com', '1247248539');
insert into clients values (12,'Jackson', 'Rachel', 'Apt. 286, 98233-4278, Frederikstad, Maryland', 'rachel_js@gmail.com', null);
insert into clients values (13,'Foster', 'Megan', 'Apt. 337, 65311-7312, East Lambertchester, New York', null, '2736593547');
insert into clients values (14,'Park', 'Violet', 'Suite 755, 06865-6180, Lake Adrienne, Illinois', null, '2247248539');       
        
insert into employees values (1,'Potter', 'Adrianna', 'Suite 594, 82410, East Gudrun, Texas', null, '2399861682', 4300, 'Manager');
insert into employees values (2,'Richards', 'Michael', 'Suite 320, 28859, Port Clydemouth, Minnesota', null, null, 13400, 'Cashier');
insert into employees values (3,'Evans', 'Daniel', null, null, null, 3530, 'Cataloger');
insert into employees values (4,'Michaels', 'Lucien', 'Suite 286, 41060, Langoshmouth, North Carolina', 'lucien_michaels@yahoo.com', '22888124852', 2000, null);
insert into employees values (5,'McEwan', 'Hermione', 'Apt. 489, 32546-9885, Stammfort, Nebraska', 'm_hermione@gmail.com', '3435185385', 4500, 'Cataloger');
insert into employees values (6,'King', 'Tara', ' Apt. 871, 50755-4088, Erdmanton, West Virginia', 'kingtara@yahoo.com', '5228534804', 4100, 'Sales Assistant');
insert into employees values (7,'James', 'Alexandra', 'Suite 647, 25158, Alizemouth, Virginia', 'james_alex@gmail.com', '2599572348', 3100, 'Customer Service Assistant');
insert into employees values (8,'Robbie', 'Victor', 'Apt. 707, 69465, West Moriah, Maine', null, '2284621684', 1890, 'Manager');
insert into employees values (9,'Woods', 'Oliver', 'Suite 026, 12360, North Barneyfort, Louisiana', 'woods_oli@gmail.com', null, 1500, 'Graphic Designer');
insert into employees values (10,'Whitethorne', 'Cassie', 'Suite 501, 09381-6701, New Michelleport, Indiana', 'whitethorne@gmail.com', '3236593547', 3000, 'UI/UX Designer');
insert into employees values (11,'Stone', 'Felix', 'Apt. 031, 53426-3411, Kreigerside, Texas', 'felixstone7@yahoo.com', '2347248539', 1700, 'Supplies Assistant');
insert into employees values (12,'Featherington', 'Bianca', 'Suite 223, 06911, South Heleneside, Hawaii', null, '2284621684', 2890, 'Sales Assistent');
insert into employees values (13,'Black', 'Philip', 'Apt. 105, 62567-4301, Bodeshire, Montana', 'blackstar@gmail.com', null, 4800, 'Order Packer');
insert into employees values (14,'Granger', 'Leight', 'Suite 934, 61781-2671, Isobelfurt, Florida', 'granger_leight@gmail.com', '3236593547', 2950, 'Customer Service Assistant');
insert into employees values (15,'Longstock', 'Felix', 'Apt. 556, 25195-7373, West Arianna, Alaska', 'felix_ls@yahoo.com', '2147248539', 1680, 'Order Packer');

insert into orders values (1, 9, 6, '142', 42,to_date('12/05/2021', 'DD/MM/YYYY'), to_date('12/05/2021', 'DD/MM/YYYY'), 'Paid', 'US8756193938471');
insert into orders values (2, 5, 13, '123', 100, to_date('01/06/2021', 'DD/MM/YYYY'), to_date('10/06/2021', 'DD/MM/YYYY'), 'Paid', 'US8756193938472');
insert into orders values (3, 3, 6, '144', 112, to_date('11/05/2021', 'DD/MM/YYYY'), to_date('10/06/2021', 'DD/MM/YYYY'), 'Not Paid', 'US8756193938473');
insert into orders values (4, 11, 15, '121', 212.99, to_date('15/05/2021', 'DD/MM/YYYY'), to_date('10/06/2021', 'DD/MM/YYYY'), 'Paid', 'US8756193938474');
insert into orders values (5, 2, 15, '111', 142, to_date('12/06/2021', 'DD/MM/YYYY'), to_date('15/06/2021', 'DD/MM/YYYY'), 'Not Paid', 'US8756193938475');
insert into orders values (6, 11, 15, '122', 98.90, to_date('09/05/2021', 'DD/MM/YYYY'), to_date('10/06/2021', 'DD/MM/YYYY'), 'Paid', 'US8756193938476');
insert into orders values (7, 4, 13, '132', 113, to_date('23/05/2021', 'DD/MM/YYYY'), to_date('10/06/2021', 'DD/MM/YYYY'), 'Not Paid', 'US8756193938477');
insert into orders values (8, 7, 6, '187', 75, to_date('10/06/2021', 'DD/MM/YYYY'), to_date('12/06/2021', 'DD/MM/YYYY'), 'Paid', 'US8756193938478');
insert into orders values (9, 12, 13, '54', 39.99, to_date('01/06/2021', 'DD/MM/YYYY'), to_date('10/06/2021', 'DD/MM/YYYY'), 'Paid', 'US8756193938479');
insert into orders values (10, 8, 13, '345', 215, to_date('01/06/2021', 'DD/MM/YYYY'), to_date('10/06/2021', 'DD/MM/YYYY'), 'Paid', 'US8756193938480');

insert into processed values (6, 1);
insert into processed values (13, 2);
insert into processed values (6, 3);
insert into processed values (15, 4);
insert into processed values (15, 5);
insert into processed values (15, 6);
insert into processed values (13, 7);
insert into processed values (6, 8);
insert into processed values (13, 9);
insert into processed values (13, 10);
insert into processed values (10, 9);
insert into processed values (9, 10);

insert into shipment_methods values (12, 1, 5);
insert into shipment_methods values (23, 2, 5);
insert into shipment_methods values (15, 3, 5);
insert into shipment_methods values (24, 4, 5);
insert into shipment_methods values (123, 5, 5);
insert into shipment_methods values (231, 6, 5);
insert into shipment_methods values (235, 7, 5);
insert into shipment_methods values (13, 8, 5);
insert into shipment_methods values (176, 9, 5);
insert into shipment_methods values (254, 10, 5);

insert into courier_shipment values (12);
insert into courier_shipment values (15);
insert into courier_shipment values (123);
insert into courier_shipment values (13);
insert into courier_shipment values (176);

insert into postal_shipment values (23);
insert into postal_shipment values (24);
insert into postal_shipment values (231);
insert into postal_shipment values (235);
insert into postal_shipment values (254);

insert into payment_methods values (3, 1);
insert into payment_methods values (42, 2);
insert into payment_methods values (31, 3);
insert into payment_methods values (46, 4);
insert into payment_methods values (312, 5);
insert into payment_methods values (38, 6);
insert into payment_methods values (435, 7);
insert into payment_methods values (43, 8);
insert into payment_methods values (476, 9);
insert into payment_methods values (354, 10);

insert into paypal_payment values (3);
insert into paypal_payment values (31);
insert into paypal_payment values (312);
insert into paypal_payment values (38);
insert into paypal_payment values (354);

insert into pay_on_delivery values (42);
insert into pay_on_delivery values (46);
insert into pay_on_delivery values (435);
insert into pay_on_delivery values (43);
insert into pay_on_delivery values (476);

insert into suppliers values (1, 'BooksExpress', '167 Bow Ridge St. Geneva, IL 60134', 'booksexpress@yahoo.com', '3287594756');
insert into suppliers values (2, 'Books4Life', '7419 East Clove Ave. Loveland, OH 45140', 'books4life@gmail.com', '2278509784');
insert into suppliers values (3, 'Book Bag', '53 Law Drive Flowery Branch, GA 30542', 'books-bag-inc@yahoo.com', '237845924');
insert into suppliers values (4, 'Books Inc.', '8622 Border Rd. Westlake, OH 44145', 'books-inc@booksinc.com', '3375915723');
insert into suppliers values (5, 'Books and Love', '121 Pleasant Lane Arlington Heights, IL 60004', 'booksandlove@gmail.com', '2389616295');
insert into suppliers values (6, 'Books For Us', '47 South Manchester Dr. Tullahoma, TN 37388', 'books4us@books4us.com', '2384937518');
insert into suppliers values (7, 'Bookish Forever', '33 Bard St. Jamaica, NY 11432', 'bookishforever@yahoo.com', null);

insert into publishers values (1, 'Penguin Books', '80 Strand, London WC2R 0RL, England', 'consumerservices@penguinrandomhouse.com');
insert into publishers values (2, 'Oxford University Press', 'Great Clarendon Street, Oxford, OX2 6DP, England', 'consumerservices@oxforduniversitypress.com');
insert into publishers values (3, 'Head of Zeus', 'First Floor East, 5-8 Hardwick Street, London ECIR 4RG, England', 'consumerservices@headofzeus.com');
insert into publishers values (4, 'Vintage Classics', '20 Vauxhall Bridge Road, London, SW1V 2SA, England', 'consumerservices@vintagepress.com');
insert into publishers values (5, 'Picador', 'The Smithson, 6 Briset Street, London EC1M 5NR, England', 'consumerservices@picador-pan-mcmillan.com');
insert into publishers values (6, 'Scribner', '1st Floor, 222 Gray-s Inn Road, London WC1X 8HB, England', 'consumerservices@simonandschuster.com');
insert into publishers values (7, 'Faber and Faber', 'Bloomsbury House, 74-77 Great Russell Street, London WC1B 3DA, England', 'consumerservices@faberandfaber.com');
insert into publishers values (8, 'Bloomsbury Publishing', '50 Bedford Square, London, WC1B 3DP, UK', 'consumerservices@bloomsbury.com');
insert into publishers values (9, 'Riverhead Books', '375  Hudson Street, New York, New York 10014, US', 'consumerservices@riverheadbooks.com');
insert into publishers values (10, 'The Bodley Head', '20 Vauxhall Bridge Road, London, SW1V 2SA, England', 'consumerservices@bodley-head.com');
insert into publishers values (11, 'Weidenfeld and Nicolson', 'Carmelite House, 50 Victoria Embankment, London EC4Y 0DZ', 'consumerservices@weidenfeld-nicolson.com');

insert into books values (1, 7, 1, 'The Communist Manifesto', 112, 12.99, 'english', 'hardback', 403, '9780241989169');
insert into books values (2, 4, 1, 'On Beauty', 19, 7.99, 'english', 'paperback', 443, '9780241989166');
insert into books values (3, 2, 3, 'Pachinko', 176, 11.99, 'english', 'paperback', 537, '9780749561368');
insert into books values (4, 1, 4, 'The Handmaid-s Tale', 89, 9.99, 'english', 'paperback', 324, '9780472417539');
insert into books values (5, 5, 4, 'South of the Border, West of the Sun', 79, 11.99, 'english', 'paperback', 187, '9780524189427');
insert into books values (6, 5, 5, 'The People in The Trees', 119, 12.99, 'english', 'paperback', 368, '9780524189332');
insert into books values (7, 7, 5, 'A Little Life', 234, 12.99, 'english', 'paperback', 820, '9780524187599');
insert into books values (8, 6, 6, 'Kim JiYoung: Born 1982', 111, 10.99, 'english', 'paperback', 163, '9780524629642');
insert into books values (9, 1, 7, 'Never Let Me Go', 98, 8.99, 'english', 'paperback', 282, '9780300629642');
insert into books values (10, 3, 7, 'Conversations with Friends', 141, 12.99, 'english', 'paperback', 321, '9780524624021');
insert into books values (11, 2, 7, 'Normal People', 201, 12.99, 'english', 'paperback', 266, '9780524624432');
insert into books values (12, 4, 8, 'The Dutch House', 132, 13.99, 'english', 'paperback', 337, '9780524358449');
insert into books values (13, 5, 1, 'Sister Outsider', 114, 15.99, 'english', 'hardback', 183, '9780528562385');
insert into books values (14, 7, 1, 'Howl, Kaddish and Other Poems', 79, 9.99, 'english', 'paperback', 117, '9780587126409');
insert into books values (15, 7, 9, 'The Mothers', 113, 13.99, 'english', 'paperback', 275, '9780587126401');
insert into books values (16, 7, 10, 'Goddesses, Whores, Wives and Slaves', 75, 19.99, 'english', 'paperback', 230, '9780675238674');
insert into books values (17, 4, 8, 'Circe', 147, 16.99, 'english', 'hardback', 336, '9780886066868');
insert into books values (18, 2, 8, 'The Song of Achilles', 158, 11.99, 'english', 'paperback', 352, '9780675277774');
insert into books values (19, 1, 11, 'Venus and Aphrodite: History of a Goddess', 19, 13.99, 'english', 'paperback', 214, '9780675266674');
insert into books values (20, 3, 1, 'On Photograpy', 15, 9.99, 'english', 'paperback', 207, '9780675266222');
insert into books values (21, 4, 8, 'Mad Enchantment: Claude Monet and the painting of The Water Lilies', 11, 19.99, 'english', 'paperback', 347, '9780675266612');
insert into books values (22, 7, 2, 'A Vindication of the Rights of Woman', 66, 11.99, 'english', 'paperback', 413, '9780675285633');
insert into books values (23, 7, 2, 'Antigone, Oedipus the King and Electra', 121, 11.99, 'english', 'paperback', 178, '9780675298523');
insert into books values (24, 3, 1, 'Forbidden Colours', 57, 11.99, 'english', 'paperback', 429, '9780675222255');
insert into books values (25, 3, 1, 'The Feminine Mystique', 110, 11.99, 'english', 'paperback', 339, '9780675255633');
insert into books values (26, 3, 1, 'The Sorrows of Young Werther', 221, 13.99, 'english', 'paperback', 134, '9780675255311');
insert into books values (27, 7, 7, 'Ariel', 91, 9.99, 'english', 'paperback', 81, '9780775289711');
insert into books values (28, 5, 4, 'Norwegian Wood', 134, 12.99, 'english', 'paperback', 389, '9780524189429');
insert into books values (29, 7, 8, 'Swimming in the Dark', 21, 11.99, 'english', 'paperback', 229, '9780675255532');
insert into books values (30, 3, 2, 'Medea and Other Plays', 127, 10.99, 'english', 'paperback', 168, '9780658392255');
insert into books values (31, 3, 4, 'Untold Night And Day', 45, 11.99, 'english', 'paperback', 152, '9780675255366');
insert into books values (32, 3, 4, 'In The Absense of Men', 123, 9.99, 'english', 'paperback', 177, '9780675222511');
insert into books values (33, 7, 4, 'To The Lighthouse', 121, 9.99, 'english', 'paperback', 235, '9780775288777');

insert into contained values (1, 1, 1);
insert into contained values (12, 2, 1);
insert into contained values (23, 3, 2);
insert into contained values (14, 4, 1);
insert into contained values (5, 3, 2);
insert into contained values (26, 5, 1);
insert into contained values (17, 6, 1);
insert into contained values (8, 7, 1);
insert into contained values (19, 8, 1);
insert into contained values (10, 9, 1);

insert into authors values (1, 'Marx', 'Karl');
insert into authors values (2, 'Smith', 'Zadie');
insert into authors values (3, 'Lee', 'Min Jin');
insert into authors values (4, 'Atwood', 'Margaret');
insert into authors values (5, 'Murakami', 'Haruki');
insert into authors values (6, 'Yanagihara', 'Hanya');
insert into authors values (7, 'Cho', 'NamJoo');
insert into authors values (8, 'Ishiguro', 'Kazuo');
insert into authors values (9, 'Rooney', 'Sally');
insert into authors values (10, 'Patchett', 'Ann');
insert into authors values (11, 'Lorde', 'Audre');
insert into authors values (12, 'Ginsberg', 'Allen');
insert into authors values (13, 'Bennett', 'Brit');
insert into authors values (14, 'Pomeroy B.', 'Sarah');
insert into authors values (15, 'Miller', 'Madeline');
insert into authors values (16, 'Hughes', 'Bettany');
insert into authors values (17, 'Sontag', 'Susan');
insert into authors values (18, 'King', 'Ross');
insert into authors values (19, 'Wollstonecraft', 'Mary');
insert into authors values (20, 'Sophocles', 'Sophocles');
insert into authors values (21, 'Mishima', 'Yukio');
insert into authors values (22, 'Friedan', 'Betty');
insert into authors values (23, 'Von Goethe', 'Johann Wolfgang');
insert into authors values (24, 'Plath', 'Sylvia');
insert into authors values (25, 'Von Goethe', 'Johann Wolfgang');
insert into authors values (26, 'Jedrowski', 'Tomasz');
insert into authors values (27, 'Euripides', 'Euripides');
insert into authors values (28, 'Bae', 'Suah');
insert into authors values (29, 'Besson', 'Philippe');
insert into authors values (30, 'Woolf', 'Virginia');

insert into written values (1, 1, to_date('21/02/1848', 'DD/MM/YYYY'));
insert into written values (2, 2, to_date('01/01/2005', 'DD/MM/YYYY'));
insert into written values (3, 3, to_date('01/01/2007', 'DD/MM/YYYY'));
insert into written values (4, 4, to_date('01/01/1985', 'DD/MM/YYYY'));
insert into written values (5, 5, to_date('01/01/1992', 'DD/MM/YYYY'));
insert into written values (6, 6, to_date('01/01/2012', 'DD/MM/YYYY'));
insert into written values (7, 6, to_date('01/01/2015', 'DD/MM/YYYY'));
insert into written values (8, 7, to_date('01/01/2016', 'DD/MM/YYYY'));
insert into written values (9, 8, to_date('01/01/2005', 'DD/MM/YYYY'));
insert into written values (10, 9, to_date('01/01/2017', 'DD/MM/YYYY'));
insert into written values (11, 9, to_date('01/01/2018', 'DD/MM/YYYY'));
insert into written values (12, 10, to_date('01/01/2019', 'DD/MM/YYYY'));
insert into written values (13, 11, to_date('01/01/1984', 'DD/MM/YYYY'));
insert into written values (14, 12, to_date('01/01/1956', 'DD/MM/YYYY'));
insert into written values (15, 13, to_date('01/01/2016', 'DD/MM/YYYY'));
insert into written values (16, 14, to_date('01/01/1975', 'DD/MM/YYYY'));
insert into written values (17, 15, to_date('10/04/2018', 'DD/MM/YYYY'));
insert into written values (18, 15, to_date('01/01/2011', 'DD/MM/YYYY'));
insert into written values (19, 16, to_date('01/01/2019', 'DD/MM/YYYY'));
insert into written values (20, 17, to_date('01/01/1977', 'DD/MM/YYYY'));
insert into written values (21, 18, to_date('01/01/2016', 'DD/MM/YYYY'));
insert into written values (22, 19, to_date('01/01/1792', 'DD/MM/YYYY'));
insert into written values (23, 20, null);
insert into written values (24, 21, to_date('01/01/1951', 'DD/MM/YYYY'));
insert into written values (25, 22, to_date('01/01/1963', 'DD/MM/YYYY'));
insert into written values (26, 23, to_date('01/01/1774', 'DD/MM/YYYY'));
insert into written values (27, 24, to_date('01/01/1968', 'DD/MM/YYYY'));
insert into written values (28, 5, to_date('01/01/1987', 'DD/MM/YYYY'));
insert into written values (29, 26, to_date('01/01/2020', 'DD/MM/YYYY'));
insert into written values (30, 27, null);
insert into written values (31, 28, to_date('01/01/2013', 'DD/MM/YYYY'));
insert into written values (32, 29, to_date('01/01/2001', 'DD/MM/YYYY'));
insert into written values (33, 30, to_date('01/01/1927', 'DD/MM/YYYY'));

insert into categories values (1, 'Classics', null);
insert into categories values (2, 'History', null);
insert into categories values (3, 'Non-Fiction', null);
insert into categories values (4, 'Young Adult', null);
insert into categories values (5, 'Poetry', null);
insert into categories values (6, 'Art', null);
insert into categories values (7, 'Contemporany', null);
insert into categories values (8, 'Romance', null);
insert into categories values (9, 'Fantasy', null);
insert into categories values (10, 'Fiction', null);

insert into contain values (1, 1);
insert into contain values (2, 3);
insert into contain values (3, 10);
insert into contain values (4, 9);
insert into contain values (5, 10);
insert into contain values (6, 10);
insert into contain values (7, 10);
insert into contain values (8, 10);
insert into contain values (9, 10);
insert into contain values (10, 10);
insert into contain values (11, 10);
insert into contain values (12, 10);
insert into contain values (13, 3);
insert into contain values (14, 5);
insert into contain values (15, 10);
insert into contain values (16, 3);
insert into contain values (17, 10);
insert into contain values (18, 10);
insert into contain values (19, 2);
insert into contain values (20, 6);
insert into contain values (21, 6);
insert into contain values (22, 1);
insert into contain values (23, 1);
insert into contain values (24, 7);
insert into contain values (25, 3);
insert into contain values (26, 1);
insert into contain values (27, 5);
insert into contain values (28, 10);
insert into contain values (29, 10);
insert into contain values (30, 1);

commit;

--------------------------------------------------------------------------------------------------------------------------------------------
-- 11. Formula?i în limbaj natural ?i implementa?i 5 cereri SQL complexe.
--------------------------------------------------------------------------------------------------------------------------------------------

-- 1
-- Sa se afiseze titlul, autorul, genul si pretul cartilor si o coloana reprezentand pretul dupa o marire, astfel: cartile care au fost
--publicate in anul 2005 sufera o crestere de 10%, iar cele publicate in anul 2016 una de 15%, iar la restul se patreaza pretul curent, . 

SELECT b.title TITLUL, a.first_name PRENUME, a.last_name NUME, c.genre GENUL, b.price PRET,
DECODE (EXTRACT(YEAR FROM w.date_of_publication), TO_CHAR(2005), 1.1*b.price, TO_CHAR(2016), 1.15*b.price, b.price)PRET_NOU
FROM books b
JOIN written w ON (b.book_id=w.book_id)
JOIN authors a ON (w.author_id=a.author_id)
JOIN contain co ON (b.book_id=co.book_id)
JOIN categories c ON (co.category_id=c.category_id)
ORDER BY 6 desc, 5 desc, 1;

-- 2
-- S? se afi?eze numele ?i prenumele autorilor care au num?rul de litere al numelui egal cu num?rul de litere a prenumelui, au cel putin un 'i' 
-- in nume si au o carte cu numarul de pagini mai mare decat media numarului de pagini a cartilor din tabela BOOKS.

SELECT a.last_name NUME, a.first_name PRENUME, b.title TITLU, b.number_of_pages NUMAR_PAGINI
FROM authors a
JOIN written w ON (a.author_id=w.author_id)
JOIN books b ON (w.book_id=b.book_id)
WHERE length(a.last_name)=length(a.first_name)
AND a.last_name IN (SELECT a2.last_name
                    FROM authors a2 
                    WHERE LOWER(a2.last_name) LIKE '%i%')
AND b.number_of_pages> (SELECT AVG(b2.number_of_pages)
                        FROM books b2);

-- 3
-- Sa se afiseze id-ul comenzii, numarul comenzii, suma si o noua coloana in  care sa se mareasca suma comenzilor platite 
-- care au data pentru Shipment diferit de data de Arrival cu 10 la suta, altfel marindu-se cu 20%. 

WITH comenzi_platite AS (SELECT *
                        FROM orders o
                        WHERE upper(o.payment_status)=upper('PAID'))
SELECT order_id, number_order, sum_order, 
CASE
WHEN MONTHS_BETWEEN( expected_date_of_shipment, expected_date_of_arrival) = 0  THEN 1.2*sum_order
WHEN MONTHS_BETWEEN( expected_date_of_shipment, expected_date_of_arrival) <> 0  THEN 1.1*sum_order
END SUMA_NOUA
FROM comenzi_platite;

-- 4
-- Sa se afiseze titlul, stocul, pretul si autorul, cat si o coloana cu media aritmetica dintre maximul si minimul preturilor cartilor, pentru cartile care au 
-- pretul mai mic decat media aritmetica dintre maximul si minimul coloanei PRICE din tabela BOOKS;

SELECT b.title, b.stock, b.price, a.first_name, a.last_name, 
(SELECT (MAX(b1.price)+MIN(b1.price))/2
FROM books b1) MEDIA_ARITMETICA
FROM books b
JOIN written w ON (b.book_id=w.book_id)
JOIN authors a ON (w.author_id=a.author_id)
WHERE b.price < (SELECT (MAX(b1.price)+MIN(b1.price))/2
                FROM books b1);

-- 5
-- Sa se afiseze titlul cartilor, autorul, pretul si pentru data publicarii 'Data publicarii 
-- este' data_publicarii '.' daca se cunoaste data, alfel 'Data publicarii nu este cunoscuta'.

SELECT b.title, a.first_name, a.last_name, b.price,
(NVL2(w.date_of_publication, 'Data publicarii este ' || w.date_of_publication || '.', 'Data publicarii nu este cunoscuta.')) DATA_PUBLICARII
FROM books b
JOIN written w ON (b.book_id=w.book_id)
JOIN authors a ON (w.author_id=a.author_id);

-- 6
-- Sa se afiseze titlul si numarul paginilor cartilor care au genul CLASSICS si care au pretul minim.

SELECT b.title, b.number_of_pages, c.genre
FROM books b
JOIN contain co ON (b.book_id=co.book_id)
JOIN categories c ON (co.category_id=c.category_id)
WHERE lower(c.genre)='classics'
AND b.price IN(SELECT MIN(b1.price)
                FROM books b1
                JOIN contain co1 ON (b1.book_id=co1.book_id)
                JOIN categories c1 ON (co1.category_id=c1.category_id)
                WHERE c.genre=c1.genre);

-- 7
-- Sa se afiseze toate id-urile angajatilor care preiau cel putin 2 comenzi si numarul comenzilor preluate.

SELECT employee_id, count(order_id)
FROM processed
GROUP BY employee_id
HAVING count(order_id)>=2;

-- 8
--Sa se afiseze numele furnizorilot care au numele mai mic de 10 caractere si au furnizat o carte scrisa de un autor 
--cu numele de familie din maxim 5 caractere.

SELECT s.name
FROM suppliers s
JOIN books b ON (s.supplier_id=b.supplier_id)
WHERE length(s.name) < 10
AND b.book_id IN (SELECT b1.book_id
                  FROM books b1
                  JOIN written w ON (b1.book_id=w.book_id)
                  JOIN authors a ON (w.author_id=a.author_id)
                  WHERE length(a.last_name) <=5);
                  
--------------------------------------------------------------------------------------------------------------------------------------------
-- 12. Implementarea a 3 opera?ii de actualizare sau suprimare a datelor utilizând subcereri
--------------------------------------------------------------------------------------------------------------------------------------------
-- 1
-- Setati stocul egal cu maximul coloanei STOCK cartiilor cu lungimea titlului mai mare de 10. 

UPDATE books
SET stock=(SELECT MAX(stock)
           FROM books)
WHERE LENGTH(title)>10;

SELECT * FROM books;

ROLLBACK;

-- 2
-- Actualizati pretul metodei de livrare la 10 pentru comenzile cu pretul peste 50. 

UPDATE shipment_methods
SET price=10
WHERE order_id IN (SELECT order_id
                   FROM orders 
                   WHERE sum_order>50);

SELECT * FROM shipment_methods;

ROLLBACK;

-- 3
-- Stergeti angajatii care au salariul mai mare decat salariul mediu al primilor 2 angajati.

DELETE EMPLOYEES
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE employee_id<=2);

SELECT * FROM employees;

ROLLBACK;


--------------------------------------------------------------------------------------------------------------------------------------------
-- 13. Crearea unei secven?e ce va fi utilizat? în inserarea înregistr?rilor în tabele (punctul 10).
--------------------------------------------------------------------------------------------------------------------------------------------
drop sequence seq_ap;

create sequence seq_AP
start with 100
increment by 1
maxvalue 1000
nocycle
nocache;

select * from books; 
insert into books values(seq_AP.nextval, 2, 1, 'Dr Jekyll and Mr Hydes', 13, 10.99, 'english', 'hardback', 106, null);

--------------------------------------------------------------------------------------------------------------------------------------------
-- 16. Formula?i în limbaj natural ?i implementa?i în SQL: o cerere ce utilizeaz? opera?ia outer-join pe minimum 4 tabele ?i dou? cereri ce 
--utilizeaz? opera?ia division.
--------------------------------------------------------------------------------------------------------------------------------------------

-- Afisati numele si adresa edituriilor pentru acele edituri care au publicat o carte scrisa de un autor care are litera s in prenume.

SELECT  p.name, p.address, b.title, a.last_name, a.first_name
FROM publishers p
FULL OUTER JOIN books b ON (p.publisher_id=b.publisher_id)
FULL OUTER JOIN written w ON (b.book_id=w.book_id)
FULL OUTER JOIN authors a ON (w.author_id=a.author_id)
WHERE LOWER(a.first_name) LIKE '%s%';

-- Sa se afiseze ID-ul salariatilor care proceseaza toate comenzile cu EXPECTED_DATE_OF_ARRIVAL  egal cu 13-JUN-21.

SELECT	DISTINCT employee_id
FROM processed a
WHERE NOT EXISTS
       (SELECT	order_id 
        FROM	orders o
        WHERE	expected_date_of_arrival=to_date('12/06/2021', 'DD/MM/YYYY')
        AND NOT EXISTS             
                (SELECT	order_id 
                 FROM 	processed b
                 WHERE	b.order_id =o.order_id
                 AND b.employee_id=a.employee_id));

-- Sa se afiseze id-ul comenzi pentru comenzile care au toate produsele cu numarul de pagini cunoscut.

SELECT	DISTINCT order_id
FROM		contained a
WHERE NOT EXISTS (
                   (SELECT	book_id   --proiecte cu buget de 100000
                    FROM	books p
                      WHERE	number_of_pages <> null)
                      MINUS
                      (SELECT	p2.book_id     --toate proiectele pe care lucreaza angajatul
                       FROM	books p2, contained b
                       WHERE	b.book_id= p2.book_id
                       AND b.order_id = a.order_id));
                       
                       select * from orders;

        
--------------------------------------------------------------------------------------------------------------------------------------------
-- 17. OPTIMIZAREA UNEI CERERI, APLICÂND REGULILE DE OPTIMIZARE CE DERIV? DIN PROPRIET??ILE OPERATORILOR ALGEBREI RELA?IONALE. CEREREA VA 
-- FI EXPRIMAT? PRIN EXPRESIE ALGEBRIC?, ARBORE ALGEBRIC ?I LIMBAJ (SQL), ATÂT ANTERIOR CÂT ?I ULTERIOR OPTIMIZ?RII.
--------------------------------------------------------------------------------------------------------------------------------------------
--X=PENGUIN BOOKS
--lim1=100 ?i lim2=200

--REZULTAT
SELECT p.name, p.address, b.title, b.number_of_pages
from books b 
JOIN publishers p ON (b.publisher_id=p.publisher_id)
WHERE b.number_of_pages>100 AND b.number_of_pages<200 
AND p.name=(SELECT p1.name
            FROM publishers p1
            WHERE initcap(p1.name)='Penguin Books');

--REZULTAT OPTIMIZAT

SELECT p.name, p.address, b.title, b.number_of_pages
from books b 
JOIN publishers p ON (b.publisher_id=p.publisher_id)
WHERE (b.number_of_pages>100 AND b.number_of_pages<200)
AND initcap(p.name)='Penguin Books';







