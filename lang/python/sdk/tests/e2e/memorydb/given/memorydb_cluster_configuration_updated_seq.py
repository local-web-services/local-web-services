"""Given: a MemoryDB cluster configuration has been updated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("a MemoryDB cluster configuration has been updated")
def memorydb_cluster_configuration_updated_seq(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
