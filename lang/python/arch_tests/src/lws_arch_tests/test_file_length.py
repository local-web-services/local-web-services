"""Architecture test: source files must not exceed 500 lines.

Long files are a code smell — they typically indicate that a module is doing
too much and should be split into focused, single-responsibility units.

The limit (500 lines) counts all lines including blank lines and comments so
the count is unambiguous and matches standard ``wc -l`` output.
"""

from __future__ import annotations

from lws_arch_tests._root import project_root

_MAX_LINES = 500


class TestFileLength:
    def test_source_files_do_not_exceed_line_limit(self):
        # Arrange
        src_dir = project_root() / "src"
        violations: list[str] = []

        # Act
        for py_file in sorted(src_dir.rglob("*.py")):
            line_count = len(py_file.read_text().splitlines())
            if line_count > _MAX_LINES:
                rel = py_file.relative_to(project_root())
                violations.append(f"{rel} ({line_count} lines)")

        # Assert
        assert len(violations) == 0, (
            f"Found {len(violations)} source file(s) exceeding {_MAX_LINES} lines. "
            f"Refactor long files into smaller, focused modules.\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
