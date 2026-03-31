"""Given: the "documentdb" "cluster" was not "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDocdbTestClient


@given('the "documentdb" "cluster" was not "STOPPED"')
def cluster_is_not_stopped_given(lws_session):
    StepfunctionsDocdbTestClient(lws_session).create_cluster()
