"""When: "ListTagsForResource" is called with an unknown resource id"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when('"ListTagsForResource" is called with an unknown resource id')
def list_tags_for_resource_with_unknown_id(client: TestClient, world):
    status, body = OrganizationsTestClient(client).post(
        "ListTagsForResource", {"ResourceId": "unknown-resource-id"}
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body
