"""Given: the "sqs" "queue" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given('the "sqs" "queue" existed')
def queue_exists(lws_session):
    S3apiSqsTestClient(lws_session).create_queue()
