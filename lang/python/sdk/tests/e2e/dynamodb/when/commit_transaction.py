"""When: the transaction was "COMMITTED" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the transaction was "COMMITTED"')
def commit_transaction(world):
    pytest.skip("Cannot trigger transaction commit externally in lws")
