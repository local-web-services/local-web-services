"""Given: the cluster is not "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsNeptuneTestClient


@given('the cluster is not "STOPPED"')
def cluster_is_not_stopped_given(lws_session):
    StepfunctionsNeptuneTestClient(lws_session).create_cluster()
