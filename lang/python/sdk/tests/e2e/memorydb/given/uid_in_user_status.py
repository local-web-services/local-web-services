"""Given: uid in user_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("uid in user_status")
def uid_in_user_status(lws_session):
    MemorydbTestClient(lws_session).create_user()
