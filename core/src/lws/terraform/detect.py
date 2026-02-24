"""Project type detection for LWS."""

from __future__ import annotations

from pathlib import Path


def detect_project_type(project_dir: Path) -> str:
    """Detect whether the project directory is CDK, Terraform, or unknown.

    Returns:
        ``"cdk"`` if a ``cdk.out`` directory exists.
        ``"terraform"`` if ``.tf`` files exist and no ``cdk.out``.
        ``"ambiguous"`` if both are present.
        ``"none"`` if neither is found.
    """
    has_cdk = (project_dir / "cdk.out").is_dir()
    has_tf = any(project_dir.glob("*.tf"))

    if has_cdk and has_tf:
        return "ambiguous"
    if has_cdk:
        return "cdk"
    if has_tf:
        return "terraform"
    return "none"
