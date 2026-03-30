"""Given: the domain is "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient
from ..constants import TEST_DOMAIN


@given('the domain is "CREATING"')
def domain_is_creating_given(lws_session):
    try:
        ElasticsearchTestClient(lws_session).delete_elasticsearch_domain(DomainName=TEST_DOMAIN)
    except Exception:
        pass
    lws_session.lifecycle("es").create_dwell_ms(5000).apply()
    ElasticsearchTestClient(lws_session).create_domain()
