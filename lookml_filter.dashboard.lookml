- dashboard: suggest_explore
  title: suggest_explore
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Testing for LookML Dashboard
    name: Testing for LookML Dashboard
    explore: orders
    type: looker_grid
    model: mandz2114
    fields: [orders.user_id, users.age]
    filters: {}
    sorts: [orders.user_id]
    limit: 500
    query_timezone: Asia/Calcutta
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
      Brand Filter: orders.brand_filter
    row:
    col:
    width:
    height:
  filters:
  - name: Brand Filter
    title: Brand Filter
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: mandz2114
    explore: orders
    listens_to_filters: []
    field: orders.brand_filter
