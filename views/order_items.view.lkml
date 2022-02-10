view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
    description: "Represents the state of the SnapshotEvent.
    /n
    VALID: Snapshots were backfilled successfully for an ad.
    INVALID: A validation issue was encountered while attempting to backfill snapshots for an ad (e.g., unable to parse VASTs)"
  }

  parameter: date_granularity {
    type: unquoted
    suggest_explore: order_items
    suggest_dimension: id
  }


    dimension: testing_parameter {
      sql: ${TABLE}.id ;;
      link: {
         url: "/dashboards-next/150?Currency={{ date_granularity._parameter_value }}"
         label: "testing"
        }
    }

  # dimension: testing_date_granularity_in_query {
  #   type: string
  #   sql:
  #   {% if _user_attributes['sarah_test'] == "sarah" %}
  # inventory_item_id
  #   {% else %}
  #       ${TABLE}.order_id

  #   {% endif %} ;;
  # }


  dimension: order_id_bucket {
    type: number
    sql: CASE WHEN ${TABLE}.order_id >5 and ${TABLE}.order_id <= 600 then "test"
              WHEN ${TABLE}.order_id >=5 and ${TABLE}.order_id < 700 then "what will happen"
              END;;
  }

  dimension: order_id_tier {
    type: string
    # hidden: yes
    sql:  ${TABLE}.order_id ;;
    suggestions: ["red", "yellow", "blue"]

  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id;;
    html: <img src="https://s3-us-west-2.amazonaws.com/urbanstems-com/products/2014.8.27_urbanstems_bullmoose_bowtie_pink.jpg"> ;;
  }


  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: returned_time_2 {
    type: date_time
    sql: ${TABLE}.returned_at ;;

  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: max_of_sale_price {
    type: max
    sql: ${TABLE}.sale_price ;;
    }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]

  }

  measure: filtered_measure {
    type: count
    filters: [returned_date: "-NULL"]
    drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: testing_filtered_measure {
    type: number
    sql: ${filtered_measure} /${count} ;;
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
