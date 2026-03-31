"""Given: the "memorydb" "ACL" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('the "memorydb" "ACL" already existed')
def acl_already_exists(lws_session):
    MemorydbTestClient(lws_session).create_acl()
