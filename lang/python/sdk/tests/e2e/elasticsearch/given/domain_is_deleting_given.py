"""Given: the "elasticsearch" "domain" was "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient
from ..constants import TEST_DOMAIN


@given('the "elasticsearch" "domain" was "DELETING"')
def domain_is_deleting_given(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
    lws_session.lifecycle("es").delete_dwell_ms(5000).apply()
    lws_session.client("es").delete_elasticsearch_domain(DomainName=TEST_DOMAIN)
