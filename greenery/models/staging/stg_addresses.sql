{{ config(materialized='view') }}

with source_data as (

    select 
        address_id,
        address,
        zipcode,
        state,
        country
    from 
        {{ source('greenery','addresses') }}

)

select *
from source_data