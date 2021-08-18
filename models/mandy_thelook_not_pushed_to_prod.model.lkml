connection: "bigquery_publicdata_standard_sql"
case_sensitive: no

include: "/views_hello/*.view"
include: "/timeline_viz_bug.dashboard"
include: "/flattening_sql_runner_query.view"

explore: events {}
