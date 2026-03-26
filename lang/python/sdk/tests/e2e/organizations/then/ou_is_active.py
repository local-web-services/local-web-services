"""Then: the organizational unit is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import OrganizationsTestClient


@then('the organizational unit is "ACTIVE"')
def ou_is_active(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected CreateOrganizationalUnit to succeed but got: {world['error']}"
    ou_id = world["ou_id"]
    ou_resp = OrganizationsTestClient(lws_session).describe_organizational_unit(
        OrganizationalUnitId=ou_id
    )
    actual_id = ou_resp["OrganizationalUnit"]["Id"]
    assert actual_id is not None, f"Expected OU Id to be set but got None for ou_id={ou_id}"
