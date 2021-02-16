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

  # dimension: is_this_possible {
  #   type: yesno
  #   html: {% if order_items.inventory_item_id > 1 %}
  #   <p style="color: green">{{ value }}</p> {% endif %};;
  # }

      # {% if order_items.id._is_filtered and count._value < 2 %}
      #   {{ order_items.status._value }}


  dimension: delivered_at {
    group_label: "group label"
    type: string
    value_format_name: usd
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: returned_at {
    type: string
    sql: ${TABLE}.returned_at ;;
  }

  parameter: current_or_previous_parameter {
    type: unquoted
    allowed_value: {
      label: "current"
      value: "current"
    }
    allowed_value: {
      label: "previous"
      value: "previous"
    }
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
    link: {
      label: "testing out pivot"
      url: "/dashboards/1114?State={{ order_items.order_id._value }}"
    }
  }

  parameter: attribution_window {
    type: unquoted
    allowed_value: {
      label: "testing"
      value: "1"
    }
  }

  measure: sum {
    type: running_total
    sql: ${sale_price} ;;
  }


  dimension: sale_price {
    type: number
    value_format_name: usd
    #sql: ${TABLE}.base_discount_amount;;
    # sql: COALESCE(${TABLE}.sale_price,0) * -1.00;;
    sql: ${TABLE}.sale_price;;
  }

  measure: discount_sum {
    type: sum
    sql:${sale_price};;
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
