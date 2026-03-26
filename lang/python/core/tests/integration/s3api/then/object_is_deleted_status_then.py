"""Then: the object is "DELETED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_KEY


@then('the object is "DELETED"')
def object_is_deleted_status_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}/{INT_KEY}")
    expected_status_code = 404
    actual_status_code = r.status_code
    assert (
        actual_status_code == expected_status_code
    ), f"Expected status {expected_status_code} for deleted object but got {actual_status_code}"
