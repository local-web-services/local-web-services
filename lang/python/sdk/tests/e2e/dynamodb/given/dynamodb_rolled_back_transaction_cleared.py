"""Given: a rolled-back "dynamodb" "transaction" is cleared"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a rolled-back "dynamodb" "transaction" is cleared')
def dynamodb_rolled_back_transaction_cleared():
    pytest.skip("Cannot trigger transaction clearing as sequence setup in lws")
