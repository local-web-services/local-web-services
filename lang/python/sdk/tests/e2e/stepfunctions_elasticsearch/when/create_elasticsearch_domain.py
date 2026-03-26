"""When: an Elasticsearch domain is created and becomes "AVAILABLE" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsElasticsearchTestClient
from ..constants import TEST_DOMAIN


@when('an Elasticsearch domain is created and becomes "AVAILABLE"')
def create_elasticsearch_domain(lws_session, world):
    try:
        resp = StepfunctionsElasticsearchTestClient(lws_session)._es.create_elasticsearch_domain(
            DomainName=TEST_DOMAIN
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
