# JIRA Integration Standards

## Available MCP Tools

- `mcp__atlassian__searchJiraIssuesUsingJql` - search issues by JQL
- `mcp__atlassian__getJiraIssue` - fetch a single issue by key
- `mcp__atlassian__createJiraIssue` - create a new issue
- `mcp__atlassian__editJiraIssue` - update an existing issue
- `mcp__atlassian__getJiraProjectIssueTypesMetadata` - get issue types for a project
- `mcp__atlassian__getJiraIssueTypeMetaWithFields` - get field metadata for an issue type

## Confirmation Before Any Write

**Never create, update, or delete JIRA tickets without explicit user confirmation.**

Always present a preview and ask:
> "Should I create/save this now?"

Only proceed after an explicit "yes", "go ahead", "create it", or equivalent.

## Story Format Standards

- Format: "As a [specific user type], I want [action], so that [value]."
- Always include a **Problem** section above the user story.
- Acceptance criteria must be testable (binary pass/fail).
- Every criterion must be verifiable with a yes/no - no vague criteria.

## ChannelSync (SYNC) Project Special Handling

SYNC stories require two additional fields beyond the standard set:

### ChannelSync Team Field
- Custom field ID: `customfield_11997`
- Must be explicitly requested - will not appear in standard field responses
- Valid values (confirmed from JIRA field metadata):
  - Any Team
  - Access
  - CIT
  - Mercury
  - Orders
  - Platform/Walmart
  - Products

### Components Field
- Lists the component(s) affected by the story
- Always query recent SYNC tickets to get valid component values before creating

### SYNC Workflow
1. Identify the story targets the SYNC project
2. Query recent SYNC tickets to retrieve valid ChannelSync Team and Component values
3. Present options to the user and confirm their selections
4. Do not guess these values - they directly determine team assignment

## Default JQL Patterns

- Backlog items: `project = [PROJECT] AND status = "Backlog" ORDER BY created ASC`
- Active work: `project in ([PROJECTS]) AND status != Done ORDER BY priority DESC`
- Recent SYNC tickets (for field values): `project = SYNC ORDER BY created DESC` (limit 5-10)
