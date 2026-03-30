"""Then: the prod stage no longer exists"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_STAGE_PROD


@then("the prod stage no longer exists")
def prod_stage_no_longer_exists_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        return
    api_id = items[0]["id"]
    r = client.get(f"/restapis/{api_id}/stages/{INT_STAGE_PROD}")
    expected_status = 404
    actual_status = r.status_code
    assert (
        actual_status == expected_status
    ), f"Expected prod stage to be deleted (404) but got status: {actual_status}"
