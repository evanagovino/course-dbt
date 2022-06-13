{{ config(materialized='view') }}

with source_data as (

    select 
        event_id,
        session_id,
        user_id,
        page_url,
        created_at,
        event_type,
        order_id,
        product_id
    from 
        {{ source('greenery','events') }}

)

select *
from source_data