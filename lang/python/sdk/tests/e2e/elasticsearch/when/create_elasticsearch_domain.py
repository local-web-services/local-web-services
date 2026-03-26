"""When: a search domain is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ElasticsearchTestClient
from ..constants import TEST_DOMAIN


@when("a search domain is created")
def create_elasticsearch_domain(lws_session, world):
    try:
        world["result"] = ElasticsearchTestClient(lws_session).create_elasticsearch_domain(
            DomainName=TEST_DOMAIN
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
