USE mikoto;

#Query 1: Calculates the total revenue per product category: (Joins)
	SELECT pc.category_name, SUM(p.price * ci.qty_product) AS total_revenue
	FROM product p
	INNER JOIN cart_item ci ON ci.product_id = p.product_id
	INNER JOIN purchase_order po ON po.cart_id = ci.cart_id
	INNER JOIN product_category pc ON pc.category_id = p.category_id
	GROUP BY pc.category_name;

#Query 2: Retrieve the account ID, first name, last name of all users who have placed an order 
#for a product in the "Accessories" category (Nested)
	SELECT u.acc_id, u.first_name, u.last_name
	FROM user u
	WHERE u.acc_id IN (
	    SELECT DISTINCT po.acc_id
	    FROM purchase_order po
	    INNER JOIN cart_item ci ON po.cart_id = ci.cart_id
	    INNER JOIN product p ON ci.product_id = p.product_id
	    INNER JOIN product_category pc ON p.category_id = pc.category_id
	    WHERE pc.category_name = 'Accessories'
	);

#Query 3: Return all the shipments that contain a product that has inventory level less than 2000 (Recursive):
	WITH RECURSIVE shipment_products(shipment_id, product_id) AS (
	SELECT sp.shipment_id, sp.product_id
	FROM ship_item sp
	JOIN prod_wh pw ON pw.product_id = sp.product_id
	WHERE pw.inventory_level < 2000
	UNION
	SELECT sp.shipment_id, sp.product_id
	FROM shipment_products sp
	JOIN ship_item sp2 ON sp.shipment_id = sp2.shipment_id
	AND sp.product_id <> sp2.product_id
	)
	SELECT s.shipment_id, sp.product_id
	FROM shipment s
	JOIN ship_item sp ON s.shipment_id = sp.shipment_id
	JOIN shipment_products sp2 ON sp.shipment_id = sp2.shipment_id
	AND sp.product_id = sp2.product_id;

#REST    
#Retrieve all the premium users' order and transaction ID corresponding to failed transaction (Simple):
	
	SELECT o.order_id, u.acc_id, pre.premium_id, t.transaction_id
	FROM purchase_order AS o, user AS u, premium_user AS pre, transaction AS t
	WHERE u.acc_id = pre.acc_id AND u.acc_id = o.acc_id
	AND o.order_id = t.order_id AND t.payment_status = "Failed";
    
#Query using a CTE and a subquery to return all shipments and their corresponding vehicles (CTE):
	WITH shipment_vehicle AS (
	  SELECT s.shipment_id, t.vehicle_id
	  FROM shipment s
	  JOIN transportation t ON s.vehicle_id = t.vehicle_id
	)
	SELECT s.shipment_id, s.est_ship, s.est_del, s.act_ship, s.act_del, s.shipment_status, sv.vehicle_id
	FROM shipment s
	JOIN (
	  SELECT shipment_id, vehicle_id
	  FROM shipment_vehicle
	) sv ON s.shipment_id = sv.shipment_id;
    
#Find all premium users who have made at least one purchase order (Correlated):
	SELECT premium_user.acc_id, premium_user.premium_id
	FROM premium_user
	WHERE EXISTS (
	  SELECT *
	  FROM purchase_order
	  WHERE purchase_order.acc_id = premium_user.acc_id
	);

#Return all account id corresponding to premium account holders (Simple ANY/ALL with select sub-query):
	SELECT first_name, last_name 
	FROM user 
	WHERE acc_id = ALL (SELECT acc_id FROM premium_user);







