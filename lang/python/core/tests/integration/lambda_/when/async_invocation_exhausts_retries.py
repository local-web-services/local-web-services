"""When: a "lambda" "async" invocation exhausts all retries"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "lambda" "async" invocation exhausts all retries')
def async_invocation_exhausts_retries(client: TestClient, world):
    world["result"] = None
    pytest.skip("Cannot exhaust async invocation retries in integration tests.")
