"""When: "ListChildren" is called with account child type"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import OrganizationsTestClient


@when(
    '"ListChildren" is called with the "organizations" "organizational unit" id and child type "ACCOUNT"'
)
def list_children_account_type(lws_session, world):
    try:
        resp = OrganizationsTestClient(lws_session).list_children(world["ou_id"], "ACCOUNT")
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
