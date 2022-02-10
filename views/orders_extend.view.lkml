include: "/views/orders.view.lkml"

view: orders_extend {
  extends: [orders]

  dimension_group: created {}

}
