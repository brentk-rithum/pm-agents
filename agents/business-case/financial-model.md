# Business Case - Financial Modeling Guidance

## Default: Scenario-Based Analysis

Always use three-scenario analysis for revenue projections unless the user provides a specific model.

| Scenario | Description |
|---|---|
| **Conservative** | Lower-bound assumptions; likely if adoption is slow or execution has delays |
| **Base Case** | Most likely outcome based on current data and reasonable assumptions |
| **Upside** | Upper-bound if adoption exceeds expectations or market conditions are favorable |

## Modeling Rules

1. **State all assumptions explicitly** - never embed assumptions silently in numbers
2. **Use ranges over point estimates** when confidence is low
3. **Flag uncertain figures** - label any estimate that lacks supporting data
4. **Reference existing models** - if the user provides an Excel model, read it and reference the figures; do not re-derive numbers that already exist
5. **Provide a framework with placeholders** if financial data is unavailable - tell the user exactly what inputs are needed

## Key Metrics to Include

| Metric | Definition |
|---|---|
| Estimated Revenue Impact | Range across scenarios (Year 1, Year 2, Year 3) |
| Estimated Cost / Investment | FTE estimate or dollar range |
| Payback Period | Months until cumulative return exceeds investment |
| Break-even Point | When does the initiative become cash-flow positive? |

## Financial Table Format

```
| Scenario    | Assumption              | Year 1 | Year 2 | Year 3 |
|---|---|---|---|---|
| Conservative | [State key assumption] |        |        |        |
| Base Case    | [State key assumption] |        |        |        |
| Upside       | [State key assumption] |        |        |        |
```

## Common Assumption Categories

- **Adoption rate** - what % of target users adopt the feature in Year 1?
- **Revenue per user** - what is the incremental revenue per adopting user?
- **Churn reduction** - what % improvement in retention is expected?
- **Cost savings** - what operational or support costs are reduced?
- **Engineering cost** - FTE months at average fully-loaded cost

## When Data Is Missing

If key financial inputs are unavailable:
1. Complete the framework with labeled placeholders (e.g., `[INSERT: avg ARR per customer]`)
2. List the specific inputs needed at the end of the financial section
3. Do not present uncertain numbers as precise - use ranges or "TBD pending [data source]"
