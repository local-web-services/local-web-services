"""When: a "neptune" "cluster" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "neptune" "cluster" finishes creating')
def cluster_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster creation completion in lws")
