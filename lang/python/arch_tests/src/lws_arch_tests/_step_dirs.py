"""Shared helpers for BDD step-directory architecture tests."""
from __future__ import annotations

from pathlib import Path

STEP_DIR_NAMES: frozenset[str] = frozenset({"given", "when", "then"})
SESSION_PARAM_NAMES: frozenset[str] = frozenset(
    {"client", "lws_session", "session", "aws_client", "sync_client"}
)
STEP_DECORATOR_NAMES: frozenset[str] = frozenset({"given", "when", "then"})


def find_step_service_dirs(root: Path) -> list[Path]:
    """Return all service directories (under tests/integration or tests/e2e) that
    contain at least one of given/, when/, then/ subdirectories."""
    test_dirs = [root / "tests" / "integration", root / "tests" / "e2e"]
    dirs: list[Path] = []
    for test_dir in test_dirs:
        if not test_dir.exists():
            continue
        if any((test_dir / d).exists() for d in STEP_DIR_NAMES):
            dirs.append(test_dir)
        for child in sorted(test_dir.iterdir()):
            if child.is_dir() and not child.name.startswith((".", "_")):
                if any((child / d).exists() for d in STEP_DIR_NAMES):
                    dirs.append(child)
    return dirs


def iter_step_files(service_dir: Path):
    """Yield all .py step files (excluding __init__.py) in given/when/then subdirs."""
    for step_dir_name in STEP_DIR_NAMES:
        step_dir = service_dir / step_dir_name
        if not step_dir.exists():
            continue
        for py_file in sorted(step_dir.glob("*.py")):
            if py_file.name != "__init__.py":
                yield py_file
