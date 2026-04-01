"""Given: the "memorydb" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsMemorydbTestClient


@given('the "memorydb" "cluster" already existed')
def cluster_already_exists(lws_session):
    StepfunctionsMemorydbTestClient(lws_session).create_cluster()
