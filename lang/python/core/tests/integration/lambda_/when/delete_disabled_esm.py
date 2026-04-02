"""When: a disabled "lambda" "event source mapping" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@when('a disabled "lambda" "event source mapping" is deleted')
def delete_disabled_esm(client: TestClient, world):
    uuid = LambdaTestClient(client).get_esm_uuid()
    r = client.delete(f"/2015-03-31/event-source-mappings/{uuid}")
    if r.status_code < 300:
        world["result"] = r.json() if r.content else {}
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}
