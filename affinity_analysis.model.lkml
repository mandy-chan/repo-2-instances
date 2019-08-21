connection: "thelook"

# include all the views
include: "*.view"

datagroup: affinity_analysis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: affinity_analysis_default_datagroup

explore: order_purchase_affinity {
  always_filter: {
    filters: {
      field: affinity_timeframe
      value: "last 90 days"
    }
  }

  join: total_orders {
    type: cross
    relationship: many_to_one
  }
}
