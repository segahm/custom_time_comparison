- connection: red_look

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards


- explore: orders
  hidden: true
  conditionally_filter:
    period_range.period_1: today
    period_range.period_2: 1 minutes ago  #default is no previous period
  joins:
    - join: period_range
      sql: |
        INNER JOIN period_range
          ON orders.created_at = period_range.entire_date_range
