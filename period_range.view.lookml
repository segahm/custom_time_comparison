- view: period_range
  derived_table:
    sql: |
      (SELECT 
        orders.created_at AS "entire_date_range"
        , TRUE as "is_this_period"
      FROM orders
      WHERE
        {% condition period_1 %} orders.created_at  {% endcondition %}
      GROUP BY 1
      ) UNION ALL (
      SELECT 
        orders.created_at  AS "entire_date_range"
        , FALSE as "is_this_period"
      FROM orders
      WHERE
        {% condition period_2 %} orders.created_at  {% endcondition %}
      GROUP BY 1
      )

  fields:
  - dimension: entire_date_range
    primary_key: true
    hidden: true

# date filter that references payment_date in the derived table
  - filter: period_1
    type: datetime

# date filter for a previous period that references payment_date in the derived table
  - filter: period_2
    type: datetime
    
  - dimension: is_this_period
    type: yesno
    hidden: true
    
  - dimension: period_name
    sql_case:
      "this": ${is_this_period}
      else: "previous"