select
    country
    , date(order_date)
    , sum(quantity) as total_quantity
    , sum(price) as total_revenue
from {{ ref ('stg_normalize_country') }}
group by 1,2