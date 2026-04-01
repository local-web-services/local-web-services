"""When: a "glacier" "job" fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "glacier" "job" fails')
def job_fails(client: TestClient, world):
    pytest.skip("Job failure transitions are not supported in the stateless lws Glacier provider.")
