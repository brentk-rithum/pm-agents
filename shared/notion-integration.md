# Notion Integration Standards

## Available MCP Tools

- `mcp__notion__notion-search` - search pages and databases
- `mcp__notion__notion-fetch` - read a page or database by URL or ID
- `mcp__notion__notion-create-pages` - create a new page
- `mcp__notion__notion-update-page` - update an existing page

## Confirmation Before Any Write

**Never save or overwrite Notion pages without explicit user confirmation.**

Always present a preview and ask:
> "Should I save this to Notion now?"

Only proceed after an explicit "yes", "save it", "go ahead", or equivalent.

## Template Lookup Logic

### Brands Platform

Search Notion for the established Brands template by name. If found, confirm with the user before proceeding. If not found, use the default structure defined in the agent.

Known Brands templates:
- Business Case: `https://www.notion.so/commercehub/Business-Case-Template-321e0f2aafae80aa84c7fe23027b757b`
- PRD: `https://www.notion.so/commercehub/PRD-Template-LC-f15d645f480d4ea0bb31cfc80b707554`

### Retailer Platform

Retailer users may have multiple templates. Follow this logic:

1. Search Notion for `"[document type] template" Retailer`
2. **No templates found:** Use default structure. After completion, ask if user wants to save this as their default Retailer template. If yes, save to session memory.
3. **One template found:** Ask if user wants this as their default for all Retailer work going forward. Save preference.
4. **Multiple templates found:** Present the list and ask which to use. Ask if they want a default saved.
5. **Saved preference exists:** Use it automatically. Confirm briefly before proceeding.

## PRD Database

When saving a new PRD to Notion, target this database:
`https://www.notion.so/commercehub/c9eef9f5f5ad4a72b4a03de122aac799`

Confirm the title before creating, and ask the user about optional database fields.

## Updating Existing Pages

1. Fetch the current page from Notion first
2. Ask the user what specifically needs to change
3. Make targeted edits only - do not rewrite sections not in scope unless explicitly asked
4. Confirm before saving changes
