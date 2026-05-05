{{ config(materialized = 'table') }}

WITH fct AS (
    SELECT
        o.* EXCLUDE (order_total, order_cost, shipping_cost),
        TRY_CAST(REPLACE(o.order_total::STRING,    ',', '.') AS NUMBER(18, 2)) AS order_total,
        TRY_CAST(REPLACE(o.order_cost::STRING,     ',', '.') AS NUMBER(18, 2)) AS order_cost,
        TRY_CAST(REPLACE(o.shipping_cost::STRING,  ',', '.') AS NUMBER(18, 2)) AS shipping_cost,
        o.created_at AS order_date,
        a.country                                                              AS address_country
    FROM {{ ref('dim_orders') }} o
    INNER JOIN {{ ref('dim_addresses') }} a ON o.address_id = a.address_id
    INNER JOIN {{ ref('dim_users') }}     u ON o.user_id    = u.user_id
)

SELECT * FROM fct