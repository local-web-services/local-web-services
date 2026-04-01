"""Given: a user has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("a user has been created")
def memorydb_user_created_seq(lws_session):
    MemorydbTestClient(lws_session).create_user()
