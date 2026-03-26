"""When: a database cluster snapshot finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database cluster snapshot finishes creating")
def snapshot_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune snapshot creation completion in lws")
