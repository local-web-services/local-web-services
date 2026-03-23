"""Lambda code path resolution helpers."""

from __future__ import annotations

import re
from pathlib import Path

from lws.logging.logger import get_logger

_logger = get_logger("ldk.lambda-mgmt")


def resolve_code_path(filename: str | None, project_dir: Path | None) -> Path | None:
    """Resolve the Lambda code path from Terraform's zip Filename."""
    if not filename:
        return None

    zip_path = Path(filename)

    if zip_path.is_dir():
        return zip_path

    if project_dir is not None:
        stem = zip_path.stem
        candidate = project_dir / "lambda" / stem
        if candidate.is_dir():
            return candidate

        candidate2 = project_dir / "src" / "lambda" / stem
        if candidate2.is_dir():
            return candidate2

    if zip_path.parent.exists():
        return zip_path.parent

    return Path(".")


def resolve_code_path_from_name(function_name: str, project_dir: Path) -> Path | None:
    """Try to find the Lambda source directory using the function name."""
    name = function_name
    for suffix in ("Function", "Lambda", "Handler"):
        if name.endswith(suffix):
            name = name[: -len(suffix)]
            break

    kebab = re.sub(r"(?<=[a-z0-9])([A-Z])", r"-\1", name).lower()
    snake = re.sub(r"(?<=[a-z0-9])([A-Z])", r"_\1", name).lower()
    lower = name.lower()

    candidates = [kebab, snake, lower, function_name]

    for candidate in candidates:
        for base in [project_dir / "lambda", project_dir / "src" / "lambda"]:
            path = base / candidate
            if path.is_dir():
                _logger.debug("Resolved code path for %s → %s", function_name, path)
                return path

    return None
