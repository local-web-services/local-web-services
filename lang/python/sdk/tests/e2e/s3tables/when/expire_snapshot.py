"""When: an expired snapshot is removed from a table"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an expired snapshot is removed from a table")
def expire_snapshot(lws_session, world):
    pytest.skip("Cannot expire a table snapshot without Iceberg client in lws")
