"""Then: the object is expired and removed from the bucket"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the object is expired and removed from the bucket")
def object_expired_then(world):
    pytest.skip("Cannot observe lifecycle expiry in integration test context.")
