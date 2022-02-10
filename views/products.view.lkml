view: products {
  sql_table_name: demo_db.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: retail_price_classic_tier {
    type: tier
    style: classic
    tiers: [1, 49.99, 120, 150.99]
    sql: ${TABLE}.retail_price ;;
  }

  dimension: retail_price_interval_tier {
    type: tier
    style: interval
    tiers: [1, 49.99, 120, 150.99]
    sql: ${TABLE}.retail_price ;;
  }

  dimension: retail_price_integer_tier {
    type: tier
    style: integer
    tiers: [1, 49, 120, 150]
    sql: ${TABLE}.retail_price ;;
  }

  dimension: retail_price_relational_tier {
    type: tier
    style: relational
    tiers: [1, 49.99, 120, 150.99]
    sql: ${TABLE}.retail_price ;;
  }


  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
