- dashboard: lookml_filter
  title: "   asdf"
  layout: newspaper
  preferred_viewer: dashboards
  embed_style:
    background_color: "#f6f8fa"
    show_title: false
    title_color: "#3a4245"
    show_filters_bar: true
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Untitled
    name: Untitled
    model: clean_mandy
    explore: order_items
    type: looker_grid
    fields: [order_items.id, order_items.inventory_item_id, order_items.order_id,
      orders.status, products.brand, products.rank, products.category, products.count,
      orders.count, order_items.sale_price, orders.id, orders.user_id, products.department,
      products.item_name, products.retail_price]
    sorts: [products.count desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 6
  - name: ''
    type: text
    body_text: <center><a href="http://gogo.com">Link</a></center>
    row: 6
    col: 16
    width: 8
    height: 6
  - title: New Tile 2
    name: New Tile 2
    model: mandy_thelook
    explore: products
    type: looker_grid
    fields: [products.brand_category]
    sorts: [products.brand_category]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      product category: products.brand_category
    row: 12
    col: 0
    width: 8
    height: 6
  filters:
  - name: product category
    title: product category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: mandy_thelook
    explore: products
    listens_to_filters: []
    field: products.brand_category
