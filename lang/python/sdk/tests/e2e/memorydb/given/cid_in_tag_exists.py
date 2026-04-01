"""Given: cid in tag_exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("cid in tag_exists")
def cid_in_tag_exists(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
