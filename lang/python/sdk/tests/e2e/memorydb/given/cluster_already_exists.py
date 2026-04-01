"""Given: the "memorydb" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('the "memorydb" "cluster" already existed')
def cluster_already_exists(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
