"""Given: the "documentdb" "cluster" was "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDocdbTestClient


@given('the "documentdb" "cluster" was "STOPPED"')
def cluster_is_stopped_given(lws_session, world):
    StepfunctionsDocdbTestClient(lws_session).create_cluster()
