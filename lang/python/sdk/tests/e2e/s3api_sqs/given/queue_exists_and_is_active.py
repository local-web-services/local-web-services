"""Given: the queue exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given('the queue exists and is "ACTIVE"')
def queue_exists_and_is_active(lws_session):
    S3apiSqsTestClient(lws_session).create_queue()
