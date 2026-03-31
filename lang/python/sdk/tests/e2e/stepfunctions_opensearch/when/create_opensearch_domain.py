"""When: an "opensearch" "domain" is created and becomes "ACTIVE" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when('an "opensearch" "domain" is created and becomes "ACTIVE"')
def create_opensearch_domain(lws_session, world):
    try:
        resp = lws_session.client("opensearch").create_domain(DomainName=TEST_DOMAIN)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
