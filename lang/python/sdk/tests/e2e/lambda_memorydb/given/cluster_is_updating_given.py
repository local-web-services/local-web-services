"""Given: the cluster is "UPDATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaMemorydbTestClient


@given('the cluster is "UPDATING"')
def cluster_is_updating_given(lws_session, world):
    LambdaMemorydbTestClient(lws_session).create_cluster()
