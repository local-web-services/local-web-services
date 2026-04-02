"""When: "ListChildren" is called with OU child type"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import OrganizationsTestClient


@when('"ListChildren" is called with the root id and child type "ORGANIZATIONAL_UNIT"')
def list_children_ou_type(lws_session, world):
    try:
        resp = OrganizationsTestClient(lws_session).list_children(
            world["root_id"], "ORGANIZATIONAL_UNIT"
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
