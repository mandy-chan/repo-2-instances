###

view: inventory_items {
  sql_table_name: thelook_web_analytics.inventory_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: product_name_trim {
    type: string
    sql: trim(${product_name}) ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: created_at {
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension: sold_at {
    type: string
    sql: ${TABLE}.sold_at ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: html_single_viz {
    description: "Cart Quantity * FFF Sale Price"
    label: "               Cart Revenue ($)"
    type: sum
    sql: ${TABLE}.product_retail_price;;
    value_format_name: usd
    html:
    <div style="padding: 0px; font-size:16pt"><b>Revenue this Sale</b></div>
    <div style="padding: 0px; font-size:24pt"><b>{{rendered_value}}</b></div>
    <div style="padding: 0px; font-size:16pt"><b>Orders this Sale</b></div>
    ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      product_name,
      products.name,
      products.id,
      order_items.count,
      test.count
    ]
  }
}
