view: flattening_sql_runner_query {
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
        nested_nested.animal AS nested_nested_animal,
        double_unnested.breed, double_unnested.weight,
        triple_unnested.name, triple_unnested.age
      --   ARRAY_CONCAT_AGG(ARRAY(SELECT breed FROM UNNEST(nested_nested.kind))) as breed

      FROM nested_nested

      LEFT JOIN

        UNNEST(nested_nested.kind) as double_unnested

      LEFT JOIN

        UNNEST(double_unnested.instance) as triple_unnested


      GROUP BY 1,2,3,4,5
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

  dimension: breed {
    type: string
    sql: ${TABLE}.breed ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  set: detail {
    fields: [nested_nested_animal, breed, weight, name, age]
  }
}
