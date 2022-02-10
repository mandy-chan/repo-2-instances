view: order_items_derived_table {
derived_table: {
  sql: SELECT
  id,
  SUM(sale_price) as total_sales
  from ${order_items.SQL_TABLE_NAME};;
}

dimension: id {}

dimension: total_sales {}

measure: avg {
  type: average
  sql: ${total_sales} ;;
}

}
