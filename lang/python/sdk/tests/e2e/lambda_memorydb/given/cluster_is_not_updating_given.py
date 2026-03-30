"""Given: the cluster is not "UPDATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaMemorydbTestClient


@given('the cluster is not "UPDATING"')
def cluster_is_not_updating_given(lws_session):
    LambdaMemorydbTestClient(lws_session).create_cluster()
