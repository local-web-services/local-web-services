"""Then: the "dynamodb" "transaction" will be "COMMITTED" or "ROLLED_BACK" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "dynamodb" "transaction" will be "COMMITTED" or "ROLLED_BACK"')
def transaction_committed_or_rolled_back_then(world):
    pytest.skip("Cannot observe non-deterministic transaction resolution in lws")
