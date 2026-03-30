"""When: compaction is started on a table"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("compaction is started on a table")
def start_compaction(world: dict):
    pytest.skip("Compaction is not available in integration context")
