"""Given: an "ACL" has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('an "ACL" has been created')
def memorydb_acl_created_seq(lws_session):
    MemorydbTestClient(lws_session).create_acl()
