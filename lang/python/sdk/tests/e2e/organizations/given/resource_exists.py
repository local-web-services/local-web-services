"""Given: the "organizations" resource existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('the "organizations" resource existed')
def resource_exists(lws_session, world):
    # Arrange / Act
    client = OrganizationsTestClient(lws_session)
    client.create_org()
    resp = client._client.list_roots()
    root_id = resp.get("Roots", [{}])[0].get("Id", "")

    # Assert
    world["resource_id"] = root_id
