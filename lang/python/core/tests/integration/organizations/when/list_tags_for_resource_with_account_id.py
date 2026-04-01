"""When: "ListTagsForResource" is called with the account id"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when('"ListTagsForResource" is called with the account id')
def list_tags_for_resource_with_account_id(client: TestClient, world):
    account_id = world["account_id"]
    status, body = OrganizationsTestClient(client).post(
        "ListTagsForResource", {"ResourceId": account_id}
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body
