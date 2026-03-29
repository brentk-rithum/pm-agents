# PM Agent System - Complete Deployment Guide

This guide walks you through every step to get the full PM agent system running.
Estimated time: 30-45 minutes, done once.

---

## Part 1 - Create the GitHub Repository

1. Go to [github.com](https://github.com) and sign in
2. Click **+** (top right) - **New repository**
3. Fill in:
   - Repository name: `pm-agents`
   - Description: `Rithum PM Agent System - shared agent configurations`
   - Visibility: **Private**
   - Do NOT initialize with a README
4. Click **Create repository**

---

## Part 2 - Upload the Files

### Folder Structure

```
pm-agents/                              <- repo root
├── .claude/
│   └── agents/
│       ├── agent-improver.md
│       ├── backlog-organizer.md
│       ├── business-case.md
│       ├── idea-reviewer.md
│       ├── pm-router.md
│       ├── prd-writer.md
│       ├── priority-analyzer.md
│       └── story-writer.md
├── .github/
│   ├── workflows/
│   │   └── agent-changelog-notify.yml
│   └── SETUP_GUIDE.md
├── AGENT_CHANGELOG.md
├── CLAUDE.md
├── CLAUDE_AI_PROJECT_INSTRUCTIONS.md
└── README.md
```

### File Location Reference

| File | Path to type in GitHub filename box | Purpose |
|---|---|---|
| `agent-improver.md` | `.claude/agents/agent-improver.md` | Self-improvement agent |
| `backlog-organizer.md` | `.claude/agents/backlog-organizer.md` | Backlog triage |
| `business-case.md` | `.claude/agents/business-case.md` | Business cases |
| `idea-reviewer.md` | `.claude/agents/idea-reviewer.md` | Idea evaluation |
| `pm-router.md` | `.claude/agents/pm-router.md` | Request routing |
| `prd-writer.md` | `.claude/agents/prd-writer.md` | PRD authoring |
| `priority-analyzer.md` | `.claude/agents/priority-analyzer.md` | Priority analysis |
| `story-writer.md` | `.claude/agents/story-writer.md` | JIRA story writing |
| `agent-changelog-notify.yml` | `.github/workflows/agent-changelog-notify.yml` | Placeholder workflow |
| `SETUP_GUIDE.md` | `.github/SETUP_GUIDE.md` | This file |
| `AGENT_CHANGELOG.md` | `AGENT_CHANGELOG.md` | Audit log |
| `CLAUDE.md` | `CLAUDE.md` | Auto-loaded by Claude Code on startup |
| `CLAUDE_AI_PROJECT_INSTRUCTIONS.md` | `CLAUDE_AI_PROJECT_INSTRUCTIONS.md` | claude.ai Project source |
| `README.md` | `README.md` | Team onboarding reference |

### How to Upload via GitHub Web Interface

For each file in the table above:

1. In your repo, click **Add file** - **Create new file**
2. Type the full path from the table into the filename box
   - Typing `/` automatically creates folders - no separate folder creation needed
   - Example: typing `.claude/agents/agent-improver.md` creates both folders and the file
3. Paste the file contents into the editor
4. Click **Commit new file**

> The `.claude/agents/` path must be exact. Claude Code loads agents specifically from this location.

### Alternative: Git Command Line

```bash
git clone https://github.com/YOUR-USERNAME/pm-agents.git
cd pm-agents
mkdir -p .claude/agents .github/workflows
# copy all files into correct locations, then:
git add .
git commit -m "Initial PM agent system setup"
git push origin main
```

---

## Part 3 - Set Up Changelog Notifications (GitHub Watch)

No third-party services, no API keys, no admin approval required.
GitHub natively emails you whenever a file in your repo is committed.

### Step 3.1 - Enable Watch notifications on the repo

1. Go to your `pm-agents` repo on GitHub
2. Click **Watch** (top right, next to Star and Fork)
3. Select **All Activity**

### Step 3.2 - Confirm your notification email

1. Click your profile photo (top right) - **Settings**
2. Click **Notifications** in the left sidebar
3. Under **Default notifications email**, confirm it shows `brent.kepler@rithum.com`
4. Ensure **Email** is checked under the **Watching** section

### What you'll receive

Every time a team member commits a change to any file - including
`AGENT_CHANGELOG.md` - GitHub sends an email to `brent.kepler@rithum.com`
showing the commit message, the author, and a link to the diff.

To review what changed in `AGENT_CHANGELOG.md` specifically, click the
commit link in the email and GitHub shows the full diff.

### Filtering the emails (optional)

If you want a dedicated folder for these in Outlook:
1. In Outlook, go to **Settings** - **Rules**
2. Create a rule: sender contains `notifications@github.com`
   AND subject contains `pm-agents`
3. Move to a folder: `PM Agent Updates`

This keeps the notifications organized without losing any.

### Future upgrade path

When Slack admin permissions become available, you can replace this with a
Slack notification using an Incoming Webhook - the `.github/workflows/`
folder is already in place and the placeholder workflow file can be extended
without restructuring the repo.

---

## Part 4 - Set Up the claude.ai Project (Zero-Install Path)

### Step 4.1 - Create the Project

1. Go to [claude.ai](https://claude.ai) - click **Projects** - **New Project**
2. Name it: `Rithum PM Assistant`

### Step 4.2 - Add instructions

1. Open `CLAUDE_AI_PROJECT_INSTRUCTIONS.md` from your repo
2. Copy the entire contents
3. Paste into the **Project Instructions** field - save

### Step 4.3 - Share with the team

1. Set visibility to **Everyone at Rithum** (requires Claude Team plan)
2. Share the project URL with your PM team

### Step 4.4 - Keeping instructions current

When agents improve and `AGENT_CHANGELOG.md` is updated, periodically
re-copy `CLAUDE_AI_PROJECT_INSTRUCTIONS.md` from GitHub and paste it back
into Project Instructions. Do this monthly or after significant improvements.

---

## Part 5 - Set Up Claude Code (Power User Path)

### Install and start

```bash
# Requires Node.js 18+. Check with: node --version
npm install -g @anthropic-ai/claude-code

git clone https://github.com/YOUR-USERNAME/pm-agents.git
cd pm-agents
claude
```

`CLAUDE.md` loads automatically on startup. All agents in `.claude/agents/`
are available immediately.

### Getting updates

```bash
git pull
```

That is all. Updated agent behavior is live in the next Claude Code session.

### Using agents

Type naturally - Claude routes automatically. Or invoke directly:

```
@agent-story-writer write stories for the Instacart epic
@agent-priority-analyzer prioritize the Catalog backlog for Q3
@agent-prd-writer create a PRD for bulk order export
@agent-agent-improver update the story writer to always include testing notes
```

---

## Part 6 - Invite the Team

**Non-technical team members:** Share the claude.ai Project URL (Part 4).
Requires a claude.ai account on the Rithum Team plan.

**Power users:** Share the GitHub repo URL. They follow Part 5.

**Editing agents:** Anyone with repo access can edit `.md` files directly
in the GitHub browser interface (click file, click pencil, edit, commit).
Claude Code users get the update on `git pull`.

---

## Troubleshooting

**Claude Code does not see my agents**
- Confirm you ran `claude` from the `pm-agents` repo root folder
- Confirm files are in `.claude/agents/` - not `.claude/` or `agents/`
- Check for typos in the `name:` field at the top of each agent file

**Not receiving GitHub Watch emails**
- Re-check Settings - Notifications - confirm email and Watching checkboxes
- Check your spam folder for emails from `notifications@github.com`
- Confirm the Watch setting on the repo is set to All Activity, not just
  Participating or Releases

**claude.ai Project sharing not available**
- Requires Claude Team or Enterprise plan
- Contact your Claude workspace admin to confirm plan and enable sharing
