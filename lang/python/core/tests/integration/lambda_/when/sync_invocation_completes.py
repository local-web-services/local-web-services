"""When: a synchronous function invocation completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@when("a synchronous function invocation completes")
def sync_invocation_completes(client: TestClient, world):
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
