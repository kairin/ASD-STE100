#!/usr/bin/env bash
set -eu

repo_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
delivery_doc="$repo_dir/docs/ste-delivery.md"
dotfiles_repo="${DOTFILES_REPO:-$repo_dir/../000-dotfiles}"
delivery_home="${STE_DELIVERY_HOME:-$HOME}"
sync_script="$dotfiles_repo/scripts/sync-ste-writing.sh"
package_dir="$dotfiles_repo/skills/ste-writing"

source_files=(
  "ste-writing-skill.md"
  "ste-lint.py"
  "ste-recurring-errors.md"
  "ste-system-append.md"
  "ste-senior-engineer-prompt.md"
)

test -f "$delivery_doc"
test -f "$sync_script"
test -d "$package_dir"

for source_file in "${source_files[@]}"; do
  test -f "$repo_dir/$source_file"
  rg -q --fixed-strings "\`$source_file\`" "$delivery_doc"
done

automated_mappings=(
  "ste-writing-skill.md:SKILL.md"
  "ste-lint.py:ste-lint.py"
  "ste-recurring-errors.md:ste-recurring-errors.md"
)

for mapping in "${automated_mappings[@]}"; do
  source_file="${mapping%%:*}"
  package_file="${mapping#*:}"
  test -f "$package_dir/$package_file"
  cmp -s "$repo_dir/$source_file" "$package_dir/$package_file"
  echo "source-package match: $source_file -> $package_file"
  sync_line="refresh_one \"\$ASD_STE100_SRC/$source_file\" \"\$SKILL_DIR/$package_file\""
  rg -q --fixed-strings "$sync_line" "$sync_script"
done

manual_files=(
  "ste-system-append.md"
  "ste-senior-engineer-prompt.md"
)

for source_file in "${manual_files[@]}"; do
  sync_line="refresh_one \"\$ASD_STE100_SRC/$source_file\""
  if rg -q --fixed-strings "$sync_line" "$sync_script"; then
    echo "manual file is listed as automated: $source_file" >&2
    exit 1
  fi
done

while IFS= read -r package_file; do
  case "${package_file#"$package_dir/"}" in
    "SKILL.md"|"ste-lint.py"|"ste-recurring-errors.md") ;;
    *)
      echo "unexpected packaged file: ${package_file#"$package_dir/"}" >&2
      exit 1
      ;;
  esac
done < <(find "$package_dir" -type f -print)

preferred_tool_found=false
for tool_command in hermes pi codex agy; do
  if command -v "$tool_command" >/dev/null 2>&1; then
    preferred_tool_found=true
  fi
done

compare_destination() {
  destination_dir="$1"
  destination_name="$2"

  for mapping in "${automated_mappings[@]}"; do
    source_file="${mapping%%:*}"
    package_file="${mapping#*:}"
    destination_file="$destination_dir/$package_file"

    if ! test -f "$destination_file"; then
      echo "missing $destination_name file: $destination_file" >&2
      return 1
    fi

    if ! cmp -s "$repo_dir/$source_file" "$destination_file"; then
      echo "drift in $destination_name file: $destination_file" >&2
      return 1
    fi

    echo "source-destination match: $source_file -> $destination_name/$package_file"
  done
}

if "$preferred_tool_found"; then
  compare_destination \
    "$delivery_home/.agents/skills/ste-writing" \
    "portable destination"
fi

if command -v hermes >/dev/null 2>&1; then
  compare_destination \
    "$delivery_home/.hermes/skills/ste-writing" \
    "Hermes destination"
fi

if command -v agy >/dev/null 2>&1; then
  compare_destination \
    "$delivery_home/.gemini/config/skills/ste-writing" \
    "Antigravity destination"
fi

for tool_name in \
  "Hermes" \
  "Pi" \
  "OpenAI Codex CLI" \
  "Google Antigravity (\`agy\`)"; do
  rg -q --fixed-strings "$tool_name" "$delivery_doc"
done

for destination in \
  "~/.agents/skills/ste-writing/" \
  "~/.hermes/skills/ste-writing/" \
  "~/.gemini/config/skills/ste-writing/"; do
  rg -q --fixed-strings "$destination" "$delivery_doc"
done

issue_url="https://github.com/kairin/ASD-STE100/issues/10"
rg -q --fixed-strings "$issue_url" "$repo_dir/README.md"
rg -q --fixed-strings "$issue_url" "$delivery_doc"

term_one="cl""aude"
term_two="anthr""opic"
term_three="s""onnet"
term_four="o""pus"
term_five="ha""iku"
prohibited_pattern="$term_one|$term_two|$term_three|$term_four|$term_five"

if rg -n -i \
  --hidden \
  --glob '!.git/**' \
  "$prohibited_pattern" \
  "$repo_dir"; then
  echo "prohibited material found" >&2
  exit 1
fi

echo "STE source, package, synchronizer, destination, and purge checks passed"
