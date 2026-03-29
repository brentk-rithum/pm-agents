---
name: agent-help
description: Quick reference for improving agents, updating metadata, and suggesting changes to the PM Agent system. Read this file when a user asks how to improve an agent, how to contribute a learning, how to update agent instructions, or how to suggest a change to how the system works.
---

# How to Improve the PM Agent System

## Improving an Agent During a Session

If something is wrong with an output - format, missing section, wrong assumption - correct it naturally:

> "Our PRDs always include a Testing Strategy section"
> "Acceptance criteria should use Given/When/Then format for our team"
> "The business case should lead with revenue impact, not the problem statement"

After correcting the output, Claude will ask: **"Should I update the agent instructions so this applies in future sessions?"**

- Say **yes** - Claude shows you a before/after diff and asks for confirmation before writing
- Say **no** - the correction applies this session only
- Say **show me the diff first** - review the change before deciding

## Requesting a Direct Improvement

You can ask for an improvement without waiting for an error:

```
Update the story writer to always include a "Testing Notes" section
The idea reviewer should ask about competitive alternatives before scoring
Add context about our Fast Last Mile integrations to the priority analyzer
```

Claude will show a diff and ask for confirmation before applying.

## Suggesting a Change Without Applying It

If you want to flag something for Brent to review without applying it yourself:

```
I have a suggestion for the PRD writer - can you log it to the changelog as a suggestion without applying it?
```

Claude will add a SUGGESTION entry to AGENT_CHANGELOG.md for Brent to review and action.

## What Gets Updated

| What you want to change | Where it lives | How to change it |
|---|---|---|
| Agent behavior or output format | `.claude/agents/[agent-name].md` | Ask Claude during a session, or edit directly in GitHub |
| Routing rules (which agent handles what) | `CLAUDE.md` | Ask Claude: "Update routing so X goes to Y" |
| Platform context (new integrations, team changes) | `CLAUDE.md` | Ask Claude: "Add [context] to the shared platform knowledge" |
| Shared output standards | `CLAUDE.md` | Ask Claude: "All outputs should now include [X]" |
| This help file | `AGENT_HELP.md` | Ask Claude: "Update the help file to include [guidance]" |

## Reverting a Change

```
Revert the [agent-name] change from [date]
```

Claude will show the before state, confirm, apply the revert, and log it.

## Changelog and Notifications

Every applied change is logged to `AGENT_CHANGELOG.md` with:
- Date and file changed
- What changed and why
- Who requested it
- Status: Pending review by Brent Kepler

Brent receives a GitHub notification email and reviews changes periodically. If a change is not aligned with the team's goals, he will revert it or ask for a correction.

## Claude Code Users Only - Direct File Edits

Edit `.claude/agents/[agent-name].md` directly in GitHub or locally:
1. Make your change
2. Add a commit message: `[agent-name]: [what changed and why]`
3. Update `AGENT_CHANGELOG.md` manually with an entry
4. Push - team members get the update on `git pull`

## Improvement Quality Bar

A good improvement is:
- **Specific** - names the exact section or behavior that should change
- **Reproducible** - the same issue would happen again without the fix
- **Low-risk** - improves clarity or accuracy without changing the agent's fundamental purpose
