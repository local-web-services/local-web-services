"""When: a group is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a group is deleted")
def delete_group(client: TestClient, world):
    pytest.skip("DeleteGroup is not yet implemented in the lws Cognito provider.")
