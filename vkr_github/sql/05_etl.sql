TRUNCATE TABLE dw.fact_orders, dw.fact_operations, dw.fact_defects, dw.fact_downtime, dw.dim_date RESTART IDENTITY CASCADE;
TRUNCATE TABLE dw.dim_product, dw.dim_equipment, dw.dim_employee RESTART IDENTITY CASCADE;

-- dimensions
INSERT INTO dw.dim_product (product_id, product_name, unit, category)
SELECT product_id, product_name, unit, category
FROM stg.products;

INSERT INTO dw.dim_equipment (equipment_id, equipment_name, workshop, equipment_type)
SELECT equipment_id, equipment_name, workshop, equipment_type
FROM stg.equipment;

INSERT INTO dw.dim_employee (employee_id, employee_name, position, workshop)
SELECT employee_id, employee_name, position, workshop
FROM stg.employees;

INSERT INTO dw.dim_date (date_value, year_num, month_num, day_num, quarter_num)
SELECT d::date,
       EXTRACT(YEAR FROM d)::int,
       EXTRACT(MONTH FROM d)::int,
       EXTRACT(DAY FROM d)::int,
       EXTRACT(QUARTER FROM d)::int
FROM generate_series('2025-01-01'::date, '2025-12-31'::date, interval '1 day') AS d;

-- facts
INSERT INTO dw.fact_orders (order_id, product_sk, order_date, planned_finish_date, actual_finish_date, quantity, order_status)
SELECT o.order_id,
       p.product_sk,
       o.order_date::date,
       o.planned_finish_date::date,
       o.actual_finish_date::date,
       o.quantity,
       o.order_status
FROM stg.orders o
JOIN dw.dim_product p ON p.product_id = o.product_id;

INSERT INTO dw.fact_operations (order_id, operation_seq, equipment_sk, employee_sk, operation_name, start_time, end_time, duration_minutes, setup_time_hours)
SELECT op.order_id,
       op.operation_seq,
       e.equipment_sk,
       emp.employee_sk,
       op.operation_name,
       op.start_time::timestamp,
       op.end_time::timestamp,
       EXTRACT(EPOCH FROM (op.end_time::timestamp - op.start_time::timestamp))::int / 60,
       op.setup_time_hours::numeric(6,2)
FROM stg.operations op
JOIN dw.dim_equipment e ON e.equipment_id = op.equipment_id
JOIN dw.dim_employee emp ON emp.employee_id = op.employee_id;

INSERT INTO dw.fact_defects (defect_id, order_id, equipment_sk, defect_type, severity, defect_date, defect_status)
SELECT d.defect_id,
       d.order_id,
       e.equipment_sk,
       d.defect_type,
       d.severity,
       d.defect_date::date,
       d.defect_status
FROM stg.defects d
JOIN dw.dim_equipment e ON e.equipment_id = d.equipment_id;

INSERT INTO dw.fact_downtime (downtime_id, equipment_sk, start_time, end_time, duration_hours, reason)
SELECT t.downtime_id,
       e.equipment_sk,
       t.start_time::timestamp,
       t.end_time::timestamp,
       t.duration_hours::numeric(8,2),
       t.reason
FROM stg.downtime t
JOIN dw.dim_equipment e ON e.equipment_id = t.equipment_id;
