# Custom Period Comparison

The easiest way to compare measures accross different time intervals is to GROUP the measure by the corresponding timeframe: year, month, hod, etc. 

###  Basic Example: Years, Months, and other date intervals

<look height="250" name="example1">
  model: custom_period_comparison
  base_view: orders
  dimensions: [orders.created_year]
  measures: orders.count
  filters:
    period_range.period_1: 2 years
    period_range.period_2: 1 minute ago
</look>
Notice that here we are exploring a single time range. This works for all basic types of granularities that we can define with LookML: 

```lookml
    - dimension_group: created
      type: time
      timeframes: [time, hour, date, week, month, year, hod, dow_num]
      sql: ${TABLE}.created_at
```  

Alternatively, we can define custom timeframes:

```lookml
    - dimension: fiscal_quarter
      type: int
      sql: CEIL(${created_month_num} / 3.0)

    - dimension: fiscal_yyyyq
      sql: ${created_year} ||  '-Q' || ${fiscal_quarter}
```

###  Custom timeframe with dimensions: Fiscal Year and Quarter over Quarter

<look height="250" name="example1">
  model: custom_period_comparison
  base_view: orders
  dimensions: [orders.fiscal_yyyyq]
  measures: orders.count
  filters:
    period_range.period_1: 2 years
    period_range.period_2: 1 minute ago
    orders.fiscal_quarter: 4
</look>
We did two things here: 
1. defined a new timeframe dimension, 
2. added a filter based on a fiscal quarter.

### Custom timeframe for Transparent Business User Experience (Advanced)

In some cases, business users require full flexibility for comparing this period's value to that of the previous period. For example, the first 7 days of this month vs the first 7 days of a previous month; or Oct 3 - Oct 7 value vs May 3 - May 7 value. In such cases, creating all the possible types of timeframes with dimensions and filters becomes troublesome. We can, however, achieve the same result by using a derived table and two date filters.

<lookml height="300" src="custom_period_comparison.model.lookml">
</lookml>

###  Example: Today vs. Yesterday

Notice how we have a default dimension ```period_name``` that separates an entire date range into two groups - rather than taking on date values (as with above Fiscal Quarter example).

<look height="250" name="example2">
  model: custom_period_comparison
  base_view: orders
  dimensions: [period_range.period_name]
  measures: orders.count
  filters:
    period_range.period_1: today
    period_range.period_2: yesterday
</look>

<look height="250" name="example2">
  model: custom_period_comparison
  base_view: orders
  dimensions: [orders.created_date,period_range.period_name]
  pivots: [period_range.period_name]
  measures: orders.count
  filters:
    period_range.period_1: today
    period_range.period_2: yesterday
</look>

###  Example: First 7 days of this month vs. 7 days of the previous month
<look height="250" name="example2">
  model: custom_period_comparison
  base_view: orders
  dimensions: [period_range.period_name]
  measures: orders.count
  filters:
    period_range.period_1: 0 month ago for 7 days
    period_range.period_2: 1 months ago for 7 days
</look>

<look height="250" name="example2">
  model: custom_period_comparison
  base_view: orders
  dimensions: [orders.created_date,period_range.period_name]
  pivots: [period_range.period_name]
  measures: orders.count
  filters:
    period_range.period_1: 0 month ago for 7 days
    period_range.period_2: 1 months ago for 7 days
</look>
