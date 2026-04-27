`data/` — исходные CSV-файлы
`sql/` — DDL, загрузка, ETL, аналитические представления
`scripts/` — вспомогательные скрипты
`reports/` — визуализации
`docs/` — схема архитектуры

Порядок запуска
1. Создать схемы и таблицы из `sql/01_create_schemas.sql`, `sql/02_create_staging_tables.sql`, `sql/03_create_dw_tables.sql`.
2. Загрузить CSV в staging.
3. Выполнить `sql/05_etl.sql`.
4. Создать представления из `sql/06_analytics_views.sql`.
5. Запустить `sql/07_analytics_queries.sql`.

Пути в `COPY` заданы для локального запуска из корня проекта.
