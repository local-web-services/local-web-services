"""Given: the "dynamodb" "transaction" was "ROLLED_BACK" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "dynamodb" "transaction" was "ROLLED_BACK"')
def transaction_is_rolled_back_given():
    pytest.skip("Cannot force a ROLLED_BACK transaction in integration context")
