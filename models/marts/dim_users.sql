{{ config(materialized = 'table') }}

select *
from {{ref('stg_postgres__user')}}