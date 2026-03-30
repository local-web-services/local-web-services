"""Given: the subscription exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient
from ..constants import TEST_EMAIL_ENDPOINT


@given("the subscription exists")
def subscription_exists(client, world):
    if not world.get("topic_arn"):
        world["topic_arn"] = SnsTestClient(client).create_topic()
    sub_arn = SnsTestClient(client).subscribe(
        topic_arn=world["topic_arn"], protocol="email", endpoint=TEST_EMAIL_ENDPOINT
    )
    world["subscription_arn"] = sub_arn
