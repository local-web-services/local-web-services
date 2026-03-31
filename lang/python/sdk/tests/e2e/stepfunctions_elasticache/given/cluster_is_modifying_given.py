"""Given: the "elasticache" "cluster" was "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticacheTestClient


@given('the "elasticache" "cluster" was "MODIFYING"')
def cluster_is_modifying_given(lws_session, world):
    StepfunctionsElasticacheTestClient(lws_session).create_cluster()
