"""When: a lifecycle rule expires an object"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a lifecycle rule expires an object")
def lifecycle_expire_object(world):
    pytest.skip("Cannot trigger lifecycle expiry in integration test context.")
