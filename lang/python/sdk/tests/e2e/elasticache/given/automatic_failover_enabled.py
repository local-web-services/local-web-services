"""Given: automatic failover was "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('automatic failover was "ENABLED"')
def automatic_failover_enabled():
    pytest.skip("Cannot configure automatic failover in this context")
