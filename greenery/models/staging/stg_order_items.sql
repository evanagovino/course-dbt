{{ config(materialized='view') }}

with source_data as (

    select 
        order_id,
        product_id,
        quantity
    from 
        {{ source('greenery','order_items') }}

)

select *
from source_data