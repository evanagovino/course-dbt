{{ config(materialized='view') }}

with source_data as (

    select 
        product_id,
        name,
        price,
        inventory
    from 
        {{ source('greenery','products') }}

)

select *
from source_data