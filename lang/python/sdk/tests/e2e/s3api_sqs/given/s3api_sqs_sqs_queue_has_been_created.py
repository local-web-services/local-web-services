"""Given: an "SQS" queue has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given('an "SQS" queue has been created')
def s3api_sqs_sqs_queue_has_been_created(lws_session):
    S3apiSqsTestClient(lws_session).create_queue()
