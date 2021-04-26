# If necessary, uncomment the line below to include explore_source.
include: "/views_hello/derived_table_templated_filter.view"
include: "/views_hello/products.view"


view: native_derived_table {
  derived_table: {
    explore_source: order_items {

      column: created_at { }
      column: shipped_at { }
      column: user_id { }
      }
  datagroup_trigger: datagroup_1
    }

  dimension: created_at {}
  dimension: shipped_at {
    type: number
  }
  dimension: user_id {
    type: number
  }

}
