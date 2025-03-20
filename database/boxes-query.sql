-------------------------------------------------------------------------
-- Given a username, get the list of his/her orders done, and their relative invoices 
-- (like if the user page access his/her own reserved area)
-------------------------------------------------------------------------

SELECT ord.fc_username, ord.sku, invoice.* 
FROM warehouse.fc_order AS ord
    LEFT JOIN warehouse.invoice AS invoice 
    ON ord.invoice_id = invoice.invoice_id
WHERE ord.fc_username = 'pippo';

-------------------------------------------------------------------------
-- For each one and every seller that rented some space in the warehouse, 
-- count all the empty position in the warehouse, and their parent positions. 
-- All this, must be united with the count of the free positions that are
-- not rented by any seller.
-------------------------------------------------------------------------

SELECT seller_username, count(*) AS free_positions
FROM warehouse.position AS pos
    LEFT JOIN warehouse.loading_unit AS lu 
    ON pos.position_id = lu.position
WHERE 
    pos.type_pos = 'Shelf' 
AND 
    lu.id_load_unit IS NULL
GROUP BY 
    seller_username;
 
-------------------------------------------------------------------------
-- Given a specific item (product_id), get the quantity of available items, 
-- the product description and all data for displaying the item page in its store
-------------------------------------------------------------------------
     
SELECT prod.name, prod.category, prod.supplier, prod.price, count as available_quantity
FROM warehouse.product AS prod
    INNER JOIN (
        SELECT itm.product_id, COUNT(DISTINCT itm.sku)
        FROM warehouse.item AS itm
        GROUP BY itm.product_id
    ) AS itm
    ON prod.product_id = itm.product_id
WHERE
    prod.product_id = '362c3266-ab5a-4f61-bb37-924c2a8b9850';

-------------------------------------------------------------------------
-- Get a list of the opened ticket titles, ordered by decreasing priority 
-- (useful for the customer support)
-------------------------------------------------------------------------

SELECT tkt1.ticket_id, t.subject, tkt1.status,
    tkt1.creation_date AS last_update, tkt1.priority
FROM warehouse.ticket_status AS tkt1
    LEFT JOIN warehouse.ticket t
    ON t.ticket_id = tkt1.ticket_id 
JOIN (
    SELECT ticket_id
    FROM warehouse.ticket_status
    EXCEPT (
        SELECT tkt2.ticket_id
        FROM warehouse.ticket_status AS tkt2
        WHERE tkt2.status='Resolved' OR tkt2.status='Closed'
    )
) AS open_ticket ON tkt1.ticket_id = open_ticket.ticket_id
ORDER BY priority DESC;

-------------------------------------------------------------------------
-- For every employee, get the number of boxes created,
-- and the sum of all the weight for all those boxes
-- and the total amount of money for those boxes
-------------------------------------------------------------------------

SELECT pack.employee_username, SUM(pack.weight) AS total_weight,
    SUM(inv.payment_amount) AS amount_money, count(*) AS number_boxes
FROM warehouse.package AS pack
    LEFT JOIN warehouse.invoice AS inv
    ON pack.id_invoice=inv.invoice_id
GROUP BY pack.employee_username;