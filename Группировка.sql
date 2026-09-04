SELECT 
    CASE 
        WHEN tenure <= 6 THEN '0-6 месяцев'
        WHEN tenure > 6 AND tenure <= 12 THEN '7-12 месяцев'
        WHEN tenure > 12 AND tenure < 24 THEN '13-24 месяцев'
        ELSE 'Более 24 месяцев'
    END AS tenure_group,
    COUNT(*) AS total_clients,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_clients,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS churn_rate
FROM WA_Fn_UseC wfuc
GROUP BY CASE 
        WHEN tenure <= 6 THEN '0-6 месяцев'
        WHEN tenure > 6 AND tenure <= 12 THEN '7-12 месяцев'
        WHEN tenure > 12 AND tenure < 24 THEN '13-24 месяцев'
        ELSE 'Более 24 месяцев'
    END
ORDER BY MIN(tenure);