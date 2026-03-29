"""When: a snapshot finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a snapshot finishes creating")
def snapshot_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB snapshot creation completion in lws")
