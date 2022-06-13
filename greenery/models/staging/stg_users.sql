{{ config(materialized='view') }}

with source_data as (

    select 
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at,
        updated_at,
        address_id
    from 
        {{ source('greenery','users') }}

)

select *
from source_data