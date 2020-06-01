# If necessary, uncomment the line below to include explore_source.
# include: "mandy_thelook.model.lkml"
#
# include: "order_items.view.lkml"
#
# view: revenue_per_day_user_ndt {
#   derived_table: {
#     explore_source: order_items {
#       column: created_at_date {}
#       column: sum {}
#       column: user_id {}
#       derived_column: user_over_sum {
#         sql:  sum / user_id ;;
#       }
#     }
#   }
#   dimension: created_at {}
#   dimension: sum {
#     type: number
#   }
#   dimension: user_id {
#     type: number
#   }
#   dimension: user_over_sum {}
#   dimension: user_over_sum_2 {
#     sql: ${user_over_sum};;
# }
# }
