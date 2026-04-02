"""When: an "organizations" resource is tagged"""

from __future__ import annotations

from pytest_bdd import when

from ..client import OrganizationsTestClient


@when('an "organizations" resource is tagged')
def tag_resource(lws_session, world):
    # Arrange
    resource_id = world.get("resource_id", "")

    # Act
    client = OrganizationsTestClient(lws_session)
    try:
        client._client.tag_resource(
            ResourceId=resource_id,
            Tags=[{"Key": "test-key", "Value": "test-val"}],
        )
        world["result"] = {}
        world["error"] = None
    except Exception as exc:
        world["error"] = exc
