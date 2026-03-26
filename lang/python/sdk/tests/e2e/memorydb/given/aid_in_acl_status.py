"""Given: aid in acl_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("aid in acl_status")
def aid_in_acl_status(lws_session):
    MemorydbTestClient(lws_session).create_acl()
