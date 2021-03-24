include: "/views_hello/native_derived_table.view.lkml"

view: native_derived_table_c {
  derived_table: {
    sql:  SELECT * FROM ${native_derived_table.SQL_TABLE_NAME} ;;
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

  filter: filter_test {}

}
