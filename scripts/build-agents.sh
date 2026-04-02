#!/bin/bash
# build-agents.sh
# Assembles modular source files (agents/ + shared/) into .claude/agents/*.md runtime files.
#
# Usage:
#   ./scripts/build-agents.sh              # rebuild all agents
#   ./scripts/build-agents.sh story-writer # rebuild one agent
#
# After editing any file in agents/ or shared/, run this script to regenerate
# the .claude/agents/ files that Claude Code reads at runtime.

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AGENTS_DIR="$REPO_ROOT/agents"
OUTPUT_DIR="$REPO_ROOT/.claude/agents"

# Determine which agents to build
if [ -n "$1" ]; then
  TARGETS=("$1")
else
  TARGETS=()
  for dir in "$AGENTS_DIR"/*/; do
    TARGETS+=("$(basename "$dir")")
  done
fi

for agent_name in "${TARGETS[@]}"; do
  agent_dir="$AGENTS_DIR/$agent_name"
  metadata="$agent_dir/metadata.json"
  output="$OUTPUT_DIR/$agent_name.md"

  if [ ! -f "$metadata" ]; then
    echo "SKIP: $agent_name - no metadata.json found"
    continue
  fi

  echo "Building: $agent_name"

  # Read metadata fields
  name=$(jq -r '.name' "$metadata")
  description=$(jq -r '.description' "$metadata")
  model=$(jq -r '.model' "$metadata")
  memory=$(jq -r '.memory // empty' "$metadata")

  # Build tools list as comma-separated string
  tools=$(jq -r '.tools | join(", ")' "$metadata")

  # Write YAML frontmatter
  {
    echo "---"
    echo "name: $name"
    echo "description: $description"
    echo "model: $model"
    echo "tools: $tools"
    [ -n "$memory" ] && echo "memory: $memory"
    echo "---"
    echo ""
    echo "<!-- GENERATED FILE - do not edit directly -->"
    echo "<!-- Source: agents/$agent_name/ and shared/ -->"
    echo "<!-- Rebuild: scripts/build-agents.sh $agent_name -->"
    echo ""
  } > "$output"

  # Include shared dependency files
  deps=$(jq -r '.dependencies[]?' "$metadata")
  for dep in $deps; do
    dep_path="$REPO_ROOT/$dep"
    if [ -f "$dep_path" ]; then
      cat "$dep_path" >> "$output"
      echo "" >> "$output"
    else
      echo "WARNING: dependency not found: $dep"
    fi
  done

  # Include agent source files in declared order
  files=$(jq -r '.files[]' "$metadata")
  for file in $files; do
    file_path="$agent_dir/$file"
    if [ -f "$file_path" ]; then
      echo "" >> "$output"
      cat "$file_path" >> "$output"
      echo "" >> "$output"
    else
      echo "WARNING: source file not found: agents/$agent_name/$file"
    fi
  done

  echo "  -> Written to .claude/agents/$agent_name.md"
done

echo ""
echo "Build complete."
