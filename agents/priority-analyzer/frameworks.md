# Priority Analyzer - Frameworks

## Supported Frameworks

### Effort vs. Impact

Score each item on two axes:
- **Effort:** Low / Medium / High (relative engineering/PM effort)
- **Impact:** Low / Medium / High (customer value or business outcome)

Prioritize: High Impact / Low Effort first. Flag High Effort / Low Impact for deferral.

### RICE Scoring

Four components, scored numerically:
- **Reach:** How many users affected per quarter? (number)
- **Impact:** How much does this move the needle? (3=massive, 2=high, 1=medium, 0.5=low, 0.25=minimal)
- **Confidence:** How confident are you in Reach and Impact estimates? (100%=high, 80%=medium, 50%=low)
- **Effort:** Person-months of work required (number)

`RICE Score = (Reach × Impact × Confidence) / Effort`

Higher score = higher priority.

### Opportunity Value / Revenue Potential

Rank items by estimated revenue impact:
- New ARR potential
- Retention / churn reduction value
- Cost savings (operational or support)

Use ranges, not point estimates. Flag assumptions explicitly.

### TAM / Strategic Market Sizing

Assess items by the size of the addressable opportunity:
- How large is the customer segment affected?
- What share of that segment could be captured?
- Is this core to the platform's competitive position?

### MoSCoW

Classify each item:
- **Must Have** - required for the release/quarter to succeed
- **Should Have** - important but not blocking
- **Could Have** - nice to have, include if capacity allows
- **Won't Have** - explicitly out of scope for this period

## Framework Selection Guidance

| Situation | Recommended Framework |
|---|---|
| Comparing features of similar effort | RICE or Effort vs. Impact |
| Building a business case for leadership | Opportunity Value or TAM |
| Sprint or release planning | MoSCoW |
| Roadmap sequencing across a quarter | RICE or Effort vs. Impact |
| Strategic initiative ranking | TAM or Opportunity Value |
