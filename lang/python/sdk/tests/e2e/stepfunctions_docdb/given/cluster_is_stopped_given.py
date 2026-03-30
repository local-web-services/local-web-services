"""Given: the cluster is "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDocdbTestClient


@given('the cluster is "STOPPED"')
def cluster_is_stopped_given(lws_session, world):
    StepfunctionsDocdbTestClient(lws_session).create_cluster()
