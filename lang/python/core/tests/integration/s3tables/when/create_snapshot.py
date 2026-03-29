"""When: a snapshot is created for a table"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a snapshot is created for a table")
def create_snapshot(world: dict):
    pytest.skip("Snapshot management is not available in integration context")
