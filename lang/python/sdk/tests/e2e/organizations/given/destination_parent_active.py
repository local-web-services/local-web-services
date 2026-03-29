"""Given: the destination parent is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('the destination parent is "ACTIVE"')
def destination_parent_active(lws_session, world):
    world["dest_parent_id"] = OrganizationsTestClient(lws_session).create_ou(
        world["root_id"], "e2e-test-dest-ou-1"
    )
