"""Gitignore management for LWS Terraform mode."""

from __future__ import annotations

from pathlib import Path

from lws.terraform.override import OVERRIDE_FILENAME


def ensure_gitignore(project_dir: Path) -> None:
    """Ensure the override file is listed in ``.gitignore``.

    - If ``.gitignore`` exists and already contains the entry, do nothing.
    - If ``.gitignore`` exists but is missing the entry, append it.
    - If ``.gitignore`` does not exist, create it with the entry.
    """
    gitignore_path = project_dir / ".gitignore"
    entry = OVERRIDE_FILENAME

    if gitignore_path.exists():
        content = gitignore_path.read_text()
        if entry in content.splitlines():
            return
        # Ensure we start on a new line
        if content and not content.endswith("\n"):
            content += "\n"
        content += entry + "\n"
        gitignore_path.write_text(content)
    else:
        gitignore_path.write_text(entry + "\n")
