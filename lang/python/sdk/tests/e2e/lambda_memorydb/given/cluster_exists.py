"""Given: the cluster exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaMemorydbTestClient


@given("the cluster exists")
def cluster_exists(lws_session):
    LambdaMemorydbTestClient(lws_session).create_cluster()
