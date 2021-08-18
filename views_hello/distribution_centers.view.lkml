view: distribution_centers {
  sql_table_name:
thelook_web_analytics.distribution_centers ;;

  drill_fields: [id]


## Bug for DX-5120
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    value_format_name: usd
    html: {{ value }} <br></br><br></br>;;

  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    html: {{ value }} <br></br><br></br>;;
    drill_fields: [id]
  }


  measure: count {
    type: count
    drill_fields: [id, name, products.count]
    html: {{ rendered_value }} <br></br>
    <br></br>
    Product Title <br></br>
    {{ value }} <br></br>
    <br></br>
    Product SKU <br></br>
    {{ value }};;

  }

  measure: net_sales_variance_pct {
    tags: ["vis-tools:heading:Sales", "vis-tools:short_name:Var %"]
    type: number
    sql:  (${count} / nullif(${count},0)) ;;
    value_format_name: percent_1
  }
}
