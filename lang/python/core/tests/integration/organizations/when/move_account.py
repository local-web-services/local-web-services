"""When: an account is moved to a new parent"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when("an account is moved to a new parent")
def move_account(client: TestClient, world):
    status, body = OrganizationsTestClient(client).post(
        "MoveAccount",
        {
            "AccountId": world["account_id"],
            "SourceParentId": world["source_parent_id"],
            "DestinationParentId": world["dest_parent_id"],
        },
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body
