# Swiggy Cuisine Performance Diagnostic — SQL, Spreadsheet & Tableau

This project creates one deterministic Swiggy-style order dataset and carries the **same delivered-order revenue numbers** from SQLite SQL into a spreadsheet cross-check and then into a Tableau Public management dashboard. The fixed source contains 420 orders from January–June 2026; the diagnostic focuses on Delivered orders, producing **34 monthly cuisine rows**, **₹497,106 Delivered revenue**, and **358 Delivered orders**. The repository is designed so the database, SQL, CSV, spreadsheet, story, and AI-assisted work log can all be audited from one place.

## Live Tableau Public dashboard

**Replace this placeholder with your published Tableau Public URL:**  
`https://public.tableau.com/`

## Repository structure

```text
.
├── generate_data.py
├── swiggy_capstone.db
├── verify.sql
├── 01_foundations.sql
├── 02_aggregation_joins.sql
├── 03_reporting.sql
├── monthly_cuisine_revenue.csv
├── swiggy_cuisine_crosscheck.xlsx
├── DATA_STORY.md
├── TABLEAU_BUILD_GUIDE.md
├── ai_log.md
└── README.md
```

## Part A — SQL

- `generate_data.py` recreates the SQLite database with the required `random.seed(42)` deterministic seed.
- `swiggy_capstone.db` is the actual generated database.
- `verify.sql` records the required verification counts.
- `01_foundations.sql` contains WHERE, DISTINCT, ORDER BY + LIMIT, LIKE + %, IN, BETWEEN, NOT BETWEEN, and IS NULL.
- `02_aggregation_joins.sql` contains the required INNER JOIN + HAVING aggregate and LEFT JOIN restaurant count.
- `03_reporting.sql` contains the three-tier CASE query, monthly-by-cuisine report, and cuisine-target variance report.
- `monthly_cuisine_revenue.csv` is the direct 34-row export of the monthly-by-cuisine Delivered report. It is the fixed input for Parts B and C.

### Regenerate

Run:

```bash
python3 generate_data.py
```

Then rerun the SQL in `03_reporting.sql` and export the monthly-by-cuisine result to `monthly_cuisine_revenue.csv`. Do **not** edit the CSV by hand.

## Part B — Spreadsheet

`swiggy_cuisine_crosscheck.xlsx` contains:

- `Monthly Data` — the exact imported 34-row CSV
- `Cuisine Targets` — the six fixed targets
- `Pivot Table` — the cuisine totals reconstructed from the imported CSV with spreadsheet aggregation formulas
- `Cuisine Summary` — pivot-referenced revenue, exact-match VLOOKUP targets, variance, percentage variance, nested IF status, and reconciliation
- `Instructions` — construction notes

The final summary reconciles to the Part A SQL totals to the rupee.

## Part C — Tableau

Follow `TABLEAU_BUILD_GUIDE.md` to build the one-page Tableau Public dashboard from the exact CSV. The guide includes the calculated fields, KPI formulas, chart setup, filter instruction, and publish steps.

Live Tableau Public Dashboard:https://public.tableau.com/app/profile/albert.daniel7148/viz/SwiggyCuisinePerformanceDashboard_17869738675070/SwiggyCuisinePerformanceDashboard

## Data story

See [`DATA_STORY.md`](DATA_STORY.md).

The key result is:
- Above Target: North Indian, South Indian, Italian
- Below Target - Watch: Chinese, Fast Food
- Below Target - Critical: Desserts

## AI-assisted prompting log

See [`ai_log.md`](ai_log.md). It contains two RCTCF prompts, one for SQL and one for Tableau/story design, with a concrete verification step for each.

## Official websites / help

- GitHub: https://github.com/
- Tableau Public: https://public.tableau.com/
- Google Sheets: https://sheets.google.com/

GitHub's official documentation explains creating a public repository and uploading project files. Tableau's documentation confirms CSV upload is supported in Tableau Public. Google Sheets supports importing data and downloading a workbook in Excel format.

## Submission checklist

Before submitting the single GitHub repository URL:

- [ ] Repository is **Public**
- [ ] All required Part A files are present
- [ ] `monthly_cuisine_revenue.csv` has exactly 5 columns and 34 data rows
- [ ] `swiggy_cuisine_crosscheck.xlsx` opens and has the required sheets/formulas
- [ ] Tableau dashboard has all 4 KPI cards, time series, cuisine bar chart, and visible cross-worksheet filter
- [ ] Tableau view is publicly viewable without login
- [ ] Live Tableau Public URL is pasted above
- [ ] `DATA_STORY.md` and `ai_log.md` are committed
- [ ] No screenshots, PDFs, slides, videos, or audio files are included

## Fixed diagnostic totals

| Cuisine | Revenue | Target | Variance (Target - Revenue) | Status |
|---|---:|---:|---:|---|
| North Indian | ₹216,297 | ₹180,000 | ₹-36,297 | Above Target |
| Chinese | ₹127,840 | ₹140,000 | ₹12,160 | Below Target - Watch |
| South Indian | ₹63,417 | ₹50,000 | ₹-13,417 | Above Target |
| Fast Food | ₹55,123 | ₹60,000 | ₹4,877 | Below Target - Watch |
| Desserts | ₹19,694 | ₹25,000 | ₹5,306 | Below Target - Critical |
| Italian | ₹14,735 | ₹10,000 | ₹-4,735 | Above Target |
