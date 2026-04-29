with 

source as (

    select * from {{ source('postgres', 'products') }}

),

renamed as (

    select
        product_id,
        price,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed