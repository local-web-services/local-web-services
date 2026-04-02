"""When: a "api gateway" "backend integration" is called"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "api gateway" "backend integration" is called')
def call_backend_integration(client: TestClient, world):
    pytest.skip("Backend integration invocation is not supported in stateless integration tests.")
