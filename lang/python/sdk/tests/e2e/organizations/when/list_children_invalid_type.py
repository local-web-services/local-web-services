"""When: "ListChildren" is called with an invalid child type"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import OrganizationsTestClient


@when('"ListChildren" is called with an invalid child type')
def list_children_invalid_type(lws_session, world):
    try:
        resp = OrganizationsTestClient(lws_session).list_children(
            world.get("root_id", "r-0001"), "INVALID"
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
