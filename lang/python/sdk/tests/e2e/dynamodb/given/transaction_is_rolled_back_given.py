"""Given: the transaction was "ROLLED_BACK" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the transaction was "ROLLED_BACK"')
def transaction_is_rolled_back_given():
    pytest.skip("Cannot force a ROLLED_BACK transaction in this abstract context")
