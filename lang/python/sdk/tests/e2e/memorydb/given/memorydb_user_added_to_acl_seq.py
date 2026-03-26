"""Given: a user has been added to an "ACL" """

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('a user has been added to an "ACL"')
def memorydb_user_added_to_acl_seq(lws_session):
    MemorydbTestClient(lws_session).create_user()
    MemorydbTestClient(lws_session).create_acl()
