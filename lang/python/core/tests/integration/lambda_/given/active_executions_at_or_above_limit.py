"""Given: the active executions were at or above the concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the active executions were at or above the concurrency limit")
def active_executions_at_or_above_limit(world):
    pytest.skip("Cannot force concurrency limit exceeded in integration tests.")
