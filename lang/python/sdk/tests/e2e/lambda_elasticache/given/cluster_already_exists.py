"""Given: the "elasticache" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticacheTestClient


@given('the "elasticache" "cluster" already existed')
def cluster_already_exists(lws_session):
    LambdaElasticacheTestClient(lws_session).create_cluster()
