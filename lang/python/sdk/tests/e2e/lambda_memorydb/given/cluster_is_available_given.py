"""Given: the "memorydb" "cluster" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaMemorydbTestClient


@given('the "memorydb" "cluster" was "AVAILABLE"')
def cluster_is_available_given(lws_session):
    LambdaMemorydbTestClient(lws_session).create_cluster()
