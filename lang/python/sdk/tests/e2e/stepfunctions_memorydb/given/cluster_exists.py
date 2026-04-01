"""Given: the "memorydb" "cluster" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsMemorydbTestClient


@given('the "memorydb" "cluster" existed')
def cluster_exists(lws_session):
    StepfunctionsMemorydbTestClient(lws_session).create_cluster()
