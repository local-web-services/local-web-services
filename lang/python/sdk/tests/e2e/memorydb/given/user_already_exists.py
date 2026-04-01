"""Given: the "memorydb" "user" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('the "memorydb" "user" already existed')
def user_already_exists(lws_session):
    MemorydbTestClient(lws_session).create_user()
