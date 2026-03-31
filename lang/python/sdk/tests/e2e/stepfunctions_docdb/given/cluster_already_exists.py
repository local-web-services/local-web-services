"""Given: the "documentdb" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDocdbTestClient


@given('the "documentdb" "cluster" already existed')
def cluster_already_exists(lws_session):
    StepfunctionsDocdbTestClient(lws_session).create_cluster()
