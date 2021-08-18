view: derived_table_reference_templated_filter {
  derived_table: {
    sql:  SELECT filter from ${derived_table_templated_filter.SQL_TABLE_NAME} ;;
  }

dimension: filter_test {}
}
