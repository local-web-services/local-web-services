"""Then: the organizational unit is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@then('the organizational unit is "ACTIVE"')
def ou_is_active(client: TestClient, world):
    actual_create_error = world["error"]
    assert (
        actual_create_error is None
    ), f"Expected CreateOrganizationalUnit to succeed but got: {actual_create_error}"
    ou_id = world["ou_id"]
    _, ou_body = OrganizationsTestClient(client).post(
        "DescribeOrganizationalUnit", {"OrganizationalUnitId": ou_id}
    )
    actual_id = ou_body.get("OrganizationalUnit", {}).get("Id")
    assert actual_id is not None, f"Expected OU Id to be set but got None for ou_id={ou_id}"
