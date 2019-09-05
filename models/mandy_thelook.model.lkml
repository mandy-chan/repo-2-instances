connection: "bigquery_publicdata_standard_sql"

include: "/views/*.view"

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
