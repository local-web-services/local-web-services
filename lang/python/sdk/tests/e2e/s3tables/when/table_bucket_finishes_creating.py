"""When: a table bucket finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a table bucket finishes creating")
def table_bucket_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal table bucket creation completion in lws")
