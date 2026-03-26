"""When: a domain configuration update is requested"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ElasticsearchTestClient
from ..constants import TEST_DOMAIN


@when("a domain configuration update is requested")
def update_elasticsearch_domain_config(lws_session, world):
    try:
        world["result"] = ElasticsearchTestClient(lws_session).update_elasticsearch_domain_config(
            DomainName=TEST_DOMAIN
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
