"""Given: the cluster is "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticacheTestClient


@given('the cluster is "MODIFYING"')
def cluster_is_modifying_given(lws_session, world):
    StepfunctionsElasticacheTestClient(lws_session).create_cluster()
