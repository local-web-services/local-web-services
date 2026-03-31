"""When: an "opensearch" "domain" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaOpensearchTestClient
from ..constants import TEST_DOMAIN


@when('an "opensearch" "domain" is created')
def create_opensearch_domain(lws_session, world):
    try:
        LambdaOpensearchTestClient(lws_session).create_domain()
        world["result"] = {"DomainName": TEST_DOMAIN}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
