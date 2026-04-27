CREATE OR REPLACE VIEW dw.v_order_kpi AS
SELECT
    o.order_id,
    p.product_name,
    o.quantity,
    o.order_status,
    o.order_date,
    o.planned_finish_date,
    o.actual_finish_date,
    (o.actual_finish_date - o.planned_finish_date) AS delay_days
FROM dw.fact_orders o
JOIN dw.dim_product p ON p.product_sk = o.product_sk;

CREATE OR REPLACE VIEW dw.v_quality_kpi AS
SELECT
    d.defect_type,
    COUNT(*) AS defects_count,
    AVG(d.severity)::numeric(10,2) AS avg_severity
FROM dw.fact_defects d
GROUP BY d.defect_type;

CREATE OR REPLACE VIEW dw.v_equipment_downtime AS
SELECT
    e.equipment_name,
    e.workshop,
    SUM(t.duration_hours)::numeric(10,2) AS total_downtime_hours
FROM dw.fact_downtime t
JOIN dw.dim_equipment e ON e.equipment_sk = t.equipment_sk
GROUP BY e.equipment_name, e.workshop;
