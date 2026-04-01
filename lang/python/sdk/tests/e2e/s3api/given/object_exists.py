"""Given: the object exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given("the object exists")
def object_exists(lws_session):
    S3apiTestClient(lws_session).put_object()
