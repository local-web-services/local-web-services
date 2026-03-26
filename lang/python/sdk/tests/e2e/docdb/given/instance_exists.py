"""Given: the instance exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given("the instance exists")
def instance_exists(lws_session):
    DocdbTestClient(lws_session).create_cluster()
    DocdbTestClient(lws_session).create_instance()
