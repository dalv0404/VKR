CREATE TABLE IF NOT EXISTS stg.products (
    product_id INT,
    product_name TEXT,
    unit TEXT,
    category TEXT
);

CREATE TABLE IF NOT EXISTS stg.equipment (
    equipment_id INT,
    equipment_name TEXT,
    workshop TEXT,
    equipment_type TEXT
);

CREATE TABLE IF NOT EXISTS stg.employees (
    employee_id INT,
    employee_name TEXT,
    position TEXT,
    workshop TEXT
);

CREATE TABLE IF NOT EXISTS stg.orders (
    order_id INT,
    product_id INT,
    order_date DATE,
    planned_finish_date DATE,
    actual_finish_date DATE,
    quantity INT,
    order_status TEXT
);

CREATE TABLE IF NOT EXISTS stg.operations (
    order_id INT,
    operation_seq INT,
    equipment_id INT,
    operation_name TEXT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    employee_id INT,
    setup_time_hours NUMERIC(6,2)
);

CREATE TABLE IF NOT EXISTS stg.defects (
    defect_id INT,
    order_id INT,
    equipment_id INT,
    defect_type TEXT,
    severity INT,
    defect_date DATE,
    defect_status TEXT
);

CREATE TABLE IF NOT EXISTS stg.downtime (
    downtime_id INT,
    equipment_id INT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    duration_hours NUMERIC(8,2),
    reason TEXT
);
