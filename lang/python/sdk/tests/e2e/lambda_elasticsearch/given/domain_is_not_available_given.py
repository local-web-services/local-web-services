"""Given: the domain is not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticsearchTestClient
from ..constants import TEST_DOMAIN


@given('the domain is not "AVAILABLE"')
def domain_is_not_available_given(lws_session, world):
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
