"""Given: an "ACL" has been associated with a cluster"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('an "ACL" has been associated with a cluster')
def memorydb_acl_associated_with_cluster_seq(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
    MemorydbTestClient(lws_session).create_acl()
