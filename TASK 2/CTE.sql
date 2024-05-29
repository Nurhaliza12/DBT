WITH CTE_sales AS (
    SELECT 
        orders.order_date,
        order_details.quantity,
        order_details.price,
        products."name" AS product_name,
        products.brand_id as brand_id
    FROM 
        orders 
        LEFT JOIN order_details 
            ON orders.order_id = order_details.order_id 
        LEFT JOIN products 
            ON order_details.product_id = products.product_id 
)
, CTE_sales_brand AS (
    SELECT 
        date(order_date) as "Order Date",
        product_name AS "Product Name",
        brands."name" AS "Brand Name",
        SUM(quantity) AS "Qty Sold",
        SUM(quantity * price) AS "Revenue"
    FROM 
        CTE_sales
        LEFT JOIN brands
            ON CTE_sales.brand_id = brands.brand_id
    GROUP BY 1, 2, 3
)
SELECT * FROM CTE_sales_brand
ORDER BY 2 ASC;