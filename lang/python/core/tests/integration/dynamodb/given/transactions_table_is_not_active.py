"""Given: the transaction's table is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the transaction\'s table is not "ACTIVE"')
def transactions_table_is_not_active():
    pytest.skip("Lifecycle simulation (non-ACTIVE state) is not available in integration context")
