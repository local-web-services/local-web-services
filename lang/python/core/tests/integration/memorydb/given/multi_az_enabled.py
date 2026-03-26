"""Given: multi-"AZ" is enabled for the cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('multi-"AZ" is enabled for the cluster')
def multi_az_enabled(world):
    pytest.skip("Cannot configure multi-AZ in integration tests.")
