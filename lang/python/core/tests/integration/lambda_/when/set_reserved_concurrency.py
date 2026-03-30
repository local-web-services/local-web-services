"""When: reserved concurrency is set for a function"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("reserved concurrency is set for a function")
def set_reserved_concurrency(client: TestClient, world):
    pytest.skip("lws does not implement the PUT /concurrency route for Lambda functions.")
