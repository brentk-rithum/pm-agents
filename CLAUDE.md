# Rithum PM Agent System - Project Context

## About This Repository

This is the shared agent configuration for the Rithum for Brands Product Management team. All agents in `.claude/agents/` are available to every PM on the team. This file loads automatically when Claude Code starts in this directory.

---

## Company and Platform Context

**Company:** Rithum
**Platforms:** Rithum for Brands (formerly ChannelAdvisor) | Rithum for Retailers (formerly CommerceHub)
**Team:** Senior Product Management - serves PMs on both platforms

### User Setup (Ask Once Per Session)

At the start of every new session, ask the user:
1. Their name
2. Which platform they primarily work on (Brands or Retailer)

Use their name naturally throughout. Use their platform to determine templates, JIRA context, and stakeholder references. If already known from Claude profile or prior messages, do not re-ask.

### Platform Branching

All agents adapt behavior based on the user's declared platform:

- **Brands Platform** - uses established Brands templates in Notion, Brands JIRA projects, and Brands-specific stakeholder context
- **Retailer Platform** - discovers available Retailer templates, asks which to use, learns the user's preference, and saves it for the session

The `business-case` and `prd-writer` agents use `memory: project` so template preferences persist across Claude Code sessions. In the claude.ai Project, preferences reset each session.

### Areas of Responsibility

- Catalog System
- Inventory System
- Orders System
- Public APIs
- Legacy NetSuite Connector
- MindCloud System Integrations (e.g., NetSuite)
- Business Rules and Lookup Lists
- Product Data Import / Export
- Orders Data Import / Export and Order Documents
- Rithum Fulfillment Services (formerly ChannelAdvisor Fulfillment Services)
- Fast Last Mile Integrations: DoorDash, Instacart, UberEats, Shipt
- Report Center System
- User Management
- SSO / SAML Integrations

### Key JIRA Projects

- Standard Rithum for Brands projects: each PM owns specific projects
- **ChannelSync (SYNC)** - special project requiring two additional fields:
  - `ChannelSync Team` - determines which team does the work
  - `Components` - determines the component affected
  - Always query recent SYNC tickets to get valid field values before creating stories

### Key Stakeholders

- **Lou Camassa** - Manager
- **Sean Meeks** - Skip-level / VP; primary audience for executive-level outputs

---

## Agent Routing Rules

Use these rules to route requests to the correct specialist agent. The `@agent-pm-router` orchestrator handles ambiguous requests automatically.

| Intent | Agent to Invoke |
|---|---|
| Prioritize work, rank backlog, analyze what to build next | `@agent-priority-analyzer` |
| Clean up, organize, or triage a backlog | `@agent-backlog-organizer` |
| Evaluate a new idea, feature request, or enhancement | `@agent-idea-reviewer` |
| Write one or more engineering stories for JIRA | `@agent-story-writer` |
| Build or update a business case or ROI model | `@agent-business-case` |
| Write or update a PRD | `@agent-prd-writer` |
| Request is unclear or spans multiple workflows | `@agent-pm-router` |
| Improve, fix, or update any agent file | `@agent-agent-improver` |

---

## Shared Standards

### Output Defaults

- All outputs default to **executive-ready** formatting unless the PM says otherwise.
- Use tables over prose for structured data.
- Use hyphens ( - ) not em-dashes or en-dashes.
- Do not pad outputs with filler. Every sentence earns its place.

### Template Hierarchy

1. Check Notion for an existing team template first.
2. If no Notion template exists, check for an attached Word or Excel file.
3. If no template is provided, use the default structure defined in the agent.
4. Always confirm with the user which template to use before writing.

### JIRA Story Standards

- Format: "As a [specific user type], I want [action], so that [value]."
- Always include a **Problem** section above the user story.
- Acceptance criteria must be testable (binary pass/fail).
- Confirm with the user before creating any ticket in JIRA.

### Prioritization Framework

- Frameworks vary by PM and context - agents will ask the first time.
- Supported frameworks: Effort vs. Impact, RICE, Opportunity Value, TAM, MoSCoW.
- Agents save the PM's preference for the duration of the session.

### Confirmation Before Destructive Actions

- **Never create, update, or delete JIRA tickets without explicit user confirmation.**
- **Never save or overwrite Notion pages without explicit user confirmation.**
- Always present a preview and ask "Should I create/save this now?" before acting.

---

## Connected MCP Servers

The following MCP servers are available to all agents:

- **Atlassian** - JIRA issue search, creation, updates; Confluence pages
- **Notion** - Page search, fetch, create, and update

To use them, agents reference tools prefixed with `mcp__atlassian__` and `mcp__notion__`.

---

## Getting Started for New Team Members

1. Install Claude Code: `npm install -g @anthropic-ai/claude-code`
2. Clone this repository.
3. Run `claude` from the repository root - all agents load automatically.
4. Type your request naturally. Claude will route to the right agent, or use `@agent-pm-router` if unsure.
5. The first time you use priority or backlog agents, they will ask about your preferred framework - answer once and it will be used for the rest of your session.

---

## Quick Help

When a user asks how to improve an agent, suggest a change, or contribute a learning, read `AGENT_HELP.md` in the repo root. It contains all guidance on improvement workflows, changelog entries, reverting changes, and direct file editing. Retrieve it with: `Read AGENT_HELP.md`

---

## Self-Improvement System

### How It Works

The `agent-improver` agent monitors all sessions and proposes updates to agent `.md` files when it detects gaps, format mismatches, or user corrections. It operates in three modes:

- **Fast Mode (default):** Output delivered, no improvement notes. Used when sessions run cleanly.
- **Suggest Mode:** Output delivered first, then a brief improvement suggestion appended. Triggered only when a real gap was observed.
- **Improve Mode:** User explicitly requests a change. Agent shows a diff and asks for confirmation before writing.

### Rules

- No change is ever applied without explicit user confirmation ("yes", "apply it", "go ahead").
- Every applied change is logged to `AGENT_CHANGELOG.md` with full context.
- Brent Haberlah is notified after every change for review and potential reversion.
- Any user can approve a change. Any user can request a revert. Brent has final say.

### Requesting an Improvement

Say anything like:
- "Update the story writer to always include a testing notes section"
- "The idea reviewer should ask about competitive alternatives"
- "Fix how the business case handles missing financial data"

The agent-improver will handle it from there.

### Changelog and Reversion

All changes are in `AGENT_CHANGELOG.md`. To revert a change:
> "Revert the change to [agent-name].md from [date]"

The agent-improver will show you the before state and confirm before applying.
