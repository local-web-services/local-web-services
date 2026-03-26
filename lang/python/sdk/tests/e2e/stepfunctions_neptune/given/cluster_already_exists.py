"""Given: the cluster already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsNeptuneTestClient


@given("the cluster already exists")
def cluster_already_exists(lws_session):
    StepfunctionsNeptuneTestClient(lws_session).create_cluster()
