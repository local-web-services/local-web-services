"""When: an "organizations" "organization" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when('an "organizations" "organization" is created')
def create_organization(lws_session, world):
    try:
        resp = lws_session.client("organizations").create_organization(FeatureSet="ALL")
        world["result"] = resp
        world["org_id"] = resp["Organization"]["Id"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
