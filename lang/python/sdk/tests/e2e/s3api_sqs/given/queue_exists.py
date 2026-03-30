"""Given: the queue exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given("the queue exists")
def queue_exists(lws_session):
    S3apiSqsTestClient(lws_session).create_queue()
