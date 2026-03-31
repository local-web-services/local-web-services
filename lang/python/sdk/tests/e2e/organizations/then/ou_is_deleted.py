"""Then: the "organizations" "organizational unit" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "organizations" "organizational unit" will be "DELETED"')
def ou_is_deleted(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected DeleteOrganizationalUnit to succeed but got: {world['error']}"
    ou_id = world["ou_id"]
    parent_id = world.get("parent_id") or world.get("root_id")
    list_resp = lws_session.client("organizations").list_organizational_units_for_parent(
        ParentId=parent_id
    )
    actual_ou_ids = [ou["Id"] for ou in list_resp.get("OrganizationalUnits", [])]
    assert (
        ou_id not in actual_ou_ids
    ), f"Expected OU '{ou_id}' to be deleted but found in: {actual_ou_ids}"
