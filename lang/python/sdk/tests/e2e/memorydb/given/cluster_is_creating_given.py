"""Given: the "memorydb" "cluster" was "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('the "memorydb" "cluster" was "CREATING"')
def cluster_is_creating_given(lws_session):
    lws_session.lifecycle("memorydb").create_dwell_ms(5000).apply()
    MemorydbTestClient(lws_session).create_cluster()
