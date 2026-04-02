"""Given: the "cloudtrail" "event" was "BUFFERED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient
from ..constants import TEST_SQS_QUEUE


@given('the "cloudtrail" "event" was "BUFFERED"')
def the_cloudtrail_event_was_buffered(lws_session, world):
    # Arrange
    CloudtrailTestClient(lws_session).create_trail()
    CloudtrailTestClient(lws_session).start_logging()

    # Act — make an API call to trigger event capture
    lws_session.client("sqs").create_queue(QueueName=f"{TEST_SQS_QUEUE}-buf")
    world["event_buffered"] = True
