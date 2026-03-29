# PM Agent System - Complete Deployment Guide

This guide walks you through every step to get the full PM agent system running:
from creating the GitHub repo to using agents in claude.ai and Claude Code.

Estimated time: 30-45 minutes, done once.

---

## Part 1 - Create the GitHub Repository

### Step 1.1 - Create a new repo on GitHub

1. Go to [github.com](https://github.com) and sign in
2. Click the **+** icon in the top right - select **New repository**
3. Fill in:
   - Repository name: `pm-agents`
   - Description: `Rithum PM Agent System - shared agent configurations`
   - Visibility: **Private**
   - Do NOT initialize with a README
4. Click **Create repository**

---

## Part 2 - Upload the Files

### Required Folder Structure

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

| File | Path to type in GitHub | Purpose |
|---|---|---|
| `agent-improver.md` | `.claude/agents/agent-improver.md` | Self-improvement agent |
| `backlog-organizer.md` | `.claude/agents/backlog-organizer.md` | Backlog triage |
| `business-case.md` | `.claude/agents/business-case.md` | Business cases |
| `idea-reviewer.md` | `.claude/agents/idea-reviewer.md` | Idea evaluation |
| `pm-router.md` | `.claude/agents/pm-router.md` | Request routing |
| `prd-writer.md` | `.claude/agents/prd-writer.md` | PRD authoring |
| `priority-analyzer.md` | `.claude/agents/priority-analyzer.md` | Priority analysis |
| `story-writer.md` | `.claude/agents/story-writer.md` | JIRA story writing |
| `agent-changelog-notify.yml` | `.github/workflows/agent-changelog-notify.yml` | GitHub Actions trigger |
| `SETUP_GUIDE.md` | `.github/SETUP_GUIDE.md` | This file |
| `AGENT_CHANGELOG.md` | `AGENT_CHANGELOG.md` | Audit log |
| `CLAUDE.md` | `CLAUDE.md` | Auto-loaded by Claude Code |
| `CLAUDE_AI_PROJECT_INSTRUCTIONS.md` | `CLAUDE_AI_PROJECT_INSTRUCTIONS.md` | claude.ai Project source |
| `README.md` | `README.md` | Team onboarding reference |

### Step 2.1 - Upload via GitHub web interface

For each file:
1. In your repo, click **Add file** - **Create new file**
2. Type the full path from the table above into the filename box
   - Typing `/` automatically creates folders
3. Paste the file contents into the editor
4. Click **Commit new file**

> The `.claude/agents/` path must be exact - Claude Code looks specifically here.

### Step 2.2 - Alternative: Git command line

```bash
git clone https://github.com/YOUR-USERNAME/pm-agents.git
cd pm-agents
mkdir -p .claude/agents .github/workflows
# copy files into correct locations, then:
git add .
git commit -m "Initial PM agent system setup"
git push origin main
```

---

## Part 3 - Set Up the claude.ai Project

### Step 3.1 - Create the Project

1. Go to [claude.ai](https://claude.ai) - click **Projects** - **New Project**
2. Name it: `Rithum PM Assistant`

### Step 3.2 - Add instructions

1. Open `CLAUDE_AI_PROJECT_INSTRUCTIONS.md` from your repo
2. Copy the entire contents
3. Paste into the Project Instructions field - save

### Step 3.3 - Share with the team

1. Set visibility to **Everyone at Rithum** (requires Claude Team plan)
2. Share the project URL with your PM team

### Step 3.4 - Keeping instructions current

When agent files improve over time, re-copy `CLAUDE_AI_PROJECT_INSTRUCTIONS.md`
from the repo and paste it back into Project Instructions. Do this monthly or
after significant changes are logged in `AGENT_CHANGELOG.md`.

---

## Part 4 - Set Up Claude Code (Power User Path)

```bash
# Install (requires Node.js 18+)
npm install -g @anthropic-ai/claude-code

# Clone and start
git clone https://github.com/YOUR-USERNAME/pm-agents.git
cd pm-agents
claude
```

All agents load automatically from `.claude/agents/` on startup.

To get updates from teammates: `git pull`

---

## Part 5 - Set Up Email Notifications via Power Automate

This replaces any third-party email service. Everything runs inside your
Microsoft 365 environment using Outlook and Power Automate.

### How it works

The GitHub Actions workflow (`agent-changelog-notify.yml`) fires automatically
every time someone commits a change to `AGENT_CHANGELOG.md`. It writes a
plain-text summary of the new entries and saves it as a workflow artifact.

Power Automate watches for new GitHub Actions workflow runs in your repo,
reads the summary, and sends you an Outlook email with the details.

### Step 5.1 - Generate a GitHub Personal Access Token

Power Automate needs read access to your GitHub repo to detect workflow runs.

1. Go to GitHub - click your profile photo - **Settings**
2. Scroll to the bottom of the left sidebar - click **Developer settings**
3. Click **Personal access tokens** - **Tokens (classic)**
4. Click **Generate new token (classic)**
5. Fill in:
   - Note: `Power Automate - pm-agents`
   - Expiration: **No expiration** (or 1 year - your preference)
   - Scopes: check **repo** (this covers read access to private repos)
6. Click **Generate token** - copy the token immediately
   - You will only see it once. Store it somewhere safe (e.g. a password manager).

### Step 5.2 - Create the Power Automate flow

1. Go to [make.powerautomate.com](https://make.powerautomate.com) and sign in
   with your Rithum Microsoft 365 account
2. Click **+ Create** - **Automated cloud flow**
3. Name the flow: `PM Agent Changelog Digest`
4. Search for trigger: type `GitHub` - select **GitHub - When a workflow run is completed**
   - If prompted to connect GitHub, click **Sign in** and authorize with your GitHub account
5. Configure the trigger:
   - Repository Owner: your GitHub username
   - Repository: `pm-agents`
   - Status: `completed`
6. Click **+ New step**

### Step 5.3 - Add a condition to filter by workflow name

You only want emails when the changelog workflow runs - not every workflow.

1. Add action: search **Condition**
2. Left side: click **Add dynamic content** - select **name** (the workflow name)
3. Condition: **is equal to**
4. Right side: type `Agent Changelog - Flag for Power Automate`

All following steps go inside the **If yes** branch.

### Step 5.4 - Get the workflow run details

Inside the **If yes** branch:

1. Add action: **GitHub - Get a workflow run**
2. Repository Owner: your GitHub username
3. Repository: `pm-agents`
4. Run ID: click **Add dynamic content** - select **id** (the run ID from the trigger)

### Step 5.5 - Add a delay to allow artifact upload to complete

GitHub takes a few seconds to finalize artifacts after a run completes.

1. Add action: search **Delay**
2. Count: `30`
3. Unit: `Second`

### Step 5.6 - List the workflow artifacts

1. Add action: **HTTP** (search for HTTP - it is a built-in connector)
2. Method: `GET`
3. URI:
   ```
   https://api.github.com/repos/YOUR-USERNAME/pm-agents/actions/runs/@{triggerBody()?['id']}/artifacts
   ```
   Replace `YOUR-USERNAME` with your GitHub username
4. Headers - add two headers:
   - `Authorization` : `Bearer YOUR-GITHUB-TOKEN` (the token from Step 5.1)
   - `Accept` : `application/vnd.github+json`

### Step 5.7 - Parse the artifact list response

1. Add action: **Data Operations - Parse JSON**
2. Content: click **Add dynamic content** - select **Body** from the HTTP step
3. Schema: click **Generate from sample** and paste this:
   ```json
   {
     "artifacts": [
       {
         "id": 123456,
         "name": "changelog-summary-789",
         "archive_download_url": "https://api.github.com/repos/owner/repo/actions/artifacts/123456/zip"
       }
     ]
   }
   ```
4. Click **Done**

### Step 5.8 - Download the artifact

1. Add action: **HTTP**
2. Method: `GET`
3. URI: click **Add dynamic content** - in the Parse JSON results,
   navigate to `artifacts` - `archive_download_url` (use the first item)
4. Same headers as Step 5.6
5. Under **Advanced options** - set **Follow redirects**: `Yes`

### Step 5.9 - Send the Outlook email

1. Add action: search **Send an email (V2)** - select the Outlook / Office 365 version
2. Fill in:
   - **To**: `brent.kepler@rithum.com`
   - **Subject**:
     ```
     [PM Agents] Changelog Update - @{formatDateTime(utcNow(), 'MMMM dd, yyyy')}
     ```
   - **Body**:
     ```
     A change was made to the PM Agent system today.

     Workflow run: @{triggerBody()?['name']}
     Triggered by commit to: AGENT_CHANGELOG.md
     Run completed at: @{triggerBody()?['updated_at']}

     Review the full changelog:
     https://github.com/YOUR-USERNAME/pm-agents/blob/main/AGENT_CHANGELOG.md

     To revert a change: open Claude Code in the pm-agents repo and tell the
     agent-improver agent: "Revert the [agent-name] change from [date]"
     ```
3. Click **Save**

### Step 5.10 - Test the flow

1. In Power Automate, click **Test** - **Manually** - **Test**
2. In a separate tab, go to your GitHub repo - make a minor edit to
   `AGENT_CHANGELOG.md` (add a comment line at the top) and commit
3. Watch the Power Automate flow run in real time
4. Check your Outlook inbox - the email should arrive within 1-2 minutes

---

## Part 6 - Invite the Team

**Non-technical team members:** Share the claude.ai Project URL (Part 3).
Requires a claude.ai account on the Rithum Team plan.

**Power users:** Share the GitHub repo URL. They follow Part 4.

**Updating agents:** Anyone with GitHub repo access can edit an agent `.md`
file directly in the browser. Claude Code users get updates on `git pull`.
Refresh the claude.ai Project Instructions manually after significant changes.

---

## Troubleshooting

**Claude Code does not see my agents**
- Confirm you ran `claude` from the `pm-agents` repo root
- Confirm files are in `.claude/agents/` - not `.claude/` and not `agents/`
- Check for typos in the `name:` field at the top of each agent file

**Power Automate flow is not triggering**
- Confirm the GitHub connection in Power Automate is authorized to your account
- Confirm the workflow name in the condition exactly matches:
  `Agent Changelog - Flag for Power Automate`
- Check the flow run history in Power Automate for error details

**claude.ai Project sharing not available**
- Requires Claude Team or Enterprise plan
- Contact your Claude workspace admin

**Email not arriving after flow succeeds**
- Check Power Automate flow run history for the Send Email step output
- Confirm the To address is correct in Step 5.9
