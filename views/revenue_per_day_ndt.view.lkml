# If necessary, uncomment the line below to include explore_source.
# include: "mandy_thelook.model.lkml"

view: revenue_per_day_ndt {
  derived_table: {
    explore_source: order_items {
      column: created_at {}
      column: sum {}
    }
    datagroup_trigger: datagroup_1
  }
  dimension: created_at {}
  dimension: sum {
    type: number
  }

}
