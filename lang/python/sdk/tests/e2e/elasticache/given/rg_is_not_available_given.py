"""Given: the "elasticache" "replication group" was not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('the "elasticache" "replication group" was not "AVAILABLE"')
def rg_is_not_available_given(lws_session):
    lws_session.lifecycle("elasticache").create_dwell_ms(5000).apply()
    ElasticacheTestClient(lws_session).create_replication_group()
