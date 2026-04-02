"""When: "ListTagsForResource" is called with the account id"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import OrganizationsTestClient


@when('"ListTagsForResource" is called with the account id')
def list_tags_for_resource_with_account_id(lws_session, world):
    try:
        resp = OrganizationsTestClient(lws_session).list_tags_for_resource(world["account_id"])
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
