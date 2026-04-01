"""Given: the "neptune" "cluster" was "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given('the "neptune" "cluster" was "STOPPED"')
def cluster_is_stopped_given(lws_session, world):
    LambdaNeptuneTestClient(lws_session).create_cluster()
