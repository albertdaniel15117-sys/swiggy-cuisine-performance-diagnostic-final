# AI-Assisted Prompting Log

## Prompt 1 — SQL debugging (RCTCF)

**Role:** Act as a SQL analyst experienced with SQLite and retail/order analytics.

**Context:** I have a deterministic SQLite database named `swiggy_capstone.db` containing `orders`, `restaurants`, `customers`, and `cuisine_targets`. The `orders` table has `order_date`, `amount_inr`, `rating`, and `status`, and the business report must use `Delivered` orders only.

**Task:** Draft or debug the SQLite query that produces a monthly-by-cuisine report with the columns `cuisine, month, order_count, total_revenue, avg_revenue`, where month is `strftime('%Y-%m', order_date)`, rows are grouped by cuisine and month, and results are ordered by cuisine then month.

**Constraints:** Use SQLite syntax; join `orders` to `restaurants`; filter to `status = 'Delivered'`; do not change the database, the deterministic seed, or the required output column names; the result must be directly exportable as the fixed `monthly_cuisine_revenue.csv`.

**Format:** Return one runnable SQL query followed by a one-sentence explanation of the grouping and filter logic.

**Verification actually performed:** I ran the suggested query against `swiggy_capstone.db`, confirmed it returned 34 rows with the required five columns, and independently checked the resulting cuisine totals against the Delivered-order aggregation before exporting `monthly_cuisine_revenue.csv`.

## Prompt 2 — Tableau story/design (RCTCF)

**Role:** Act as a Tableau Public dashboard designer helping a student turn a fixed revenue dataset into a clean management diagnostic.

**Context:** The only data source is `monthly_cuisine_revenue.csv`, containing 34 monthly cuisine rows for Jan–Jun 2026 with `cuisine`, `month`, `order_count`, `total_revenue`, and `avg_revenue`. The fixed cuisine targets are North Indian ₹180,000, Chinese ₹140,000, South Indian ₹50,000, Fast Food ₹60,000, Desserts ₹25,000, and Italian ₹10,000.

**Task:** Propose a compact Tableau dashboard layout with four KPI cards, one monthly total-revenue time series, and one descending cuisine revenue bar chart. Provide calculated-field logic for target, target status, and cuisines meeting target.

**Constraints:** Use only the supplied CSV and the fixed targets above; do not invent new business metrics; classify cuisines as Above Target when revenue is at least target, Below Target - Watch when the shortfall is at most 15%, otherwise Below Target - Critical; keep the dashboard to one view and include a visible cross-worksheet filter.

**Format:** Give the calculated fields first, then a concise dashboard layout, then a short checklist for applying the filter across worksheets.

**Verification actually performed:** I cross-checked the revenue and target figures used in the proposed story against the spreadsheet summary and independently computed SQL totals for North Indian and Desserts before writing `DATA_STORY.md`.
