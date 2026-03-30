"""Given: automatic failover is enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("automatic failover is enabled")
def automatic_failover_enabled(world):
    pytest.skip("Cannot configure automatic failover in integration tests.")
