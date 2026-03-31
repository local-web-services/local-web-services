"""When: a "neptune" "cluster" neptune snapshot finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "neptune" "cluster" neptune snapshot finishes creating')
def snapshot_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune snapshot creation completion in lws")
