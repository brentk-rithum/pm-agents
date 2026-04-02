# Story Writer - Story Templates

## Standard Story Template

```
Summary: [Verb-first, concise title - e.g., "Add bulk export to the Order Report"]

Description:

**Problem**
[1-3 sentences describing the specific problem this story solves. Who is affected? What breaks or is missing today? Why does it matter?]

**User Story**
As a [specific user type],
I want [specific action or capability],
So that [specific value or outcome].

**Acceptance Criteria**
- [ ] [Criterion 1 - testable, specific, binary pass/fail]
- [ ] [Criterion 2]
- [ ] [Criterion 3]
- [ ] [Add more as needed]

**Additional Context**
[Any relevant links, related tickets, design references, or technical notes provided by the PM]
```

## ChannelSync (SYNC) Story Template

Same as Standard, plus these fields set at the JIRA level:

```
ChannelSync Team: [Confirmed team name - see jira-fields.md for valid values]
Components: [Confirmed component(s)]
```

## Multi-Story Proposal Format

When breaking an epic or PRD into multiple stories, present a proposal first:

```
I've identified [N] stories from [source]. Here's the proposed breakdown:

1. [Summary of Story 1] - [one-line rationale]
2. [Summary of Story 2] - [one-line rationale]
3. [Summary of Story 3] - [one-line rationale]

Should I write full stories for all of these, or would you like to adjust the breakdown first?
```

## Notes on Template Use

- Summary must be verb-first and concise - think of it as a task on a sprint board
- Problem section is mandatory - developers need to understand why, not just what
- "Additional Context" is optional but should include any JIRA epic links, design files, or technical notes the PM provides
- Never include story points in the template unless the PM asked for an estimate
