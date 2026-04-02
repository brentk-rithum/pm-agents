#!/bin/bash
# validate-agents.sh
# Validates that all agent source directories are complete and consistent.
#
# Checks:
#   - metadata.json exists and is valid JSON
#   - All files listed in metadata.json["files"] exist
#   - All files listed in metadata.json["dependencies"] exist
#   - Runtime .claude/agents/<name>.md exists (warns if not yet built)
#   - agent-registry.json is consistent with agents/ directories

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AGENTS_DIR="$REPO_ROOT/agents"
OUTPUT_DIR="$REPO_ROOT/.claude/agents"
REGISTRY="$REPO_ROOT/config/agent-registry.json"

ERRORS=0
WARNINGS=0

echo "Validating agent sources..."
echo ""

for agent_dir in "$AGENTS_DIR"/*/; do
  agent_name="$(basename "$agent_dir")"
  metadata="$agent_dir/metadata.json"

  echo "Checking: $agent_name"

  # Check metadata.json exists
  if [ ! -f "$metadata" ]; then
    echo "  ERROR: missing metadata.json"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check metadata.json is valid JSON
  if ! jq empty "$metadata" 2>/dev/null; then
    echo "  ERROR: metadata.json is not valid JSON"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check required fields
  for field in name version description model tools files; do
    if [ "$(jq -r ".$field // empty" "$metadata")" = "" ]; then
      echo "  ERROR: metadata.json missing required field: $field"
      ERRORS=$((ERRORS + 1))
    fi
  done

  # Check source files exist
  files=$(jq -r '.files[]?' "$metadata")
  for file in $files; do
    if [ ! -f "$agent_dir/$file" ]; then
      echo "  ERROR: source file listed in metadata but not found: $file"
      ERRORS=$((ERRORS + 1))
    fi
  done

  # Check dependency files exist
  deps=$(jq -r '.dependencies[]?' "$metadata")
  for dep in $deps; do
    if [ ! -f "$REPO_ROOT/$dep" ]; then
      echo "  ERROR: dependency listed in metadata but not found: $dep"
      ERRORS=$((ERRORS + 1))
    fi
  done

  # Check runtime file exists (warning only - may not be built yet)
  runtime="$OUTPUT_DIR/$agent_name.md"
  if [ ! -f "$runtime" ]; then
    echo "  WARNING: runtime file not found (run build-agents.sh): .claude/agents/$agent_name.md"
    WARNINGS=$((WARNINGS + 1))
  fi

  echo "  OK"
done

echo ""
echo "Checking agent-registry.json consistency..."

# Check all registry entries have a source directory
registry_names=$(jq -r '.agents[].name' "$REGISTRY")
for name in $registry_names; do
  if [ ! -d "$AGENTS_DIR/$name" ]; then
    echo "  WARNING: agent in registry has no source directory: $name"
    WARNINGS=$((WARNINGS + 1))
  fi
done

# Check all source directories are in the registry
for agent_dir in "$AGENTS_DIR"/*/; do
  agent_name="$(basename "$agent_dir")"
  if ! jq -e ".agents[] | select(.name == \"$agent_name\")" "$REGISTRY" > /dev/null 2>&1; then
    echo "  WARNING: agent source directory not in registry: $agent_name"
    WARNINGS=$((WARNINGS + 1))
  fi
done

echo ""
echo "Validation complete: $ERRORS error(s), $WARNINGS warning(s)"

if [ $ERRORS -gt 0 ]; then
  exit 1
fi
