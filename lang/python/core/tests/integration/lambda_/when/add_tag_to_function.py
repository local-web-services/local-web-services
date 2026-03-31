"""When: a tag is added to a "lambda" "function" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_ARN, INT_TAG_KEY, INT_TAG_VALUE


@when('a tag is added to a "lambda" "function"')
def add_tag_to_function(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.post(
        f"/2015-03-31/tags/{INT_FUNCTION_ARN}",
        json={"Tags": {INT_TAG_KEY: INT_TAG_VALUE}},
    )
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 204 else r.json()
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}
