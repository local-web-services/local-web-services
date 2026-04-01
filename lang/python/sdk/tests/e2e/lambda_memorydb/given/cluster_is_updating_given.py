"""Given: the "memorydb" "cluster" was "UPDATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaMemorydbTestClient


@given('the "memorydb" "cluster" was "UPDATING"')
def cluster_is_updating_given(lws_session, world):
    LambdaMemorydbTestClient(lws_session).create_cluster()
