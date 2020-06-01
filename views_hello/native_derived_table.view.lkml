# If necessary, uncomment the line below to include explore_source.
# include: "mandy_thelook.model.lkml"

# view: native_derived_table {
#   derived_table: {
#     explore_source: inventory_items {
#       bind_filters: {
#         from_field: native_derived_table.category_test
#         to_field: products.category
#       }
#       column: category { field: products.category }
#       column: gross_margin { field: products.gross_margin }
#       column: count { field: products.count }
#     }
#
#   }
#
#   dimension: category {}
#   dimension: gross_margin {
#     type: number
#   }
#   dimension: count {
#     type: number
#   }
#
#   measure: sum_of_count {
#     type: sum
#     sql: ${count} ;;
#   }
#
#   filter: category_test {
#     type: string
#   }
# }
