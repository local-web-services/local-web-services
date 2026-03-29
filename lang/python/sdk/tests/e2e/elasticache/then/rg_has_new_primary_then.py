"""Then: the replication group has a new primary cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the replication group has a new primary cluster")
def rg_has_new_primary_then():
    pytest.skip("Cannot observe internal replication group primary cluster change in lws")
