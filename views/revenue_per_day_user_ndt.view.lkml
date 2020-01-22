# If necessary, uncomment the line below to include explore_source.
# include: "mandy_thelook.model.lkml"

view: revenue_per_day_user_ndt {
  derived_table: {
    explore_source: order_items {
      column: created_at {}
      column: sum {}
      column: user_id {}
    }
  datagroup_trigger: datagroup_1
  }
  dimension: created_at {}
  dimension: sum {
    type: number
  }
  dimension: user_id {
    type: number
  }
}
