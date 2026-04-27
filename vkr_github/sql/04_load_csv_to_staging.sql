COPY stg.products FROM 'data/products.csv' CSV HEADER ENCODING 'UTF8';
COPY stg.equipment FROM 'data/equipment.csv' CSV HEADER ENCODING 'UTF8';
COPY stg.employees FROM 'data/employees.csv' CSV HEADER ENCODING 'UTF8';
COPY stg.orders FROM 'data/orders.csv' CSV HEADER ENCODING 'UTF8';
COPY stg.operations FROM 'data/operations.csv' CSV HEADER ENCODING 'UTF8';
COPY stg.defects FROM 'data/defects.csv' CSV HEADER ENCODING 'UTF8';
COPY stg.downtime FROM 'data/downtime.csv' CSV HEADER ENCODING 'UTF8';
