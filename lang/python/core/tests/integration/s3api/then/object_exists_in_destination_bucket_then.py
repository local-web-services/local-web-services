"""Then: the object "EXISTS" in the destination bucket"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY2


@then('the object "EXISTS" in the destination bucket')
def object_exists_in_destination_bucket_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}", params={"list-type": "2"})
    actual_body = r.text
    expected_key = INT_KEY2
    assert (
        expected_key in actual_body
    ), f"Expected copied key '{expected_key}' in destination bucket but got: {actual_body}"
