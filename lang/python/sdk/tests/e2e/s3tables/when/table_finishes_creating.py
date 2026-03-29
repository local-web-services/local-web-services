"""When: a table finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a table finishes creating")
def table_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal table creation completion in lws")
