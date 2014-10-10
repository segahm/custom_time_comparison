- view: inventory_items
  sql_table_name: public.inventory_items
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: cost
    type: number
    sql: ${TABLE}.cost

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: product_id
    type: int
    # hidden: true
    sql: ${TABLE}.product_id

  - dimension_group: sold
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sold_at

  - measure: count
    type: count
    drill_fields: [id, products.id, products.item_name, order_items.count]

