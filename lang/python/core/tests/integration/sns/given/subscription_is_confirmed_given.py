"""Given: the "sns" "subscription" will be "CONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import given

from ..client import SnsTestClient
from ..constants import TEST_SUB_ENDPOINT


@given('the "sns" "subscription" was "CONFIRMED"')
@given('the "sns" "subscription" will be "CONFIRMED"')
def subscription_is_confirmed_given(client, world):
    """Set up a confirmed SQS subscription (auto-confirmed in lws)."""
    if not world.get("topic_arn"):
        world["topic_arn"] = SnsTestClient(client).create_topic()
    sub_arn = SnsTestClient(client).subscribe(
        topic_arn=world["topic_arn"], protocol="sqs", endpoint=TEST_SUB_ENDPOINT
    )
    if sub_arn == "PendingConfirmation":
        pytest.skip("SQS subscription not auto-confirmed in this lws version")
    world["subscription_arn"] = sub_arn
