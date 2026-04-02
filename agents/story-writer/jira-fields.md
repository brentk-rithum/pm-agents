# Story Writer - JIRA Field Reference

## Standard Project Fields

All standard Rithum for Brands stories use:
- **Summary** - verb-first, concise title
- **Description** - Problem + User Story + Acceptance Criteria + Additional Context
- **Story Points** - only if provided by PM or explicitly requested

## ChannelSync (SYNC) Project - Special Fields

SYNC stories require two additional fields that do not appear in standard JIRA responses.

### ChannelSync Team

- **Custom field ID:** `customfield_11997`
- Must be explicitly requested when querying or creating SYNC tickets - it will not appear in standard field responses
- **Valid values (confirmed from JIRA field metadata):**
  - Any Team
  - Access
  - CIT
  - Mercury
  - Orders
  - Platform/Walmart
  - Products

### Components

- Lists the component(s) affected by the story
- Valid values change over time - always query recent SYNC tickets to get current component values

## SYNC Story Workflow

1. Identify the story targets the SYNC project
2. Query recent SYNC tickets: `project = SYNC ORDER BY created DESC` (limit 5-10) to retrieve valid ChannelSync Team and Component values currently in use
3. Present the ChannelSync Team options to the user and ask which Team and Component(s) apply
4. **Do not guess these values** - they directly determine team assignment
5. Include both fields in the story when creating in JIRA

## Field ID Reference

| Field | ID | Notes |
|---|---|---|
| ChannelSync Team | `customfield_11997` | SYNC only; must be explicitly requested |
| Components | standard `components` field | SYNC only; query recent tickets for valid values |
| Story Points | standard `story_points` or `customfield_10016` | All projects; only set if provided |
