"""Given: the Neptune cluster is not "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given('the Neptune cluster is not "STOPPED"')
def neptune_cluster_is_not_stopped_given(lws_session):
    LambdaNeptuneTestClient(lws_session).create_cluster()
