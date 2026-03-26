"""When: an async invocation fails and is retried"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an async invocation fails and is retried")
def async_invocation_fails_and_retried(client: TestClient, world):
    world["result"] = None
    pytest.skip("Cannot force async invocation failure and retry in integration tests.")
