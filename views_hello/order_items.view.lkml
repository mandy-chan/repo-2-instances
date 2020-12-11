view: order_items {
  sql_table_name: thelook_web_analytics.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  filter: team_id_dynamic {
    type: string
    label: "Team/Workspace/Enterprise ID"
    view_label: "2. Company Attributes"
    sql: ({% condition team_id_dynamic %} status {% endcondition %})
      ;;
  }

  parameter: testing_liquid_label{
    label: "{% if _user_attributes['company'] == 'Looker' %} Employee Name {% else %} Customer Name {% endif %}"
    type: unquoted
    default_value: "TESTING"
    }

  dimension_group: created_at {
    type: time
    timeframes: []
    sql: ${TABLE}.created_at ;;
  }

  dimension: period_st {
    label: "test"
    view_label: "Work in Progress"
    type: string
    sql:
    {%      if number_years._parameter_value == '1' %}
    ${created_at_date}
    {% endif %}
   ;;

    }

    parameter: number_years {
      view_label: "Work in Progress"
      label: "Number of Years"
      default_value: "1"
      type: unquoted
  }

  dimension: liquid_filter_object_name {
    type: string
    sql: 'Placeholder';;
    html:

     {% if order_items.id._is_filtered and count._value == 1 %}
        {{ order_items.status._value }}
      {% else %}
        'All Districts'
      {% endif %} ;;
  }

  # dimension: is_this_possible {
  #   type: yesno
  #   html: {% if order_items.inventory_item_id > 1 %}
  #   <p style="color: green">{{ value }}</p> {% endif %};;
  # }

      # {% if order_items.id._is_filtered and count._value < 2 %}
      #   {{ order_items.status._value }}

  dimension: dummy {
    group_item_label: "group item label"
    description: "Whether or not this works"
    type: yesno
    html: {% if dummy %}
      <p style="color: green">{{ value }}</p>
      {% else %}
      <p style="color: red">{{ value }}</p>
      {% endif %};;
  }

  dimension: results_kpi {
    group_item_label: "group item label"
    type: string
    sql: case
      when 'New Pipeline' = 'New Pipeline' then 'New Pipeline'
      end;;
  }

  parameter: dynamic_measure_filter {
    type: number

    default_value: "1"
  }

  measure: dynamic_measure_ty {
    label: "Dynamic Measure"
    group_label: "This Year"
    label_from_parameter: dynamic_measure_filter
    type: number
    sql:
    {%      if dynamic_measure_filter._parameter_value == '2' %}      ${sale_price}
    {% elsif dynamic_measure_filter._parameter_value == '3' %}       ${inventory_item_id}

    {% endif %};;
    html:
    {% if dynamic_measure_filter._parameter_value == '2' %} {{ sale_price._rendered_value }}
    {% elsif dynamic_measure_filter._parameter_value == '3' %}       {{ delivered_at._rendered_value }}
    {% endif %};;
  }


  dimension: delivered_at {
    group_label: "group label"
    type: string
    value_format_name: usd
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    group_label: "group label"
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
    value_format_name: usd
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
    value_format_name: usd


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
