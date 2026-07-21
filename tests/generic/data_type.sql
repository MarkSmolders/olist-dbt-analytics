{% test data_type(model, column_name, data_type) %}

    SELECT
        column_name,
        data_type AS actual_data_type,
        '{{ data_type }}' AS expected_data_type
    FROM
        `{{ model.database }}`.`{{ model.schema }}`.INFORMATION_SCHEMA.COLUMNS
    WHERE
        table_name = '{{ model.name }}'
        AND column_name = '{{ column_name }}'
        AND data_type != '{{ data_type }}'

{% endtest %}