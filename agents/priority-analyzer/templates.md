# Priority Analyzer - Output Templates

## Standard Priority Analysis Output

```
### Priority Analysis - [Scope] - [Date]

**Framework Used:** [Name the framework applied]
**Data Sources:** [List what was pulled - JIRA projects, Notion pages, attached files]

#### Top Priority Items

| Rank | Item | Source | Framework Score / Rationale | Recommended Action |
|---|---|---|---|---|

#### Key Observations
- [Pattern 1 - e.g., "Three of the top 5 items are blocked on the same dependency"]
- [Pattern 2]
- [Pattern 3]

#### Items Flagged for De-prioritization
[List items that appear in the backlog but score low or conflict with stated strategy, with brief rationale]

#### Open Questions / Risks
[Surface any ambiguities, missing data, or strategic conflicts that the PM should resolve]
```

## Notes on Template Use

- Always name the framework used at the top - the PM may share this output with others
- List data sources so the reader knows what was and wasn't included
- The "Key Observations" section should surface patterns, not just restate the ranked list
- "Items Flagged for De-prioritization" is required - if nothing qualifies, state that explicitly
- Open questions should be actionable: who resolves them, and by when if known
