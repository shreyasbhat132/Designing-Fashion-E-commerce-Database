# Designing a Fashion E-commerce Database

## A HYPTHETICAL BUSINESS MODEL

Mikoto is an e-commerce company that provides a wide selection of fashion and lifestyle products; from established brands to local businesses. Mikoto also provides door step delivery facility as well as pick-up location services, with delivery time not exceeding more than 5-6 business days. Mikoto also provides customers with online fashion consulting from Mikoto experts, fashion blogs, community engagements and other services.

The company offers clothing options for men, women, and kids including unisex wear. The consumers have options to shop from various categories like formals, casuals, sports & active wear, personal care & grooming, foot-wears and so on. The database is capable of recording customer purchase data as well as data pertaining to the supply-chain aspect of the business. The database also registers the supplier information, product catalog, warehousing & inventory status of each product, and personal details of both users, and the consultants employed by Mikoto. They also offers their customers an option to opt for premium membership, where the user gets access to discounts, early-access to sales, fast-delivery, expert picks on clothing&accessories, customized recommendations based on purchase activity.

## APPROACH

The approach taken in designing and implementing the Mikoto fashion e-commerce database involved a comprehensive and systematic process. Firstly, the business model was thoroughly defined to understand the requirements of the database. Next, the logical database design was visualized using ERD and UML class diagrams to represent the entities and relationships within the system. The relational model was then designed based on the logical model to provide a structured approach to the storage and retrieval of data. The database was implemented on a MySQL RDBMS, which provided robust features for data management and query optimization. To scale towards Big Data, NoSQL databases were used, providing horizontal scalability and flexible data storage. Finally, data retrieval and analysis were performed to obtain valuable insights and improve business operations. Overall, this approach ensured the database was efficient, scalable, and met the requirements of the Mikoto fashion e-commerce website.

## WHAT YOU WILL FIND

The repository contains the Entity Relationship Diagram (ERD) and the Unified Modeling Language (UML) Class Diagram for designing conceptual database model of the proposed business. The ERD and UML class diagrams are not enough to develop a relationall databse. In order to maintain consistency, we normalized the relationshps further and ended up with 24 tables capturing vital business data. The data for the tables were generated using [mockaroo.com](mockaroo.com), a random data generator API tool for csv, SQL and json files.

The normalized tables are as follows:

* User (acc_id(PK), first_name, last_name, email, password, date_of_birth)
* Address ( add_id (PK), address_line_1, address_line_2, city, state, zipcode, phone)
* Stays_at (acc_ID(FK), add_id(FK))
* Premium_user (premium_id(PK), acc_id(FK))
* Fashion_consultancy (session_id(PK), premium_id(FK), consultant_id(FK), date)
* Consultant (consultant_id(PK), first_name, last_name, email, phone)
* Product_category (category_id(PK), category_name)
* Specializing_in (consultant_id(FK), category_id(FK))
* Product (product_id(PK), product_name, price, fast_del, category_id(FK))
* Supplies_prod (supplier_id(FK), product_id(FK))
* Supplier (supplier_id(PK), supplier_name, email, add_id(FK))
* Supplies_wh (supplier_id(FK), warehouse_id(FK))
* Warehouse (warehouse_id(PK), add_id(FK), available_storage_space)
* Prod_wh (product_id(FK), warehouse_id(FK), inventory_level)
* Purchase_order (order_id(PK), total_price, order_date, order_quantity, acc_id(FK), cart_id(FK))
* Order_review (review_id(PK), order_id(FK), review_creation_date, shopping_exp)
* Cart (cart_id(PK), creation_date)
* Cart_item (product_id(FK), cart_id(FK), qty_product)
* Shipment (shipment_id(PK), est_ship, est_del, act_ship, act_del, shipment_status, order_id(FK), vehicle_id(FK), warehouse_id(FK), premium_id(FK))
* Transportation (vehicle_id(PK), driver_id)
* Belongs_to_wh (vehicle_id(FK), warehouse_id(FK))
* Ship_item (product_id(FK), shipment_id(FK), qty_shipment)
* Payment (payment_id(PK), acc_id(FK), payment_method, card_no, cvv, card_type, exp_date)
* Transaction (transaction_id(PK), payment_id(FK), order_id(FK), closed_at, payment_status)
