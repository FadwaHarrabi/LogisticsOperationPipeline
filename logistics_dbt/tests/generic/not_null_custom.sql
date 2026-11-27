-- tests/generic/not_null_custom.sql
{% test not_null_custom(model, columns) %}

{% for col in columns %}
  select failed_column, null_rows
  from (
    select
      '{{ col }}' as failed_column,
      count(*) as null_rows
    from {{ model }}
    where {{ col }} is null
  )
  where null_rows > 0
  {% if not loop.last %} union all {% endif %}
{% endfor %}

{% endtest %}