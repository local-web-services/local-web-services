"""Given: the "memorydb" "cluster" was not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaMemorydbTestClient


@given('the "memorydb" "cluster" was not "AVAILABLE"')
def cluster_is_not_available_given(lws_session, world):
    LambdaMemorydbTestClient(lws_session).create_cluster()
