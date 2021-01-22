view: users {
  sql_table_name:


thelook_web_analytics.users
;;

  drill_fields: [id]

# thelook_web_analytics.users
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  filter: current_time_period {
    type: date
  }

  parameter: dashboard_kpi {
    default_value: "Manifested"
    type: string
    allowed_value: { label: "city" value: "city" }
    allowed_value: { label: "country" value: "country" }
  }


###################################################### Dimensions ############################################################

  dimension: status_type {
    group_label: "Status"
    label: "Status Type"
    case: {
      when: {
        sql: ${age} > 50;;
        label: "greater than 50"
      }
      when: {
        sql: ${age} <= 50 ;;
        label: "less than 50"
      }
    }
  }


  dimension: show_city {
    type: string
    sql: ${city};;
  }

  dimension: show_country {
    type: string
    sql: ${country};;
  }

  dimension: tracking_status {
    sql:
          CASE WHEN {% parameter dashboard_kpi %} = "city" and ${status_type} = 'greater than 50'
          THEN
            ${show_city}
          WHEN {% parameter dashboard_kpi %} = "country" and ${status_type} = 'less than 50'
          THEN
            ${show_country}
          ELSE
          null
          END;;
  }


  # dimension: tracking_status {
  #   group_label: "Status"
  #   sql:
  #         {% if dashboard_kpi._parameter_value == 'scanned_into_carrier_network' and ${status_type} = 'scanned_into_carrier_network' %}
  #           ${scanned_into_carrier_network}
  #         {% elsif dashboard_kpi._parameter_value == 'first_delivery_attempt' and ${status_type} = 'first_delivery_attempt' %}
  #           ${first_delivery_attempt}
  #         {% elsif dashboard_kpi._parameter_value == 'final_delivery' and  ${status_type} = 'final_delivery' %}
  #           ${final_delivery}
  #         {% elsif dashboard_kpi._parameter_value == 'tracking_completed' and  ${status_type} = 'tracking_completed' %}
  #           ${tracking_completed}
  #         {% else %}
  #         null
  #         {% endif %};;
  # }



  # dimension: tracking_status_filtered {
  #   type: string
  #   sql: {% condition %} ${tracking_status} {% endcondition %} ;;
  # }

  # parameter: rank {
  #   default_value: "Manifested"
  #   type: unquoted
  #   allowed_value: { label: "1" value: "1" }
  #   allowed_value: { label: "2" value: "2" }
  #   allowed_value: { label: "3" value: "3" }
  # }

  # dimension: age_status {
  #   sql:
  #   {% if rank._parameter_value == '1' and ${status_type} = 'scanned_into_carrier_network' %}
  #   ${scanned_into_carrier_network}
  #   {% elsif rank._parameter_value == 'first_delivery_attempt' and ${status_type} = 'first_delivery_attempt' %}
  #   ${first_delivery_attempt}
  #   {% elsif rank._parameter_value == 'final_delivery' and  ${status_type} = 'final_delivery' %}
  #   ${final_delivery}
  #   {% else %}
  #   ${city}
  #   {% endif %};;
  # }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }


  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.created_at ;;
  }



## Filtered measures

  filter: first_start_period_filter {
    type: date_time
  }


  filter: first_end_period_filter {
    type: date_time
  }

  filter: second_start_period_filter {
    type: date_time
  }

  filter: second_end_period_filter {
    type: date_time
  }




  dimension: period_st {
    label: "test"
    view_label: "Work in Progress"
    type: date_time
    sql:
   CASE
    WHEN {% parameter number_years %} = "1" THEN DATE_TRUNC(${created_date}, YEAR)
    ELSE NULL
    END
   ;;

    }

    parameter: number_years {
      view_label: "Work in Progress"
      label: "Number of Years"
     type: unquoted
    }


  dimension_group: created_1 {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: DATETIME_ADD(DATETIME(${TABLE}.created_at), INTERVAL 1 DAY) ;;
    convert_tz: no
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_with_liquid {
    type: count
    link: {
      label: "state Count"
      url: "https://www.google.com/search?q={{ state._value }}"
    }
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      order_items.count,
      test.count
    ]
  }
}
