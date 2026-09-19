SELECT
    Date,
    Item_ID,
    Item_Type,
    Item_Name,
    Current_Stock,
    Min_Required,
    Max_Capacity,
    Unit_Cost,
    Avg_Usage_Per_Day,
    Restock_Lead_Time,
    Vendor_ID,

    Current_Stock * Unit_Cost AS inventory_value,

    Current_Stock / NULLIF(Avg_Usage_Per_Day, 0) AS days_on_hand,

    Avg_Usage_Per_Day * Restock_Lead_Time AS lead_time_demand,

    Avg_Usage_Per_Day * Restock_Lead_Time * 1.20 AS adjusted_reorder_point,

    CASE
        WHEN Current_Stock < Avg_Usage_Per_Day * Restock_Lead_Time
            THEN 'Stockout Risk'
        WHEN Current_Stock > Max_Capacity * 0.80
            THEN 'Potential Overstock'
        ELSE 'Healthy'
    END AS inventory_status

FROM inventory_data
ORDER BY Date, Item_ID;
