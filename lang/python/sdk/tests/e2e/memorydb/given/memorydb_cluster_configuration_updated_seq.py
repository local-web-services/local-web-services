"""Given: a "memorydb" "cluster" configuration is updated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('a "memorydb" "cluster" configuration is updated')
def memorydb_cluster_configuration_updated_seq(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
