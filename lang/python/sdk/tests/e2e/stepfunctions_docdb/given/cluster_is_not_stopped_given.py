"""Given: the cluster is not "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDocdbTestClient


@given('the cluster is not "STOPPED"')
def cluster_is_not_stopped_given(lws_session):
    StepfunctionsDocdbTestClient(lws_session).create_cluster()
