- dashboard: timeline_viz_bug
  title: Timeline Viz Bug
  layout: tile
  tile_size: 100
  elements:
    - name: add_a_unique_name_1584489380
      title: Untitled Visualization
      model: mandy_thelook
      explore: users
      type: looker_timeline
      fields: [users.id, users.last_name, users.created_date,users.created_date_1, users.count]
      filters:
        users.current_time_period: 2 years
        users.gender: Female
      sorts: [users.id desc]
      limit: 5000
      dynamic_fields:
        - table_calculation: ifc_availability
          label: IFC Availability
          expression: if(is_null(${users.count}),-1,round(${users.count},3))
          value_format:
          value_format_name: percent_1
          _kind_hint: measure
          _type_hint: number
      query_timezone: America/Los_Angeles
      groupBars: true
      labelSize: 9pt
      showLegend: true
      color_application:
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom:
            id: eed9269b-eed7-4968-585d-e8b0b858b01d
            label: Custom
            type: continuous
            stops:
              - color: "#3D52B9"
                offset: 0
              - color: "#FC2E31"
                offset: 50
              - color: "#000000"
                offset: 100
            options:
            steps: 5
            reverse: false
      valueFormat: yyyy-mm-dd hh:mm
      show_view_names: false
      show_row_numbers: true
      truncate_column_names: false
      hide_totals: false
      hide_row_totals: false
      table_theme: editable
      limit_displayed_rows: false
      enable_conditional_formatting: false
      conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3EB0D5",font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7, palette_id: 1e4d66b9-f066-4c33-b0b7-cc10b4810688, options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}}, mirror: true, reverse: false, stepped: false}}, bold: false, italic: false, strikethrough: false, fields: !!null ''}]
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      series_types: {}
      hidden_fields: [users.count]
      defaults_version: 1
