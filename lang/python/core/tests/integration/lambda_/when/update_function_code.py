"""When: a "lambda" "function"'s code is updated"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@when('a "lambda" "function"\'s code is updated')
def update_function_code(client: TestClient, world):
    r = client.put(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/code",
        json={"ZipFile": ""},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
