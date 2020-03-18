# If necessary, uncomment the line below to include explore_source.
# include: "mandy_thelook.model.lkml"

include: "order_items.view.lkml"

view: revenue_per_day_ndt {
  derived_table: {
    explore_source: order_items {
      timezone: "query_timezone"
      column: created_at_date {}
      column: sum {}
    }
  }
  dimension: created_at {}
  dimension: sum {
    type: number
  }

}
