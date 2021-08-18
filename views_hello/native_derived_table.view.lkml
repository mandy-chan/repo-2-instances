# If necessary, uncomment the line below to include explore_source.
include: "/views_hello/derived_table_templated_filter.view"
include: "/views_hello/products.view"


view: native_derived_table{
  derived_table: {
    explore_source: derived_table_templated_filter {

      column: category { field: products.category }
      column: gross_margin { field: products.gross_margin }
      column: count { field: products.count }
      column: filter_test {}
      }
  datagroup_trigger: datagroup_1
    }

  dimension: category {}
  dimension: gross_margin {
    type: number
  }
  dimension: count {
    type: number
  }

  filter: filter_test {}

  measure: sum_of_count {
    type: sum
    sql: ${count} ;;
  }

  filter: category_test {
    type: string
  }
}
