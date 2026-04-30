{{ config(
    materialized='incremental',
    unique_key='_row',
    incremental_strategy='delete+insert'
) }}

with 

source as (

    select * from {{ source('google_sheets', 'budget') }}

),

renamed as (

    select
        _row,
        quantity,
        month,
        product_id,
        _fivetran_synced

    from source

)

select * from renamed

{% if is_incremental() %}
WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }})
{% endif %}