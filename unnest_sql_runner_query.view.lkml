view: unnest_sql_runner_query {
  derived_table: {
    sql: WITH nested_nested AS (SELECT
          *
          FROM UNNEST([
                STRUCT (
                  "Dog" as animal
                  , [
                    STRUCT("Labrodoodle" as breed, 20 as weight,
                      [STRUCT("Junie" as name, 5 as age), STRUCT("Jelly" as name, 8 as age)] as instance
                    )
                    , STRUCT("Poodle" as breed, 40 as weight, [STRUCT("Buffalo" as name, 13 as age)] as instance)
                  ] as kind
                 )
                 ,         STRUCT (
                  "Cat" as animal
                  , [
                    STRUCT("Tabby" as breed, 7 as weight, [STRUCT("Tassles" as name, 5 as age)] as instance)
                    , STRUCT("Fluffy" as breed, 5 as weight,[STRUCT("Foofy" as name, 50 as age)] as instance)
                  ] as kind
                 )
                ])

          )
      SELECT
        nested_nested.animal AS nested_nested_animal
      FROM nested_nested

      GROUP BY 1
      ORDER BY 1
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: nested_nested_animal {
    type: string
    sql: ${TABLE}.nested_nested_animal ;;
  }

  set: detail {
    fields: [nested_nested_animal]
  }
}
