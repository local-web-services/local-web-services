"""Given: the cluster is not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available_given(lws_session):
    lws_session.lifecycle("memorydb").create_dwell_ms(5000).apply()
    MemorydbTestClient(lws_session).create_cluster()
