

view: native_derived_table_b {
  derived_table: {
    explore_source: native_derived_table {

      column: category { field: products.category }
      column: gross_margin { field: products.gross_margin }
      column: count { field: products.count }
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

  measure: sum_of_count {
    type: sum
    sql: ${count} ;;
  }

  filter: category_test {
    type: string
  }
}
