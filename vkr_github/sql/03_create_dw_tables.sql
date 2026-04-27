CREATE TABLE IF NOT EXISTS dw.dim_product (
    product_sk SERIAL PRIMARY KEY,
    product_id INT NOT NULL UNIQUE,
    product_name VARCHAR(200) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    category VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS dw.dim_equipment (
    equipment_sk SERIAL PRIMARY KEY,
    equipment_id INT NOT NULL UNIQUE,
    equipment_name VARCHAR(200) NOT NULL,
    workshop VARCHAR(100) NOT NULL,
    equipment_type VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS dw.dim_employee (
    employee_sk SERIAL PRIMARY KEY,
    employee_id INT NOT NULL UNIQUE,
    employee_name VARCHAR(200) NOT NULL,
    position VARCHAR(100) NOT NULL,
    workshop VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS dw.dim_date (
    date_sk SERIAL PRIMARY KEY,
    date_value DATE NOT NULL UNIQUE,
    year_num INT NOT NULL,
    month_num INT NOT NULL,
    day_num INT NOT NULL,
    quarter_num INT NOT NULL
);

CREATE TABLE IF NOT EXISTS dw.fact_orders (
    order_fact_sk BIGSERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_sk INT NOT NULL REFERENCES dw.dim_product(product_sk),
    order_date DATE NOT NULL,
    planned_finish_date DATE NOT NULL,
    actual_finish_date DATE NOT NULL,
    quantity INT NOT NULL,
    order_status VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS dw.fact_operations (
    operation_fact_sk BIGSERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    operation_seq INT NOT NULL,
    equipment_sk INT NOT NULL REFERENCES dw.dim_equipment(equipment_sk),
    employee_sk INT NOT NULL REFERENCES dw.dim_employee(employee_sk),
    operation_name VARCHAR(100) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    duration_minutes INT NOT NULL,
    setup_time_hours NUMERIC(6,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS dw.fact_defects (
    defect_fact_sk BIGSERIAL PRIMARY KEY,
    defect_id INT NOT NULL,
    order_id INT NOT NULL,
    equipment_sk INT NOT NULL REFERENCES dw.dim_equipment(equipment_sk),
    defect_type VARCHAR(100) NOT NULL,
    severity INT NOT NULL,
    defect_date DATE NOT NULL,
    defect_status VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS dw.fact_downtime (
    downtime_fact_sk BIGSERIAL PRIMARY KEY,
    downtime_id INT NOT NULL,
    equipment_sk INT NOT NULL REFERENCES dw.dim_equipment(equipment_sk),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    duration_hours NUMERIC(8,2) NOT NULL,
    reason VARCHAR(150) NOT NULL
);
