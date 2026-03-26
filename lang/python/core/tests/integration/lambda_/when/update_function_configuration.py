"""When: a function's configuration is updated"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@when("a function's configuration is updated")
def update_function_configuration(client: TestClient, world):
    r = client.put(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/configuration",
        json={"FunctionName": INT_FUNCTION_NAME, "Timeout": 60},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
