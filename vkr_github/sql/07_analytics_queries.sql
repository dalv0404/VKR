SELECT product_name, COUNT(*) AS orders_count
FROM dw.v_order_kpi
GROUP BY product_name
ORDER BY orders_count DESC;

SELECT equipment_name, total_downtime_hours
FROM dw.v_equipment_downtime
ORDER BY total_downtime_hours DESC;

SELECT defect_type, defects_count, avg_severity
FROM dw.v_quality_kpi
ORDER BY defects_count DESC;
