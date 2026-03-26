"""Then: the organizational unit is "DELETED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@then('the organizational unit is "DELETED"')
def ou_is_deleted(client: TestClient, world):
    actual_delete_error = world["error"]
    assert (
        actual_delete_error is None
    ), f"Expected DeleteOrganizationalUnit to succeed but got: {actual_delete_error}"
    ou_id = world["ou_id"]
    parent_id = world.get("parent_id") or world.get("root_id")
    _, list_body = OrganizationsTestClient(client).post(
        "ListOrganizationalUnitsForParent", {"ParentId": parent_id}
    )
    actual_ou_ids = [ou["Id"] for ou in list_body.get("OrganizationalUnits", [])]
    assert (
        ou_id not in actual_ou_ids
    ), f"Expected OU '{ou_id}' to be deleted but found in: {actual_ou_ids}"
