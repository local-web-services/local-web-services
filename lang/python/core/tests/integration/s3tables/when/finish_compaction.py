"""When: compaction finishes on a table"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("compaction finishes on a table")
def finish_compaction(world: dict):
    pytest.skip("Internal compaction lifecycle is not triggerable in integration context")
