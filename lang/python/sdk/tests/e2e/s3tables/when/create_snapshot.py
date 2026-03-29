"""When: a snapshot is created for a table"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a snapshot is created for a table")
def create_snapshot(lws_session, world):
    pytest.skip("Cannot create a table snapshot without Iceberg client in lws")
