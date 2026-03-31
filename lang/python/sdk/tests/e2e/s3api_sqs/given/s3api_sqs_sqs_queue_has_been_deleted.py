"""Given: the "sqs" "queue" is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given('the "sqs" "queue" is deleted')
def s3api_sqs_sqs_queue_has_been_deleted(lws_session):
    try:
        S3apiSqsTestClient(lws_session).create_queue()
    except Exception:
        pass
    S3apiSqsTestClient(lws_session)._sqs.delete_queue(
        QueueUrl=S3apiSqsTestClient(lws_session).queue_url()
    )
