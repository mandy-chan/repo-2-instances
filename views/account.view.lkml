view: account {
  #will this overwrite
  sql_table_name: `bigquery-connectors.google_ads.account`
    ;;

  dimension: _fivetran_id {
    type: string
    sql: ${TABLE}._fivetran_id ;;
  }

  dimension_group: _fivetran_synced {
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
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: account_currency_code {
    type: string
    sql: ${TABLE}.account_currency_code ;;
  }

  dimension: account_descriptive_name {
    type: string
    sql: ${TABLE}.account_descriptive_name ;;
  }

  dimension: account_time_zone {
    type: string
    sql: ${TABLE}.account_time_zone ;;
  }

  dimension: customer_descriptive_name {
    type: string
    sql: ${TABLE}.customer_descriptive_name ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: external_customer_id {
    type: number
    sql: ${TABLE}.external_customer_id ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_descriptive_name, account_descriptive_name]
  }
}
