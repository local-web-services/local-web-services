"""When: a transaction is committed"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a transaction is committed")
def commit_transaction(world):
    pytest.skip("Cannot trigger transaction commit externally in lws")
