# PRD Writer - Output Templates

## Default PRD Structure

```
### Product Requirements Document - [Feature / Initiative Name]
**PM:** [Name if provided]
**Date:** [Current date]
**Status:** Draft / In Review / Approved
**Platform:** [Brands / Retailer]
**JIRA Epic:** [Link if provided]
**Notion Link:** [Link if provided]

---

#### TL;DR
[2-3 sentences. What are we building, for whom, and why now? Write this last.]

---

#### Background and Problem Statement
- What is the current state? What is broken, missing, or inefficient?
- Who is affected, and how severely?
- What data, signals, or customer feedback supports the need?
- What is the cost of inaction?

---

#### Goals and Success Metrics

| Goal | Metric | Target | Measurement Method |
|---|---|---|---|
| [What we want to achieve] | [How we'll measure it] | [Specific target] | [Where the data comes from] |

**Out of Scope:**
- [Explicitly call out what this PRD does NOT cover]

---

#### User Personas

| Persona | Description | Primary Pain Point Addressed |
|---|---|---|
|         |             |                              |

---

#### Requirements

##### Functional Requirements

| ID | Requirement | Priority | Notes |
|---|---|---|---|
| FR-01 | | Must Have | |
| FR-02 | | Should Have | |
| FR-03 | | Could Have | |

##### Non-Functional Requirements
- Performance: [e.g., "API response < 500ms at p95"]
- Security / Compliance: [e.g., "Must comply with SOC 2 data handling requirements"]
- Scalability: [e.g., "Must support N concurrent users"]
- Accessibility: [If applicable]

---

#### User Flows / Key Scenarios

**Scenario 1: [Name]**
1. **Trigger:** [What starts this flow]
2. **Steps:**
   1. [Step 1]
   2. [Step 2]
3. **Expected Outcome:** [What success looks like]
4. **Edge Cases / Error States:** [What happens when something goes wrong]

---

#### Dependencies and Risks

| Item | Type (Dependency / Risk) | Owner | Status / Mitigation |
|---|---|---|---|
|     |                          |       |                     |

---

#### Open Questions

| Question | Owner | Target Resolution Date |
|---|---|---|
|          |       |                        |

---

#### Appendix
[Supporting research, related PRDs, referenced tickets, design links, or data sources]
```

## Notes on Template Use

- TL;DR is always written last - it summarizes what you actually wrote
- Out of Scope section is mandatory - make it explicit, not implied
- Every row in the Goals table must have all four columns filled in
- Non-Functional Requirements: include only those that apply; do not add placeholder rows for sections that aren't relevant
