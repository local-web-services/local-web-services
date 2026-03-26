"""Given: a pending transaction has resolved non-deterministically"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a pending transaction has resolved non-deterministically")
def dynamodb_pending_transaction_resolved():
    pytest.skip("Cannot trigger non-deterministic transaction resolution as sequence setup in lws")
