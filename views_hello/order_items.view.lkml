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
    timeframes: [date]
    sql: ${TABLE}.created_at ;;
  }

  # dimension: is_this_possible {
  #   type: yesno
  #   html: {% if order_items.inventory_item_id > 1 %}
  #   <p style="color: green">{{ value }}</p> {% endif %};;
  # }

  dimension: dummy {
    description: "Whether or not this works"
    type: yesno
    html: {% if dummy %}
      <p style="color: green">{{ value }}</p>
      {% else %}
      <p style="color: red">{{ value }}</p>
      {% endif %};;
  }

  dimension: results_kpi {
    type: string
    sql: case
      when 'New Pipeline' = 'New Pipeline' then 'New Pipeline'
      end;;
  }


  dimension: delivered_at {
    type: string
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
    link: {
      label: "testing out pivot"
      url: "/dashboards/1114?State={{ order_items.order_id._value }}"
    }
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
