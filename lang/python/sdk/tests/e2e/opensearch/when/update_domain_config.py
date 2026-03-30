"""When: a domain configuration update is requested"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when("a domain configuration update is requested")
def update_domain_config(lws_session, world):
    try:
        world["result"] = lws_session.client("opensearch").update_domain_config(
            DomainName=TEST_DOMAIN
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
