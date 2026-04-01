"""Given: a "sqs" "queue" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given('a "sqs" "queue" is created')
def s3api_sqs_sqs_queue_has_been_created(lws_session):
    S3apiSqsTestClient(lws_session).create_queue()
