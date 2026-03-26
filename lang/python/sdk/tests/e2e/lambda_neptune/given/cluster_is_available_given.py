"""Given: the cluster is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given('the cluster is "AVAILABLE"')
def cluster_is_available_given(lws_session):
    LambdaNeptuneTestClient(lws_session).create_cluster()
