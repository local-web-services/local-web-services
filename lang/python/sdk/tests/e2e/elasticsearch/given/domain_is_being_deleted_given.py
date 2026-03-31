"""Given: the "elasticsearch" "domain" is being deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient
from ..constants import TEST_DOMAIN


@given('the "elasticsearch" "domain" is being deleted')
def domain_is_being_deleted_given(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
    lws_session.lifecycle("es").delete_dwell_ms(5000).apply()
    lws_session.client("es").delete_elasticsearch_domain(DomainName=TEST_DOMAIN)
