"""Given: the group exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given
from starlette.testclient import TestClient


@given("the group exists")
def group_exists(client: TestClient, world):
    pytest.skip(
        "CreateGroup is not yet implemented in the lws Cognito provider; "
        "cannot create a group to satisfy this precondition."
    )
