"""Then: the upload is "COMPLETED" and the assembled object "EXISTS" in the bucket"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY


@then('the upload is "COMPLETED" and the assembled object "EXISTS" in the bucket')
def upload_completed_assembled_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}", params={"list-type": "2"})
    actual_body = r.text
    expected_key = INT_KEY
    assert (
        expected_key in actual_body
    ), f"Expected assembled object '{expected_key}' in bucket listing but got: {actual_body}"
