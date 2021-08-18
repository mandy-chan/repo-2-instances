view: derived_table_templated_filter {
  derived_table: {
  sql:
  SELECT
       users.first_name,
        users.created_at
      FROM
          thelook_web_analytics.users as users




      GROUP BY 1,2
    ;;
    datagroup_trigger: datagroup_1
  }


dimension: first_name {
  primary_key: yes
}


dimension_group: created {
  type: time
  timeframes: []
  sql: ${TABLE}.created_at ;;
}

dimension: is_before_mtd {
  type: yesno
   sql: (EXTRACT(DAY FROM ${created_date}) < EXTRACT(DAY FROM CURRENT_DATE)
   OR
  (
  EXTRACT(DAY FROM ${created_date}) = EXTRACT(DAY FROM CURRENT_DATE)
  )
   OR
   (

  EXTRACT(DAY FROM ${created_date}) = EXTRACT(DAY FROM CURRENT_DATE)
  )

  );;

}
}
