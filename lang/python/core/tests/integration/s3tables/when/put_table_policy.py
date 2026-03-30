"""When: a policy is attached to a table"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a policy is attached to a table")
def put_table_policy(world: dict):
    pytest.skip("Table policy management is not implemented in the integration context")
