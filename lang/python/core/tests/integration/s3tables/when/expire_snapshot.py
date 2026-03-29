"""When: an expired snapshot is removed from a table"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an expired snapshot is removed from a table")
def expire_snapshot(world: dict):
    pytest.skip("Snapshot management is not available in integration context")
