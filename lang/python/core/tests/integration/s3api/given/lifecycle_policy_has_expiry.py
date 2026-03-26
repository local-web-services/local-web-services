"""Given: the lifecycle policy has an expiry rule for the object"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the lifecycle policy has an expiry rule for the object")
def lifecycle_policy_has_expiry(world):
    pytest.skip("Cannot configure lifecycle expiry in integration test context.")
