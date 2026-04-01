"""Given: the transaction was "COMMITTED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the transaction was "COMMITTED"')
def transaction_is_committed_given():
    pytest.skip("Cannot force a COMMITTED transaction in integration context")
