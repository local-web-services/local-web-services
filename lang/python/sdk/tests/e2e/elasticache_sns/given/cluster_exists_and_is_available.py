"""Given: the "elasticache" "cluster" existed and was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheSnsTestClient


@given('the "elasticache" "cluster" existed and was "AVAILABLE"')
def cluster_exists_and_is_available(lws_session):
    ElasticacheSnsTestClient(lws_session).create_cluster()
