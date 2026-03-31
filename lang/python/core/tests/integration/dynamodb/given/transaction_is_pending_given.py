"""Given: a transaction was "PENDING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a transaction was "PENDING"')
def transaction_is_pending_given():
    pytest.skip("Cannot force a PENDING transaction in integration context")
