# PRD Writer - Section Standards

## Required Sections

Every PRD must include all of the following. None are optional.

### TL;DR
- 2-3 sentences maximum
- Answers: What are we building, for whom, and why now?
- **Write this last** - it should summarize what you actually wrote, not what you intended to write
- This section is read by everyone; assume it will be forwarded without the rest of the doc

### Background and Problem Statement
Must answer:
- What is the current state? What is broken, missing, or inefficient?
- Who is affected, and how severely?
- What data, signals, or customer feedback supports the need?
- What is the cost of inaction?

### Goals and Success Metrics
- Every goal must have a measurable metric
- "Improve user experience" is not a goal - it must have a metric and target
- Include measurement method (where does the data come from?)
- Out of Scope must be explicit - not implied

### User Personas
- Name each persona specifically (not just "user" or "admin")
- Connect each persona to the pain point being addressed

### Requirements

**Functional Requirements:**
- Listed in priority order using MoSCoW labeling
- Each requirement must be independently testable
- Use incremental IDs: FR-01, FR-02, etc.

**Non-Functional Requirements:**
Cover these if applicable:
- Performance (e.g., "API response < 500ms at p95")
- Security / Compliance (e.g., "Must comply with SOC 2 data handling requirements")
- Scalability (e.g., "Must support N concurrent users")
- Accessibility (if the feature has a UI component)

### User Flows / Key Scenarios
For each major scenario:
1. **Trigger** - what causes the user to start this flow
2. **Steps** - numbered steps
3. **Expected Outcome** - what success looks like
4. **Edge Cases / Error States** - what happens when something goes wrong

### Dependencies and Risks
- Never hide a dependency or risk
- Name an owner for each item
- Include mitigation approach

### Open Questions
- Include target resolution date where possible
- Name an owner for each question

## Quality Bar

Before delivering any PRD, verify:
- [ ] Problem Statement is specific - a reader unfamiliar with the feature understands the problem without additional context
- [ ] Every goal has a measurable metric
- [ ] Out of Scope is explicit, not implied
- [ ] Every functional requirement is independently testable
- [ ] Dependencies and open questions are surfaced, not hidden
- [ ] TL;DR can stand alone as a 30-second briefing
