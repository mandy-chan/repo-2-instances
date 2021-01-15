view: derived_table_user_attributes_sql {
  derived_table: {
    sql:
    SELECT {{ testing_remove._parameter_value | remove: "a" }} as aaabbb
    FROM thelook_web_analytics.distribution_centers as A
    LEFT JOIN thelook_web_analytics.events as B
    ON A.id = B.id

    WHERE {% condition B_name_filter %} B.name {% endcondition %}
    ;;
  }

  dimension: id {}

  # dimension: aaabbb {}

  parameter: testing_remove {
    allowed_value: {
      label: "aaabbb"
      value: "aaabbb"
    }
  }

  filter: A_name_filter {
    type: string
  }

  filter: B_name_filter {
    type: string
    suggest_dimension: derived_table_user_attributes_sql.name
  }

}
