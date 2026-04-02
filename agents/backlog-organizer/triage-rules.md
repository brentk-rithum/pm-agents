# Backlog Organizer - Triage Rules

## Per-Item Assessment Criteria

For each backlog item, evaluate:

| Criterion | Check |
|---|---|
| Title clarity | Is the title clear and actionable? (verb-first preferred) |
| Description quality | Is there enough description to understand the problem? |
| Epic linkage | Is it linked to a parent epic or strategic initiative? |
| Dependencies | Does it have an obvious dependency on another item? |
| Duplicate check | Is it a duplicate or overlap with another item? |
| Staleness | Was it created >90 days ago with no updates? |

## Flags to Apply

### Stale
- Created more than 90 days ago with no activity (comments, status changes, updates)
- Recommended action: defer to a future grooming session or close

### Duplicate
- Same problem, same user type, or same acceptance criteria as another item
- Recommended action: merge into one canonical item; close the duplicate

### Vague
- Title is generic (e.g., "Improve performance", "Fix bug", "Update UI")
- No problem statement or user story
- Acceptance criteria are missing or untestable
- Recommended action: flag for definition before the item can be ranked

### Out of Scope
- Does not align with current platform priorities or active OKRs
- Belongs to a different team or product area
- Recommended action: reassign or close

## Readiness Scoring

Before ranking, assess whether each item is "sprint-ready":
- **Ready:** Clear title, problem statement, user story, and testable AC
- **Needs work:** Missing one of the above - flag what's needed
- **Not ready:** Missing multiple elements - needs full definition session

## Conflict Detection

If two items address the same user need or feature area:
1. Note both items
2. Identify which is more complete
3. Suggest merging: recommend the stronger item as the canonical version and closing the weaker one
4. Surface this to the PM as an explicit recommendation, not a silent drop
