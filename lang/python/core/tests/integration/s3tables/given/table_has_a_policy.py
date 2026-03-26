"""Given: the table has a policy"""

from __future__ import annotations

import pytest
from pytest_bdd import given
from starlette.testclient import TestClient


@given("the table has a policy")
def table_has_a_policy(client: TestClient):
    pytest.skip("Table policy management is not implemented in the integration context")
