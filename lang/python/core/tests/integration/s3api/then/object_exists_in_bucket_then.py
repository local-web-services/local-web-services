"""Then: the object "EXISTS" in the bucket"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY


@then('the object "EXISTS" in the bucket')
def object_exists_in_bucket_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}", params={"list-type": "2"})
    actual_body = r.text
    expected_key = INT_KEY
    assert (
        expected_key in actual_body
    ), f"Expected object key '{expected_key}' in bucket listing but got: {actual_body}"
