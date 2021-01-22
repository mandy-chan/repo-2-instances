view: extending_products_2 {
  extends: [extending_products_1]
  derived_table: {
    sql:
    SELECT * FROM ${extending_products_1.SQL_TABLE_NAME};;
  }
}


view: extending_products_1 {
  extends: [products]
  derived_table: {
    sql:
    SELECT * FROM ${products.SQL_TABLE_NAME};;
  }
}



view: products {
  sql_table_name: thelook_web_analytics.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  parameter: group_label_in_transit {
    type: string
    default_value: "In Transittttttttt"
  }

  dimension: shipment_destination_country {
    label: "Destination Country"
    type: string
    sql: ${TABLE}.brand;;
  }

  dimension: brand {
    view_label: "Inventory Items"
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: brand_category {
    type: string
    suggestable: yes
    sql: CASE WHEN concat(${brand}, ' ', ${category}) = ' ' THEN NULL
        ELSE concat(${brand}, ' ', ${category})
        END;;
  }

  dimension: concat_long_string {
    type: string
    sql: concat(${brand}, ${category}, ${department}) ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: gross_margin {
    type: number
    sql: ${retail_price}-${cost} ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.name, distribution_centers.id, inventory_items.count]
  }
}
