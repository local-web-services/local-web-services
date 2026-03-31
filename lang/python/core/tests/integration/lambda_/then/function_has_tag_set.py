"""Then: the "lambda" "function" has the tag set"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_ARN, INT_TAG_KEY


@then('the "lambda" "function" has the tag set')
def function_has_tag_set(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected tag to be added but got: {actual_error}"
    r = client.get(f"/2015-03-31/tags/{INT_FUNCTION_ARN}")
    assert (
        r.status_code == 200
    ), f"Expected to retrieve function tags but got status {r.status_code}"
    actual_tags = r.json().get("Tags", {})
    assert (
        INT_TAG_KEY in actual_tags
    ), f"Expected tag '{INT_TAG_KEY}' to be set but found tags: {actual_tags}"
