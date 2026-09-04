SELECT 
    COUNT(*) AS count_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS nochurn_customers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS churn_rate,
    round(SUM(TotalCharges)/COUNT(*),2) as tottal_revenue,
    sum(case when Churn = 'Yes' THEN TotalCharges ELSE 0 END) AS churn_revenue
FROM WA_Fn_UseC wfuc
