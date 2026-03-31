"""Given: the "elasticsearch" "domain" was "PROCESSING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticsearchTestClient
from ..constants import TEST_DOMAIN


@given('the "elasticsearch" "domain" was "PROCESSING"')
def domain_is_processing_given(lws_session, world):
    try:
        LambdaElasticsearchTestClient(lws_session)._es.delete_elasticsearch_domain(
            DomainName=TEST_DOMAIN
        )
    except Exception:
        pass
    lws_session.lifecycle("es").create_dwell_ms(5000).apply()
    LambdaElasticsearchTestClient(lws_session).create_domain()
    world["result"] = None
    world["error"] = None
