"""Given: qid in queue_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given("qid in queue_status")
def s3api_sqs_qid_in_queue_status(lws_session):
    S3apiSqsTestClient(lws_session).create_queue()
