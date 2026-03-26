"""When: a request is made to the throttled dev stage"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a request is made to the throttled dev stage")
def request_throttled_dev(client: TestClient, world):
    pytest.skip(
        "Stage throttling request simulation is not supported in stateless integration tests."
    )
