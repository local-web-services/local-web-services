"""When: an organizational unit is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import OrganizationsTestClient


@when("an organizational unit is deleted")
def delete_organizational_unit(lws_session, world):
    try:
        resp = OrganizationsTestClient(lws_session).delete_organizational_unit(
            OrganizationalUnitId=world["ou_id"]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
