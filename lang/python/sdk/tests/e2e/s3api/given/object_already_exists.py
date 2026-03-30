"""Given: the object already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given("the object already exists")
def object_already_exists(lws_session):
    S3apiTestClient(lws_session).put_object()
