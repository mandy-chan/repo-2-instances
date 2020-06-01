# If necessary, uncomment the line below to include explore_source.
# include: "mandy_thelook.model.lkml"

# include: "order_items.view.lkml"
#
# view: revenue_per_day_ndt {
#   derived_table: {
#     explore_source: order_items {
#       column: id {}
#       column: created_at_date {}
#       column: status {}
#       column: sum {}
#       # bind_filters: {
#       #   from_field: revenue_per_day_ndt.filter
#       #   to_field: order_items.status
#       # }
#     }
#     datagroup_trigger: datagroup_1
#   }
#   dimension: id {}
#   dimension: created_at_date {}
#   dimension: sum {
#     type: number
#   }
#
#   dimension: status {}
#
#   filter: filter {
#     default_value: "Complete"
#   }
#
#   filter: filter_id_test {
#     type: number
#     default_value: "100"
#   }
#
# }
