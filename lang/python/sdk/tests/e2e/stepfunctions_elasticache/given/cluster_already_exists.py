"""Given: the cluster already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticacheTestClient


@given("the cluster already existed")
def cluster_already_exists(lws_session):
    StepfunctionsElasticacheTestClient(lws_session).create_cluster()
