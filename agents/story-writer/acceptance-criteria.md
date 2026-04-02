# Story Writer - Acceptance Criteria Standards

## What Makes a Good Acceptance Criterion

Every acceptance criterion must be:
- **Testable** - a developer or QA engineer can verify it with a binary yes/no
- **Specific** - no vague language like "system should work correctly" or "improve performance"
- **Independently verifiable** - does not require testing another criterion first
- **Scoped** - relates directly to this story, not a future story

## Format

Use checkbox format:
```
- [ ] [Criterion text - start with a verb, describe an observable outcome]
```

**Good examples:**
- `- [ ] User receives an email confirmation within 30 seconds of submitting the order`
- `- [ ] Bulk export button is disabled when no rows are selected`
- `- [ ] API returns a 400 error with message "invalid_sku" when SKU field is empty`
- `- [ ] Report filters persist when the user navigates away and returns to the page`

**Bad examples (do not use):**
- `- [ ] System works as expected` (not testable)
- `- [ ] Performance is improved` (not specific)
- `- [ ] The feature is user-friendly` (subjective, not verifiable)
- `- [ ] All edge cases are handled` (vague)

## Quantity Guidelines

- Most stories need 3-6 acceptance criteria
- Simple stories (copy change, config update) may need only 1-2
- Complex stories should be split rather than having 8+ criteria
- If you find yourself writing more than 7 criteria, flag the story for splitting

## Edge Cases and Error States

Include at least one criterion covering an error or edge case if applicable:
- What happens when the input is invalid?
- What happens when a required dependency is unavailable?
- What does the user see when the operation fails?

## Quality Bar Checklist

Before finalizing any story, verify:
- [ ] The Problem section is specific - not generic filler
- [ ] The user story names a real user type (not just "user" or "admin")
- [ ] Every acceptance criterion is testable with a yes/no
- [ ] No criterion uses vague language
- [ ] The story is scoped to a single deployable unit of work
