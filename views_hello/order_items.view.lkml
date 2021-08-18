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
    sql: CAST(${TABLE}.created_at AS DATE) ;;
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
    type: average
    sql: ${sale_price} ;;
    drill_fields: [sale_price]
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

  measure: total_dollars_change_from_year_ago {
    type: number
    sql: ${sum}*1.0/nullif(${discount_sum},0)-1.0 ;;
    value_format_name: percent_1
  }


################# BUG DD-2015
  measure: Dollar_per_TDP {
    type: number
    sql: ${sum}/nullif(${discount_sum},0)  ;;
    #sql: ${total_dollars}/nullif(${item_level_ranks.total_tdp},0)  ;;
    value_format: "[>=1000000]0.0,,\" M\";[>=1000]0.0,\" K\";[<1000]0.0" # this causes error in excel
    # value_format: "[>=1000000]0.0,,\" M\";[>=1000]0.0,\" K\";0.0" # this doesn't cause error in excel
    }

#################

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
