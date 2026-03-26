"""Then: the organizational unit is "DELETED" """

from __future__ import annotations

from pytest_bdd import then

from ..client import OrganizationsTestClient


@then('the organizational unit is "DELETED"')
def ou_is_deleted(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected DeleteOrganizationalUnit to succeed but got: {world['error']}"
    ou_id = world["ou_id"]
    parent_id = world.get("parent_id") or world.get("root_id")
    list_resp = OrganizationsTestClient(lws_session).list_organizational_units_for_parent(
        ParentId=parent_id
    )
    actual_ou_ids = [ou["Id"] for ou in list_resp.get("OrganizationalUnits", [])]
    assert (
        ou_id not in actual_ou_ids
    ), f"Expected OU '{ou_id}' to be deleted but found in: {actual_ou_ids}"
