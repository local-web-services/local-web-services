"""Given: the "elasticache" "cluster" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticacheTestClient


@given('the "elasticache" "cluster" existed')
def cluster_exists(lws_session):
    StepfunctionsElasticacheTestClient(lws_session).create_cluster()
