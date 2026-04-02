# Rithum PM Agent System - Project Context

## About This Repository

This is the shared agent configuration for the Rithum for Brands Product Management team. All agents in `.claude/agents/` are available to every PM on the team. This file loads automatically when Claude Code starts in this directory.

## Repository Structure

```
pm-agents/
├── .claude/agents/        # Runtime agent files (GENERATED - do not edit directly)
├── agents/                # Modular source for each agent (edit these)
│   └── <agent-name>/
│       ├── metadata.json  # Name, version, tools, dependencies, file list
│       ├── instructions.md
│       ├── templates.md
│       └── <other>.md
├── shared/                # Content shared across multiple agents
│   ├── user-setup.md
│   ├── rithum-context.md
│   ├── jira-integration.md
│   ├── notion-integration.md
│   ├── tone-and-style.md
│   └── platforms.md
├── config/
│   ├── agent-registry.json  # Master agent list with metadata
│   └── mcp-servers.json     # MCP server configuration reference
└── scripts/
    ├── build-agents.sh      # Assembles agents/ + shared/ → .claude/agents/
    └── validate-agents.sh   # Validates metadata and source file consistency
```

**To edit an agent:** modify files in `agents/<name>/` or `shared/`, then run `bash scripts/build-agents.sh <agent-name>` to regenerate the runtime file. Or invoke `@agent-agent-improver` and it will handle the full workflow.

---

## Company and Platform Context

**Company:** Rithum
**Platforms:** Rithum for Brands (formerly ChannelAdvisor) | Rithum for Retailers (formerly CommerceHub)
**Team:** Senior Product Management - serves PMs on both platforms

### User Setup (Ask When Relevant)

Do not ask setup questions upfront. Collect them the first time a request requires that information:

- **Name** - ask on the first request of any session, if not already known from the Claude profile or prior messages. Use naturally throughout.
- **Platform (Brands or Retailer)** - ask the first time a request involves templates, JIRA projects, or platform-specific context. If not yet known, do not assume.
- **Areas of Responsibility** - ask the first time a request involves prioritization, backlog work, or scoping decisions where knowing the PM's product areas would materially change the output. Save the answer for the session.
- **Key Stakeholders** - ask the first time a request involves a business case, executive summary, or any output where audience or approval chain matters. Save the answer for the session.

Never re-ask for information already provided in the current session or known from memory.

### Platform Branching

All agents adapt behavior based on the user's declared platform:

- **Brands Platform** - uses established Brands templates in Notion, Brands JIRA projects, and Brands-specific stakeholder context
- **Retailer Platform** - discovers available Retailer templates, asks which to use, learns the user's preference, and saves it for the session

The `business-case` and `prd-writer` agents use `memory: project` so template preferences persist across Claude Code sessions. In the claude.ai Project, preferences reset each session.

### Key JIRA Projects

- Standard Rithum for Brands projects: each PM owns specific projects
- **ChannelSync (SYNC)** - special project requiring two additional fields:
  - `ChannelSync Team` - determines which team does the work
  - `Components` - determines the component affected
  - Always query recent SYNC tickets to get valid field values before creating stories

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

1. If the user has attached a Word file, Excel file, PDF, or referenced a Notion link or other hosted file as the template, use that.
2. If no file is attached, check the specific agent's instructions for a referenced template.
3. If no agent-level template exists, check Notion for an existing team template.
4. If no template is found in Notion, ask the user if they have a template they would like to use.
5. If no template is provided, use the default structure defined in the agent.
6. Always confirm with the user which template to use before writing.

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

The `agent-improver` agent monitors all sessions and proposes updates when it detects gaps, format mismatches, or user corrections. It operates in three modes:

- **Fast Mode (default):** Output delivered, no improvement notes. Used when sessions run cleanly.
- **Suggest Mode:** Output delivered first, then a brief improvement suggestion appended. Triggered only when a real gap was observed.
- **Improve Mode:** User explicitly requests a change. Agent drafts the edit, shows a preview, confirms with the user, then routes for deployment based on context (see below).

### Two Deployment Paths

**From the Claude.ai hosted Project (most PMs):**

The hosted Project has no filesystem or git access, so changes cannot be applied directly. When a PM requests an improvement:

1. The agent drafts the exact change and shows a preview.
2. The PM confirms ("yes", "apply it", "go ahead").
3. The agent generates a ready-to-paste Claude Code prompt containing the full change request.
4. The PM copies that prompt and sends it to Brent Kepler (via Slack or email).
5. Brent pastes the prompt into Claude Code, where `agent-improver` applies the edit, rebuilds the runtime file, commits, and pushes to GitHub.
6. The Project instructions are updated to reflect the new agent content.

**From a local clone (technical PMs):**

PMs who have cloned the repo locally can apply and push improvements directly:

1. Make the request in Claude Code running from the repo root.
2. `agent-improver` edits the relevant file in `agents/<name>/` or `shared/`.
3. Runs `scripts/build-agents.sh` to regenerate `.claude/agents/<name>.md`.
4. Commits and pushes to GitHub.
5. Appends an entry to `AGENT_CHANGELOG.md`.

### Rules

- No change is ever applied without explicit user confirmation ("yes", "apply it", "go ahead").
- Every applied change is logged to `AGENT_CHANGELOG.md` with full context.
- Brent Kepler reviews all changes and has final say on reversions.
- Any user can request a change. Any user can request a revert.

### Requesting an Improvement

Say anything like:
- "Update the story writer to always include a testing notes section"
- "The idea reviewer should ask about competitive alternatives"
- "Fix how the business case handles missing financial data"

The agent will draft the change, confirm with you, then either apply it directly (local Claude Code) or generate a Claude Code prompt for Brent to deploy (hosted Project).

### Changelog and Reversion

All changes are in `AGENT_CHANGELOG.md`. To revert a change:
> "Revert the change to [agent-name] from [date]"

The agent-improver will show you the before state and confirm before applying.
