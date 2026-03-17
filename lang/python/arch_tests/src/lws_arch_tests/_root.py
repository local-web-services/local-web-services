"""Resolve the project root for architecture tests via environment variable."""

from __future__ import annotations

import os
from pathlib import Path


def project_root() -> Path:
    """Return the root directory of the project under test.

    Must be set by each project's ``tests/architecture/conftest.py`` via::

        os.environ["LWS_ARCH_PROJECT_ROOT"] = str(Path(__file__).parent.parent.parent)
    """
    root = os.environ.get("LWS_ARCH_PROJECT_ROOT")
    if not root:
        raise RuntimeError(
            "LWS_ARCH_PROJECT_ROOT is not set. "
            "Set it in tests/architecture/conftest.py before tests run."
        )
    return Path(root)
