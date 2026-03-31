"""When: the transaction was "ROLLED_BACK" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the transaction was "ROLLED_BACK"')
def rollback_transaction(world):
    pytest.skip("Cannot trigger transaction rollback externally in lws")
