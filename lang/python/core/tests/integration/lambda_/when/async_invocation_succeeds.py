"""When: a "lambda" "async" invocation succeeds"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@when('a "lambda" "async" invocation succeeds')
def async_invocation_succeeds(client: TestClient, world):
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
