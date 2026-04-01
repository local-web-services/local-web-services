#!/usr/bin/env python3
"""
update_step_definitions.py

Reads the git diff of .fizz annotation changes and updates matching
@given / @when / @then decorator strings and module docstrings in
Python e2e step definition files.

The script derives the expected decorator text from annotation text the same
way fizz_to_gherkin.py does (via _quote_caps), so old and new decorator
strings are computed from the diff rather than hardcoded.

Usage:
    python tools/update_step_definitions.py
    python tools/update_step_definitions.py --dry-run
    python tools/update_step_definitions.py --diff-ref main
    python tools/update_step_definitions.py --search-root lang/python/sdk/tests/e2e
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

# Reuse _quote_caps from fizz_to_gherkin so decorator text derivation is identical.
_TOOLS_DIR = Path(__file__).parent
sys.path.insert(0, str(_TOOLS_DIR))
from fizz_to_gherkin import _quote_caps  # noqa: E402


# ---------------------------------------------------------------------------
# Annotation parsing
# ---------------------------------------------------------------------------

# Longer prefixes listed first to avoid prefix shadowing (guard_violation_lifecycle
# must be matched before guard_violation).
_ANNOTATION_TYPES: list[tuple[str, re.Pattern]] = [
    ("guard_violation_lifecycle", re.compile(r"^#\s*guard_violation_lifecycle:\s*(.+)$")),
    ("guard_violation_capacity", re.compile(r"^#\s*guard_violation_capacity:\s*(.+)$")),
    ("guard_violation", re.compile(r"^#\s*guard_violation:\s*(.+)$")),
    ("guard", re.compile(r"^#\s*guard:\s*(.+)$")),
    ("result", re.compile(r"^#\s*result:\s*(.+)$")),
    ("step", re.compile(r"^#\s*step:\s*(.+)$")),
    ("check", re.compile(r"^#\s*check:\s*(.+)$")),
]


def _match_annotation(line: str) -> tuple[str, str] | None:
    """Return (type, raw_text) if line is a structured annotation comment, else None."""
    for typ, pat in _ANNOTATION_TYPES:
        m = pat.match(line)
        if m:
            return typ, m.group(1).strip()
    return None


def parse_annotation_changes(diff_text: str) -> list[tuple[str, str]]:
    """
    Parse a unified diff and return a list of (old_decorator_text, new_decorator_text)
    pairs derived from changed annotation comment lines in .fizz files.

    Each text is the _quote_caps-processed version, matching what fizz_to_gherkin.py
    writes into the Gherkin step text.
    """
    changes: list[tuple[str, str]] = []
    # List of (type, raw_text) for removed annotation lines awaiting a matching addition.
    pending_removed: list[tuple[str, str]] = []

    for line in diff_text.splitlines():
        # Skip diff metadata headers.
        if line.startswith(("---", "+++", "@@", "diff ", "index ")):
            pending_removed.clear()
            continue

        if line.startswith("-"):
            inner = line[1:]
            result = _match_annotation(inner)
            if result:
                pending_removed.append(result)
            elif inner.strip() and not inner.lstrip().startswith("#"):
                # Removed non-annotation code line — don't carry pending across it.
                pending_removed.clear()

        elif line.startswith("+"):
            inner = line[1:]
            result = _match_annotation(inner)
            if result:
                new_typ, new_raw = result
                # Match against the first pending removal of the same annotation type.
                for i, (rtyp, rraw) in enumerate(pending_removed):
                    if rtyp == new_typ:
                        old_text = _quote_caps(rraw)
                        new_text = _quote_caps(new_raw)
                        if old_text != new_text:
                            changes.append((old_text, new_text))
                        pending_removed.pop(i)
                        break

        else:
            # Context line — unmatched pending removals were deletions, not changes.
            pending_removed.clear()

    return changes


# ---------------------------------------------------------------------------
# File updating
# ---------------------------------------------------------------------------

def _update_file(
    path: Path,
    replacements: list[tuple[str, str]],
    dry_run: bool,
) -> bool:
    """
    Replace old step text with new in decorator strings and module docstrings.

    Handles both quoting styles used in pytest-bdd decorators:
        @given("the table exists")
        @given('the table is "ACTIVE"')

    Also handles the module-level docstring format:
        \"\"\"Given: the table exists\"\"\"
        \"\"\"Then: the table is \"ACTIVE\" and ready for reads and writes\"\"\"

    Returns True if the file was (or would be) changed.
    """
    content = path.read_text()
    updated = content

    for old_text, new_text in replacements:
        # Decorator strings (single or double quoted).
        # When new_text contains double quotes, force single-quote outer wrapping
        # to avoid @given("text with "inner" quotes") which is invalid Python.
        new_quote = "'" if '"' in new_text else None
        for quote in ('"', "'"):
            outer = new_quote or quote
            updated = updated.replace(
                f"{quote}{old_text}{quote}",
                f"{outer}{new_text}{outer}",
            )

        # Module docstring: the text appears after "{Keyword}: " and before the
        # closing triple-quote.  Replace both """ and ''' styles, and handle
        # optional trailing whitespace before the closing quotes.
        # When new_text itself ends with " we must insert a space before the
        # closing triple-quote to avoid the ambiguous """..."""""  sequence.
        for tq in ('"""', "'''"):
            suffix = f" {tq}" if new_text.endswith('"') else tq
            updated = updated.replace(f": {old_text}{tq}", f": {new_text}{suffix}")
            updated = updated.replace(f": {old_text} {tq}", f": {new_text}{suffix}")

    if updated == content:
        return False

    if not dry_run:
        path.write_text(updated)
    return True


# ---------------------------------------------------------------------------
# Git helpers
# ---------------------------------------------------------------------------

def _repo_root() -> Path:
    result = subprocess.run(
        ["git", "rev-parse", "--show-toplevel"],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        print("Could not determine git repo root.", file=sys.stderr)
        sys.exit(1)
    return Path(result.stdout.strip())


def _get_diff(diff_ref: str, repo_root: Path) -> str:
    result = subprocess.run(
        ["git", "diff", diff_ref, "--unified=0", "--", "*.fizz"],
        capture_output=True,
        text=True,
        cwd=repo_root,
    )
    if result.returncode != 0:
        print(f"git diff failed: {result.stderr}", file=sys.stderr)
        sys.exit(1)
    return result.stdout


def _find_step_files(root: Path) -> list[Path]:
    """Find all Python files under e2e and integration test directories."""
    return sorted(list(root.rglob("tests/e2e/**/*.py")) + list(root.rglob("tests/integration/**/*.py")))


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description=(
            "Update pytest-bdd step definition decorators to match .fizz annotation changes.\n"
            "\n"
            "Reads the git diff of .fizz files and updates any @given/@when/@then decorator\n"
            "strings and module docstrings whose text matches the old annotation value."
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print which files would change without writing them.",
    )
    parser.add_argument(
        "--diff-ref",
        default="HEAD",
        help=(
            "Git ref to diff against (default: HEAD — compares the working tree to the\n"
            "last commit).  Use 'main' or a commit SHA to diff against another baseline."
        ),
    )
    parser.add_argument(
        "--search-root",
        default=None,
        help=(
            "Root directory to search for Python step files.  Defaults to the repo root\n"
            "so that both sdk and example e2e suites are updated."
        ),
    )
    args = parser.parse_args()

    repo_root = _repo_root()
    search_root = Path(args.search_root) if args.search_root else repo_root

    diff_text = _get_diff(args.diff_ref, repo_root)
    if not diff_text:
        print("No .fizz changes found in diff.", file=sys.stderr)
        return

    replacements = parse_annotation_changes(diff_text)
    if not replacements:
        print("No annotation text changes found in diff.", file=sys.stderr)
        return

    print(f"Found {len(replacements)} annotation text change(s):", file=sys.stderr)
    for old, new in replacements:
        print(f"  {old!r}", file=sys.stderr)
        print(f"  -> {new!r}", file=sys.stderr)
        print(file=sys.stderr)

    step_files = _find_step_files(search_root)
    changed_files: list[Path] = []
    for path in step_files:
        if _update_file(path, replacements, dry_run=args.dry_run):
            changed_files.append(path)
            action = "Would update" if args.dry_run else "Updated"
            print(f"{action}: {path.relative_to(repo_root)}")

    print(file=sys.stderr)
    action = "Would update" if args.dry_run else "Updated"
    print(f"{action} {len(changed_files)} file(s).", file=sys.stderr)


if __name__ == "__main__":
    main()
