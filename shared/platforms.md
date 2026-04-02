# Platform Branching Guide

## Overview

All agents adapt behavior based on the user's declared platform. Platform determines:
- Which Notion templates to use
- Which JIRA projects and stakeholders are relevant
- Which context to apply when writing outputs

## Brands Platform

**Former name:** ChannelAdvisor

- Uses established Brands templates stored in Notion
- Standard JIRA projects owned by each PM
- Stakeholder context: Lou Camassa (manager), Sean Meeks (VP)
- Template search term: `"[document type] template" Brands`

**Template behavior:** Search Notion for the known Brands template. If found, confirm with user before proceeding. If not found, use default structure in the agent.

## Retailer Platform

**Former name:** CommerceHub

- Templates may vary - Retailer users may have multiple accumulated templates
- Ask which template to use; save preference for the session
- Template search term: `"[document type] template" Retailer`

**Template behavior:** Follow the multi-template discovery logic defined in `shared/notion-integration.md`.

## Template Hierarchy (All Platforms)

1. Check Notion for an existing team template first
2. If no Notion template exists, check for an attached Word or Excel file
3. If no template is provided, use the default structure defined in the agent
4. Always confirm with the user which template to use before writing

## Memory Behavior

- `business-case` and `prd-writer` agents use `memory: project` so template preferences persist across Claude Code sessions
- In the claude.ai Project, preferences reset each session
- Session memory key for platform: `user_platform`
- Session memory key for saved templates: `retailer_bc_template`, `retailer_prd_template`
