"""Given: an S3 log file has been written by the flush cycle"""

from __future__ import annotations

import requests
from pytest_bdd import given

from ..constants import TEST_BUCKET, TEST_SQS_QUEUE


@given("an S3 log file has been written by the flush cycle")
def an_s3_log_file_has_been_written_by_the_flush_cycle(lws_session, world):
    s3 = lws_session.client("s3")
    try:
        s3.create_bucket(Bucket=TEST_BUCKET)
    except Exception:
        pass
    sqs = lws_session.client("sqs")
    try:
        sqs.create_queue(QueueName=TEST_SQS_QUEUE)
    except Exception:  # noqa: BLE001
        pass
    try:
        base_url = lws_session.management_url.rstrip("/")
        resp = requests.post(f"{base_url}/_ldk/cloudtrail/flush", timeout=5)
        world["flush_status"] = resp.status_code
    except Exception:
        world["flush_status"] = None
