# Tableau Public Build Guide

Use **Tableau Public** and the fixed `monthly_cuisine_revenue.csv` in the repo. Tableau Public supports CSV upload directly in the browser. urlTableau Publichttps://public.tableau.com/

## 1. Connect the CSV

1. Open Tableau Public and sign in/create a free Tableau Public account.
2. Choose **Create a Viz** / upload data.
3. Upload `monthly_cuisine_revenue.csv`.
4. Confirm the columns are:
   - cuisine
   - month
   - order_count
   - total_revenue
   - avg_revenue

## 2. Create calculated fields

### Target Revenue
```text
CASE [cuisine]
WHEN "North Indian" THEN 180000
WHEN "Chinese" THEN 140000
WHEN "South Indian" THEN 50000
WHEN "Fast Food" THEN 60000
WHEN "Desserts" THEN 25000
WHEN "Italian" THEN 10000
END
```

### Target Status
```text
IF SUM([total_revenue]) >= [Target Revenue] THEN "Above Target"
ELSEIF ([Target Revenue] - SUM([total_revenue])) <= [Target Revenue] * 0.15
THEN "Below Target - Watch"
ELSE "Below Target - Critical"
END
```

### Meeting Target Flag
```text
IF [Target Status] = "Above Target" THEN [cuisine] END
```

### Total Delivered Orders
For the KPI use:
```text
SUM([order_count])
```

### Average Order Value
```text
SUM([total_revenue]) / SUM([order_count])
```

## 3. Time-series worksheet

1. Create a new worksheet named `Monthly Revenue`.
2. Create a date field:
```text
DATE(DATEPARSE("yyyy-MM", [month]))
```
3. Put the date field on Columns and `SUM(total_revenue)` on Rows.
4. Set the date to Month and use a continuous line.
5. Ensure all six months Jan–Jun 2026 are visible.

## 4. Cuisine revenue bar worksheet

1. Create `Cuisine Revenue`.
2. Put `cuisine` on Rows.
3. Put `SUM(total_revenue)` on Columns.
4. Sort descending by the SUM of revenue.
5. Put `Target Status` on Color.
6. Use one distinct color for `Above Target` and a contrasting treatment for the Below Target statuses.

## 5. KPI worksheets

Create four small worksheets/cards:
- **Total Revenue:** `SUM(total_revenue)`
- **Total Delivered Orders:** `SUM(order_count)`
- **Average Order Value:** `SUM(total_revenue) / SUM(order_count)`
- **Cuisines Meeting Target:** `COUNTD([Meeting Target Flag])`

Format revenue and AOV as INR-style currency.

Expected checkpoint values from this fixed CSV:
- Total Revenue: **₹501,106**
- Total Delivered Orders: **358**
- Average Order Value: **₹1,399.74**
- Cuisines Meeting Target: **3**

## 6. Filter

Use `cuisine` or `month` as a dashboard filter. Put it on one worksheet first, then choose **Apply to Worksheets → All Using This Data Source**. Keep the filter visible on the dashboard.

## 7. Dashboard

Create one dashboard with:
- top-left: the four KPI cards
- middle/bottom: monthly revenue line chart
- right/bottom: descending cuisine revenue bar chart
- visible cuisine/month filter
- consistent font and INR number format

Title suggestion: **Swiggy Cuisine Performance Diagnostic | Jan–Jun 2026**

## 8. Publish

Publish the workbook to Tableau Public, open the published public profile/workbook page, copy the public view URL, and paste that URL into `README.md` replacing the placeholder.

**Do not upload screenshots/PDFs. The required dashboard evidence is the live Tableau Public URL.**
