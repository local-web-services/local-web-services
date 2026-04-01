"""Given: a prior delivery failure occurred because the bucket did not exist"""

from __future__ import annotations

import requests
from pytest_bdd import given

from ..constants import TEST_BUCKET_2, TEST_SQS_QUEUE, TEST_TRAIL


@given("a prior delivery failure occurred because the bucket did not exist")
def a_prior_delivery_failure_occurred_because_the_bucket_did_not_exist(lws_session):
    # Arrange: create a fresh trail pointing at a non-existent bucket
    ct = lws_session.client("cloudtrail")
    ct.create_trail(Name=TEST_TRAIL, S3BucketName=TEST_BUCKET_2)
    ct.start_logging(Name=TEST_TRAIL)
    sqs = lws_session.client("sqs")
    try:
        sqs.create_queue(QueueName=TEST_SQS_QUEUE)
    except Exception:  # noqa: BLE001
        pass
    try:
        base_url = lws_session.management_url.rstrip("/")
        requests.post(f"{base_url}/_ldk/cloudtrail/flush", timeout=5)
    except Exception:  # noqa: BLE001
        pass
