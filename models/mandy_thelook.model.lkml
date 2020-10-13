connection: "bigquery_publicdata_standard_sql"
case_sensitive: no

aggregate_awareness: yes

include: "/views_hello/*.view"
include: "/timeline_viz_bug.dashboard"
include: "/flattening_sql_runner_query.view"

datagroup: datagroup_1 {
  sql_trigger: SELECT DATE_PART('hour', NOW()) ;;
  max_cache_age: "24 hours"
}

access_grant: access_grant_name {
  user_attribute: company_id
  allowed_values: []
}

# explore: revenue_per_day_ndt {
#   join: order_items {
#     sql_on: ${revenue_per_day_ndt.id} = ${order_items.id} ;;
#     type: left_outer
#     relationship: many_to_one
#     sql_where:
# --    {% condition revenue_per_day_ndt.filter_id_test %} ${order_items.id} {% endcondition %}
# --    AND
#     ${order_items.id} in (select {% condition revenue_per_day_ndt.filter_id_test %} ${order_items.id} {% endcondition %} from revenue_per_day_ndt) ;;
#   }
# }

explore: order_items {
  join: testing {
    from: order_items
    sql_on: ${testing.order_id} = ${order_items.id} ;;
  }
}

# explore: products {
#   join: testing {
#     from: order_items
#   type: cross
#   }
#
# }

# explore: revenue_per_day_user_ndt {}

########## CODE FOR BUG MOD-2324
explore: products {
#   fields: [ALL_FIELDS*,-testing.created_parameter]
  join: testing {
    from: order_items
    sql_on: ${testing.id} = ${products.id};;
    relationship: many_to_one
  }
}

##########

explore: inventory_items {
  view_name: inventory_items
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

explore: +inventory_items {
  join: users {
  }
}

explore: users_inventory_items {
  label: "users"
  extends: [inventory_items]
  join: users {
    sql_on: ${users.id}=${inventory_items.id} ;;
  }
}


# explore: native_derived_table {
#   join: inventory_items {
#     sql_on: ${native_derived_table.category}=${inventory_items.product_category} ;;
#     relationship: many_to_one
#   }
# }

explore: flattening_sql_runner_query {}
