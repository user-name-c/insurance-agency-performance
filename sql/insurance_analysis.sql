/* =========================================================
   Insurance Agency Performance Analysis
   ========================================================= */

/* 1. Overview of the dataset */
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT Agent_ID) AS total_agents,
    COUNT(DISTINCT State) AS total_states,
    COUNT(DISTINCT Marketing_Channel) AS total_channels
FROM insurance_data;


/* 2. Top 10 agents by total premium revenue */
SELECT
    Agent_ID,
    SUM(Policies_Sold) AS total_policies_sold,
    SUM(Premium_Amount) AS total_premium_amount
FROM insurance_data
GROUP BY Agent_ID
ORDER BY total_premium_amount DESC
LIMIT 10;


/* 3. Performance by state */
SELECT
    State,
    SUM(Policies_Sold) AS total_policies_sold,
    SUM(Premium_Amount) AS total_premium_amount,
    AVG(ROI) AS avg_roi
FROM insurance_data
GROUP BY State
ORDER BY total_premium_amount DESC;


/* 4. ROI by marketing channel */
SELECT
    Marketing_Channel,
    AVG(ROI) AS avg_roi,
    AVG(Acquisition_Cost) AS avg_acquisition_cost,
    AVG(Retention_Rate) AS avg_retention_rate
FROM insurance_data
GROUP BY Marketing_Channel
ORDER BY avg_roi DESC;


/* 5. Monthly sales trends */
SELECT
    DATE_TRUNC('month', Month) AS sales_month,
    SUM(Policies_Sold) AS total_policies_sold,
    SUM(Premium_Amount) AS total_premium_amount
FROM insurance_data
GROUP BY sales_month
ORDER BY sales_month;


/* 6. Cost vs retention analysis */
SELECT
    Marketing_Channel,
    AVG(Acquisition_Cost) AS avg_acquisition_cost,
    AVG(Retention_Rate) AS avg_retention_rate
FROM insurance_data
GROUP BY Marketing_Channel
ORDER BY avg_acquisition_cost;


/* 7. Identify high-cost, low-retention records */
SELECT
    Agent_ID,
    State,
    Marketing_Channel,
    Acquisition_Cost,
    Retention_Rate,
    Premium_Amount
FROM insurance_data
WHERE Acquisition_Cost > (
        SELECT AVG(Acquisition_Cost) FROM insurance_data
      )
  AND Retention_Rate < (
        SELECT AVG(Retention_Rate) FROM insurance_data
      )
ORDER BY Acquisition_Cost DESC;
