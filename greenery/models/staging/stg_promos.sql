{{ config(materialized='view') }}

with source_data as (

    select 
        promo_id,
        discount,
        status
    from 
        {{ source('greenery','promos') }}

)

select *
from source_data