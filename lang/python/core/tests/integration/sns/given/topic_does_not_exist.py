"""Given: the "sns" "topic" did not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_TOPIC_ARN


@given('the "sns" "topic" did not exist')
def topic_does_not_exist(client, world):
    """Ensure topic does not exist; it was never created in the fresh provider."""
    topic_arn = world.get("topic_arn", TEST_TOPIC_ARN)
    client.post("/", data={"Action": "DeleteTopic", "TopicArn": topic_arn})
