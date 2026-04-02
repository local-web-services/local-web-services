"""When: an "organizations" resource is tagged"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when('an "organizations" resource is tagged')
def tag_resource(client: TestClient, world):
    # Arrange
    resource_id = world.get("resource_id", "")

    # Act
    status, body = OrganizationsTestClient(client).post(
        "TagResource",
        {"ResourceId": resource_id, "Tags": [{"Key": "test-key", "Value": "test-val"}]},
    )

    # Assert
    if status == 200:
        world["result"] = body
        world["error"] = None
    else:
        world["error"] = body
