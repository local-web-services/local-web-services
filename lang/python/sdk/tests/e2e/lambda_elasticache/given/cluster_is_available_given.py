"""Given: the "elasticache" "cluster" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticacheTestClient


@given('the "elasticache" "cluster" was "AVAILABLE"')
def cluster_is_available_given(lws_session):
    LambdaElasticacheTestClient(lws_session).create_cluster()
