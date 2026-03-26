"""Given: an "ACL" has been updated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('an "ACL" has been updated')
def memorydb_acl_updated_seq(lws_session):
    MemorydbTestClient(lws_session).create_acl()
