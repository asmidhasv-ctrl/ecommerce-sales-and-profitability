# E-commerce Sales & Profitability Analytics

An end-to-end analytics project: data cleaning → KPI design → SQL analysis →
interactive Power BI dashboard, built on a Kaggle e-commerce sales dataset
(5,000 orders).

## Dataset

`Dataset/cleaned_ecommerce_sales.csv` — 5,000 orders, columns:
`order_id, order_date, customer_id, product_category, region, quantity,
unit_price, discount, payment_method, delivery_days, customer_rating, revenue`
plus derived columns (see below).

**Note on the data:** this is a synthetically generated Kaggle dataset — order
dates run sequentially from Jan 2022 through 2034 with no real seasonality,
and there were no missing values, duplicates, or currency-formatting issues
in the raw file. Cleaning was still performed as a full pass (checking for
duplicate order IDs, nulls, and type mismatches) to demonstrate proper data
hygiene practice, even though this particular source file needed no
corrections.

**Important — Assumed Cost/Profit Layer:** the raw dataset has no Expense,
Cost, or Budget columns. To demonstrate profitability KPIs (a core skill for
business/finance analytics roles), an assumed gross-margin % was applied per
product category (Electronics 15%, Home 30%, Clothing 45%, Beauty 50% —
typical retail margin bands), from which `unit_cost`, `total_cost`, `profit`,
and `profit_margin_pct` were derived. **This cost data is an illustrative
assumption, not real business data** — disclosed openly, and used to
showcase the KPI/analysis methodology rather than presented as a real P&L.

## Project Structure

```
Financial-Analytics-Project/
├── Dataset/
│   └── cleaned_ecommerce_sales.csv
├── SQL_Queries/
│   ├── finance_analysis_queries.sql
│   └── query_results.txt
├── Power_BI_Dashboard/
│   └── ecommerce_sales_dashboard.pbix
├── Screenshots/
│   ├── dashboard_overview.png
│   └── dashboard_filtered_electronics.png
└── README.md
```

## KPIs

| KPI | Formula | Value |
|---|---|---|
| Total Revenue | SUM(revenue) | ₹51,09,775.74 |
| Total Assumed Cost | SUM(total_cost) | ₹42,31,769.86 |
| Total Profit (assumed) | Revenue − Cost | ₹8,78,005.88 |
| Profit Margin | Profit / Revenue × 100 | 17.18% |
| Total Orders | COUNT(order_id) | 5,000 |
| Average Order Value | AVG(revenue) | ₹1,021.96 |
| Average Customer Rating | AVG(customer_rating) | 2.97 / 5 |

## Key Insights

- **Electronics is actually unprofitable under the assumed margins** —
  ₹18.3L revenue but **−₹59,916 profit (−3.27% margin)**. At a 15% assumed
  cost margin, average discounting (~17–20%) pushes many Electronics orders
  below cost. Clothing (32.25% margin) and Beauty (39.06% margin) stay
  solidly profitable at similar discount levels because they start from a
  much higher margin — a real "discounting is eroding profitability in one
  category" story, verified via SQL query #2.
- **West region leads on profit** (₹2.43L), narrowly ahead of East, North,
  and South — all four regions are fairly close, so no single region is
  carrying the business.
- **Card is the dominant payment method** by both order volume (2,270 orders)
  and average order value (₹1,042), followed by COD then Wallet.
- **Delivery speed showed almost no correlation with customer rating**
  (SQL query #7 shows ratings flat at 2.93–3.07 regardless of delivery_days)
  — ratings look driven by something other than delivery time in this
  dataset.
- Revenue is noisy month-to-month with no clear seasonal pattern — consistent
  with this being a synthetic dataset rather than a real seasonal retail
  business.

All figures above were run and verified via SQL (SQLite against the cleaned
dataset) — see `SQL_Queries/query_results.txt` for full query output.

## Power BI Dashboard

The dashboard (`Power_BI_Dashboard/ecommerce_sales_dashboard.pbix`) includes:

- **KPI cards**: Total Revenue, Total Profit, Profit Margin %, Total Orders
- **Monthly Revenue & Profit trend** (chronological, 2022–2034)
- **Profit by product category** — conditionally formatted so the
  unprofitable Electronics category displays in red
- **Cost share by category** (pie chart)
- **Profit by region** and **order volume by payment method** (bar charts)
- **Interactive slicers**: Region, Product Category, Payment Method, Year

**Full dashboard (unfiltered):**

![Dashboard Overview](Screenshots/dashboard_overview.png)

**Filtered to Electronics** — notably, every region shows a loss on
Electronics specifically, confirming the unprofitability is a category-wide
issue rather than concentrated in one region:

![Dashboard Filtered to Electronics](Screenshots/dashboard_filtered_electronics.png)

Open the `.pbix` file directly in Power BI Desktop (free) to interact with
it yourself.

## How I Built This

1. Sourced a 5,000-row e-commerce sales dataset from Kaggle
2. Audited and cleaned the data (duplicate checks, null handling, type
   correction) and layered in an assumed cost/margin model to enable
   profitability analysis
3. Wrote and ran SQL queries against the cleaned data to compute KPIs and
   surface the Electronics-profitability finding
4. Built an interactive Power BI dashboard with KPI cards, trend analysis,
   conditional formatting, and slicers for exploration
