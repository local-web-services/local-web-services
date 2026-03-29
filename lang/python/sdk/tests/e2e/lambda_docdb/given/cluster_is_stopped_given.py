"""Given: the cluster is "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDocdbTestClient


@given('the cluster is "STOPPED"')
def cluster_is_stopped_given(lws_session, world):
    LambdaDocdbTestClient(lws_session).create_cluster()
