"""Architecture test configuration — sets project root for shared lws_arch_tests."""

from __future__ import annotations

import os
from pathlib import Path


def pytest_configure(config):
    os.environ["LWS_ARCH_PROJECT_ROOT"] = str(Path(__file__).parent.parent.parent)
