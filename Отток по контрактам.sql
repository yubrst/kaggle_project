SELECT 
    Contract,
    COUNT(customerID) AS total_clients,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_clients,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS churn_rate
FROM WA_Fn_UseC wfuc
GROUP BY Contract
ORDER BY churn_rate DESC;