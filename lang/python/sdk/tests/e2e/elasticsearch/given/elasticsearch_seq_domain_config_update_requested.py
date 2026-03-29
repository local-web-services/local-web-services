"""Given: a domain configuration update has been requested"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient
from ..constants import TEST_DOMAIN


@given("a domain configuration update has been requested")
def elasticsearch_seq_domain_config_update_requested(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
    ElasticsearchTestClient(lws_session).update_elasticsearch_domain_config(
        DomainName=TEST_DOMAIN,
        ElasticsearchClusterConfig={"InstanceType": "t2.small.elasticsearch", "InstanceCount": 1},
    )
