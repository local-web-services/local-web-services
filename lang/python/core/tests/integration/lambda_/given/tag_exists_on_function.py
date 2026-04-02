"""Given: the tag existed on the "lambda" "function" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient
from ..constants import INT_FUNCTION_ARN, INT_TAG_KEY, INT_TAG_VALUE


@given('the tag existed on the "lambda" "function"')
def tag_exists_on_function(client: TestClient):
    LambdaTestClient(client).create_function()
    client.post(
        f"/2015-03-31/tags/{INT_FUNCTION_ARN}",
        json={"Tags": {INT_TAG_KEY: INT_TAG_VALUE}},
    )
