connection: "bigquery_publicdata_standard_sql"

aggregate_awareness: yes

include: "/views/*.view"

datagroup: datagroup_1 {
  max_cache_age: "24 hours"
}

explore: order_items {}

explore: inventory_items {
  join: products {
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: distribution_centers {
    sql_on: ${products.distribution_center_id}=${distribution_centers.id} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: users {
  join: events {
    sql_on: ${users.id}=${events.user_id} ;;
    type: left_outer
    relationship: one_to_many
  }
}

explore: native_derived_table {
  join: inventory_items {
    sql_on: ${native_derived_table.category}=${inventory_items.product_category} ;;
    relationship: many_to_one
  }
}
