"""Given: the cluster already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaMemorydbTestClient


@given("the cluster already exists")
def cluster_already_exists(lws_session):
    LambdaMemorydbTestClient(lws_session).create_cluster()
