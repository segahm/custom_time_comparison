- view: users
  sql_table_name: public.users
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: age
    type: int
    sql: ${TABLE}.age

  - dimension: city
    sql: ${TABLE}.city

  - dimension: country
    sql: ${TABLE}.country

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: email
    sql: ${TABLE}.email

  - dimension: first_name
    sql: ${TABLE}.first_name

  - dimension: gender
    sql: ${TABLE}.gender

  - dimension: last_name
    sql: ${TABLE}.last_name

  - dimension: state
    sql: ${TABLE}.state

  - dimension: traffic_source
    sql: ${TABLE}.traffic_source

  - dimension: zip
    type: int
    sql: ${TABLE}.zip

  - measure: count
    type: count
    drill_fields: [id, first_name, last_name, orders.count]

