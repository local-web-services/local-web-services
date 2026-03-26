"""Given: a user has been updated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("a user has been updated")
def memorydb_user_updated_seq(lws_session):
    MemorydbTestClient(lws_session).create_user()
