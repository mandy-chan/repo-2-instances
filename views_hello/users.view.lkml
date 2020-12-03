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
