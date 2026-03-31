"""Given: the "memorydb" "cluster" was not "UPDATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsMemorydbTestClient


@given('the "memorydb" "cluster" was not "UPDATING"')
def cluster_is_not_updating_given(lws_session):
    StepfunctionsMemorydbTestClient(lws_session).create_cluster()
