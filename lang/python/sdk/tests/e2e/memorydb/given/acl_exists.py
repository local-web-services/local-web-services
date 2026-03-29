"""Given: the "ACL" exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('the "ACL" exists')
def acl_exists(lws_session):
    MemorydbTestClient(lws_session).create_acl()
