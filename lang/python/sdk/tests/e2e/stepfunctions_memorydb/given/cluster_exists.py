"""Given: the cluster exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsMemorydbTestClient


@given("the cluster exists")
def cluster_exists(lws_session):
    StepfunctionsMemorydbTestClient(lws_session).create_cluster()
