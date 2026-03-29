# Rithum PM Agent System

Shared Claude Code agent configuration for the Rithum for Brands Product Management team.

## Agents

| Agent | Purpose | Invoke With |
|---|---|---|
| `pm-router` | Routes ambiguous requests to the right specialist | `@agent-pm-router` or just describe your task |
| `priority-analyzer` | Analyzes and ranks priorities from JIRA, Notion, Excel, and context | `@agent-priority-analyzer` |
| `backlog-organizer` | Organizes, ranks, and cleans up a product backlog | `@agent-backlog-organizer` |
| `idea-reviewer` | Evaluates new ideas and feature requests | `@agent-idea-reviewer` |
| `story-writer` | Writes engineering stories for JIRA | `@agent-story-writer` |
| `business-case` | Builds or updates business cases and ROI models | `@agent-business-case` |
| `prd-writer` | Creates or updates PRDs | `@agent-prd-writer` |

## Setup

```bash
# Install Claude Code (requires Node.js)
npm install -g @anthropic-ai/claude-code

# Clone this repo
git clone [your-repo-url]
cd pm-agents

# Start Claude Code - agents load automatically
claude
```

## Usage

Just describe what you need. Claude will route automatically:

```
"Help me prioritize the Catalog backlog for Q3"
→ routes to priority-analyzer

"Write stories for the bulk export feature"
→ routes to story-writer

"I need a business case for the Instacart integration expansion"
→ routes to business-case
```

Or invoke an agent directly:

```
@agent-prd-writer - create a PRD for [feature]
@agent-story-writer - write stories for [epic link]
```

## Updating Agents

Each agent is a single `.md` file in `.claude/agents/`. Edit the file, commit, and push - all team members get the update on `git pull`.

## Self-Improvement and Changelog

Agents improve over time. When Claude or a team member applies an improvement:

1. The change is written to the relevant `.md` file
2. An entry is appended to `AGENT_CHANGELOG.md` with context, author, and date
3. Brent Kepler receives a GitHub Watch email notification on every commit
4. The owner reviews and can request a revert if the change isn't aligned

**To revert a change:** tell the `agent-improver` agent: "Revert the [agent-name] change from [date]"

**For improvement guidance:** ask Claude "How do I improve an agent?" or "Show me AGENT_HELP.md"

## First-Time Use Notes

- The **priority-analyzer** and **backlog-organizer** will ask about your preferred prioritization framework the first time you use them. Answer once per session.
- The **story-writer** will ask about your team's preferred story format the first time. Answer once per session.
- For **ChannelSync (SYNC)** stories, the story-writer will query recent SYNC tickets to identify valid `ChannelSync Team` and `Components` values before writing.
- **No agent will create or modify JIRA tickets or Notion pages without asking you first.**
