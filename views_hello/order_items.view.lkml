view: order_items {
  sql_table_name: thelook_web_analytics.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # dimension_group: date_created_at {
  #   type: time
  #   timeframes: []
  #   sql: CAST(${TABLE}.created_at AS DATE) ;;
  #   group_label: "Dates"
  # }

  # dimension: date_created_at {
  #       #       kept hidden to reduce confusion between date_mrr_at_end
  #   type: date
  #   datatype: date
  #   sql: ${TABLE}.created_at  ;;
  #   group_label: "Dates"
  # }


  dimension: created_at {
    type: date
    datatype: date
    label: "testing"
    description: "Provides current/end month. Generally the date you want to use"
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: CAST(${TABLE}.created_at AS TIMESTAMP);;
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

  parameter:  input_custom_buckets {
    type: string
    allowed_value: {
      label: "Age"
      value: "home_age"
    }
    allowed_value: {
      label: "Purchase Price"
      value: "purchase_price"
    }
  }

  filter:  input_custom_buckets_field {
    type: string
    sql: {% if input_custom_buckets._parameter_value == "home_age" %}
            ${TABLE}.order_id
         {% else %}
            ${TABLE}.returned_at
            {% endif %};;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: returned_at {
    type: date
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
    html:
    <a href="#drillmenu" target="_self">{{ rendered_value }}</a><font style="color: blue; font-size: 100%">{{sale_price._value}}</font>;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: testing_case_when {
    type: string
    sql:
    CASE
    WHEN ${user_id} > 100 THEN 'AAAA'
    WHEN ${user_id} < 100 THEN 'BBBB'
    END ;;
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
    html: <a href="/explore/mandy_thelook/order_items?fields=order_items.detail*">{{ value }}</a> ;;
    # drill_fields: [detail*]

    # link: {
    #   label: "drill"
    #   url: "{{ link }}"
    # }
  }

  measure: discount_sum {
    type: sum
    sql:${sale_price};;
    drill_fields: [detail*]
    html: <a href="/explore/mandy_thelook/order_items?fields=order_items.detail*">{{ value }}</a> ;;

  }

  measure: total_dollars_change_from_year_ago {
    type: number
    sql: ${sum}*1.0/nullif(${discount_sum},0)-1.0 ;;
    value_format_name: percent_1
    drill_fields: [returned_at]
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
      shipped_at
    ]
  }
}
