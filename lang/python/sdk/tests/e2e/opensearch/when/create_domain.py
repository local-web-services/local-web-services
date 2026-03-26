"""When: a search domain is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when("a search domain is created")
def create_domain(lws_session, world):
    try:
        world["result"] = lws_session.client("opensearch").create_domain(DomainName=TEST_DOMAIN)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
