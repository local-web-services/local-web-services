"""Given: the "memorydb" "ACL" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('the "memorydb" "ACL" existed')
def acl_exists(lws_session):
    MemorydbTestClient(lws_session).create_acl()
