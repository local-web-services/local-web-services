"""Given: the "elasticache" "cluster" was not "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticacheTestClient


@given('the "elasticache" "cluster" was not "MODIFYING"')
def cluster_is_not_modifying_given(lws_session):
    StepfunctionsElasticacheTestClient(lws_session).create_cluster()
