"""When: a transaction is rolled back"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a transaction is rolled back")
def rollback_transaction(world: dict):
    pytest.skip("Cannot trigger transaction rollback externally in integration context")
