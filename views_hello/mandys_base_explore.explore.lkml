connection: "bigquery_publicdata_standard_sql"

include: "/views_hello/*.view"
include: "/timeline_viz_bug.dashboard"

datagroup: datagroup_1 {
  sql_trigger: SELECT DATE_PART('hour', NOW()) ;;
  max_cache_age: "24 hours"
}

explore: revenue_per_day_ndt {
  join: order_items {
    sql_on: ${revenue_per_day_ndt.id} = ${order_items.id} ;;
    type: left_outer
    relationship: many_to_one
    sql_where:
    --    {% condition revenue_per_day_ndt.filter_id_test %} ${order_items.id} {% endcondition %}
    --    AND
        ${order_items.id} in (select {% condition revenue_per_day_ndt.filter_id_test %} ${order_items.id} {% endcondition %} from revenue_per_day_ndt) ;;
  }
}

explore: revenue_per_day_user_ndt {}

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

explore: events {}

explore: users {
  from: users
}

explore: test {}

explore: native_derived_table {
  join: inventory_items {
    sql_on: ${native_derived_table.category}=${inventory_items.product_category} ;;
    relationship: many_to_one
  }
}
