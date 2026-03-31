"""When: a tag is removed from a "lambda" "function" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_ARN, INT_TAG_KEY


@when('a tag is removed from a "lambda" "function"')
def remove_tag_from_function(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.delete(
        f"/2015-03-31/tags/{INT_FUNCTION_ARN}",
        params={"tagKeys": INT_TAG_KEY},
    )
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 204 else r.json()
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}
