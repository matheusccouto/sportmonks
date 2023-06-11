{% snapshot probabilities_snapshot %}

select * from {{ source('sportmonks', 'probabilities') }}

{% endsnapshot %}