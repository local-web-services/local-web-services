"""Given: the "documentdb" "cluster" was "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDocdbTestClient


@given('the "documentdb" "cluster" was "STOPPED"')
def cluster_is_stopped_given(lws_session, world):
    LambdaDocdbTestClient(lws_session).create_cluster()
