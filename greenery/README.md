Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


## Week 1 Assignment

- How many users do we have?  
Query:
```
select count(distinct user_id) from stg.users
```

 Answer: 130 Users


- On average, how many orders do we receive per hour?

```
with raw_data as (
select 
  date_trunc('hour', created_at),
  count(distinct order_id) as distinct_orders
from stg_orders
group by 1
)
select avg(distinct_orders) from raw_data
```
Answer: 7.5 Orders Per Hour

- On average, how long does an order take from being placed to being delivered?

```
select avg(delivered_at - created_at) from stg_orders where delivered_at is not null
```
Answer: 3 days, 21 hours, 24 minutes

- How many users have only made one purchase? Two purchases? Three+ purchases?

```
with raw_data as (
select 
  user_id,
  count(distinct order_id) as distinct_orders
from
  stg_orders
group by 1
),
grouped_users as (
select
  distinct_orders,
  count(distinct user_id) as count_users
from
  raw_data
group by 1 
)
select
  case when
    distinct_orders = 1 then 1 
    when distinct_orders = 2 then 2 
    else 3 end as distinct_orders,
  sum(count_users) as count_users
from
  grouped_users
group by 1 
order by 1
```
Answer: 25 users with 1 purchase, 28 users with 2 purchases, 71 users with 3 purchases

* On average, how many unique sessions do we have per hour?

```
with raw_data as (
select 
  date_trunc('hour', created_at),
  count(distinct session_id) as distinct_sessions
from stg.events
group by 1 
)
select avg(distinct_sessions) from raw_data
```
Answer: 16.32 sessions per hour
