"""LWS init command — scaffold agent configuration into a project.

Writes a CLAUDE.md snippet and custom slash commands so that coding agents
(Claude Code, etc.) understand how to use lws in the target project.
"""

from __future__ import annotations

import importlib.resources
import shutil
from pathlib import Path

import typer

_MARKER_START = "<!-- LWS:START -->"
_MARKER_END = "<!-- LWS:END -->"


def _templates_dir() -> Path:
    """Return the path to the bundled templates directory."""
    return Path(importlib.resources.files("lws.cli") / "templates")  # type: ignore[arg-type]


def _read_template(name: str) -> str:
    """Read a template file from the bundled templates directory."""
    return (_templates_dir() / name).read_text()


def _write_claude_md(project_dir: Path) -> Path:
    """Append or update the LWS section in CLAUDE.md."""
    claude_md = project_dir / "CLAUDE.md"
    snippet = _read_template("claude_md_snippet.md")
    block = f"{_MARKER_START}\n{snippet}\n{_MARKER_END}"

    if claude_md.exists():
        content = claude_md.read_text()
        if _MARKER_START in content and _MARKER_END in content:
            # Replace existing block
            start = content.index(_MARKER_START)
            end = content.index(_MARKER_END) + len(_MARKER_END)
            content = content[:start] + block + content[end:]
        else:
            content = content.rstrip() + "\n\n" + block + "\n"
    else:
        content = block + "\n"

    claude_md.write_text(content)
    return claude_md


def _write_slash_commands(project_dir: Path) -> list[Path]:
    """Copy slash command templates into .claude/commands/lws/."""
    dest_dir = project_dir / ".claude" / "commands" / "lws"
    dest_dir.mkdir(parents=True, exist_ok=True)
    src_dir = _templates_dir() / "commands" / "lws"

    written: list[Path] = []
    for src_file in sorted(src_dir.glob("*.md")):
        dest_file = dest_dir / src_file.name
        shutil.copy2(src_file, dest_file)
        written.append(dest_file)
    return written


def init_command(
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
) -> None:
    """Initialize lws agent configuration in a project.

    Writes a CLAUDE.md snippet and custom slash commands so that coding
    agents understand how to use lws mock and chaos features.
    """
    project_dir = project_dir.resolve()

    claude_md = _write_claude_md(project_dir)
    typer.echo(f"Updated {claude_md.relative_to(project_dir)}")

    commands = _write_slash_commands(project_dir)
    for cmd in commands:
        typer.echo(f"  Wrote {cmd.relative_to(project_dir)}")

    typer.echo(
        "\nDone! Your coding agent now has access to:"
        "\n  /lws:mock  — Create or configure AWS operation mocks"
        "\n  /lws:chaos — Enable chaos engineering"
    )
