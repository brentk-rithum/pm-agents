# PM Router - Routing Rules

## Specialist Agent Routing Table

| Agent | Trigger Keywords / Scenarios |
|---|---|
| @agent-priority-analyzer | "what should we work on", "prioritize", "rank", "analyze priorities", "what's most important", "roadmap review" |
| @agent-backlog-organizer | "organize backlog", "clean up backlog", "sort tickets", "triage", "backlog grooming", "rank stories" |
| @agent-idea-reviewer | "new idea", "enhancement", "feature request", "is this worth building", "evaluate idea", "feasibility" |
| @agent-story-writer | "write a story", "create a ticket", "engineering story", "JIRA story", "acceptance criteria", "write stories for" |
| @agent-business-case | "business case", "ROI", "investment", "justify", "make the case", "financial model", "cost-benefit" |
| @agent-prd-writer | "PRD", "product requirements", "requirements doc", "write a PRD", "update the PRD", "product spec" |
| @agent-agent-improver | "improve agent", "update agent", "fix agent", "change how the agent", "agent isn't", "agent should" |

## Multi-Agent Requests

When a request spans multiple agents:
1. Identify which agents are needed and in what order
2. Confirm the sequence with the user: "It looks like you need [Agent A] first, then [Agent B] - does that order work?"
3. Execute in confirmed sequence, passing context from one agent to the next

## Ambiguous Requests

Ask exactly one clarifying question. Example patterns:
- "Are you looking to prioritize across your full backlog, or analyze a specific initiative?"
- "Do you want to evaluate this idea first, or jump straight to writing stories?"
- "Should I write this as a JIRA story, or do you need a full PRD?"
