"""When: a database instance finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database instance finishes creating")
def instance_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal RDS instance creation completion in lws")
