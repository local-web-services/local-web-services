"""Given: the "ACL" already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('the "ACL" already exists')
def acl_already_exists(lws_session):
    MemorydbTestClient(lws_session).create_acl()
