"""When: a blue-green deployment completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a blue-green deployment completes")
def blue_green_complete(client: TestClient, world: dict):
    pytest.skip(
        "Blue-green deployment completion cannot be triggered in stateless integration tests."
    )
