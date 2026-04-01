"""When: a "sns" "message" is published to a "sns" "topic" """

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_MESSAGE, TEST_TOPIC_ARN


@when('a "sns" "message" is published to a "sns" "topic"')
def publish_to_topic(client, world):
    topic_arn = world.get("topic_arn", TEST_TOPIC_ARN)
    r = client.post(
        "/",
        data={
            "Action": "Publish",
            "TopicArn": topic_arn,
            "Message": TEST_MESSAGE,
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
