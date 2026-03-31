"""When: an "organizations" "organizational unit" is created under a parent"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_OU_NAME


@when('an "organizations" "organizational unit" is created under a parent')
def create_organizational_unit(lws_session, world):
    try:
        parent_id = world.get("parent_id") or world.get("root_id")
        resp = lws_session.client("organizations").create_organizational_unit(
            ParentId=parent_id, Name=TEST_OU_NAME
        )
        world["result"] = resp
        world["ou_id"] = resp["OrganizationalUnit"]["Id"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
