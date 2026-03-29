"""Given: a confirmed subscription exists for the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given

from ..client import SnsTestClient
from ..constants import TEST_SUB_ENDPOINT


@given("a confirmed subscription exists for the topic")
def confirmed_subscription_exists(client, world):
    """Subscribe via SQS ARN endpoint which is auto-confirmed in lws."""
    if not world.get("topic_arn"):
        world["topic_arn"] = SnsTestClient(client).create_topic()
    sub_arn = SnsTestClient(client).subscribe(
        topic_arn=world["topic_arn"], protocol="sqs", endpoint=TEST_SUB_ENDPOINT
    )
    if sub_arn == "PendingConfirmation":
        pytest.skip("SQS subscription not auto-confirmed in this lws version")
    world["subscription_arn"] = sub_arn
