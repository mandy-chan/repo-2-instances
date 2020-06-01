view: order_items {
  sql_table_name: thelook_web_analytics.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: []
    sql: ${TABLE}.created_at ;;
  }

  dimension: delivered_at {
    type: string
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: returned_at {
    type: string
    sql: ${TABLE}.returned_at ;;
  }

  parameter: timeframe {
    suggestions: ["Daily","Weekly","Monthly","Quarterly"]
    default_value: "Weekly"
    type: unquoted
  }

  dimension: created_parameter {
    label: "{% if _filters['testing.timeframe'] == 'Daily' %} Created Date
    {% elsif _filters['testing.timeframe'] == 'Weekly' %} Created Week
    {% elsif _filters['testing.timeframe'] == 'Monthly' %} Created Month
    {% elsif _filters['testing.timeframe'] == 'Quarterly' %} Created Quarter
    {% else %} Created Date {% endif %}"
#     label: "{% if _filters['order_items.timeframe'] == 'Daily' %} Created Date
#     {% elsif _filters['order_items.timeframe'] == 'Weekly' %} Created Week
#     {% elsif _filters['order_items.timeframe'] == 'Monthly' %} Created Month
#     {% elsif _filters['order_items.timeframe'] == 'Quarterly' %} Created Quarter
#     {% else %} Created Date {% endif %}"
    type: string
    sql: CASE WHEN {% condition timeframe %} 'Daily' {% endcondition %} then ${created_at_date}
      WHEN {% condition timeframe %} 'Weekly' {% endcondition %} then ${created_at_week}
      WHEN {% condition timeframe %} 'Monthly' {% endcondition %} then ${created_at_month}
      WHEN {% condition timeframe %} 'Quarterly' {% endcondition %} then ${created_at_quarter}
      END;;
      # hidden: yes
    }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: shipped_at {
    type: string
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: sum {
    type: sum
    sql: ${sale_price} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
