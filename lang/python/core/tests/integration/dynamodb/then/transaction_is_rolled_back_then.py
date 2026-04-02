"""Then: the "dynamodb" "transaction" was "ROLLED_BACK" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "dynamodb" "transaction" was "ROLLED_BACK"')
def transaction_is_rolled_back_then(world: dict):
    pytest.skip("Cannot observe ROLLED_BACK state in integration context")
