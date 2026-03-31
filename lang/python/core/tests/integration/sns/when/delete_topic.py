"""When: a "sns" "topic" is deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TOPIC_ARN


@when('a "sns" "topic" is deleted')
def delete_topic(client, world):
    topic_arn = world.get("topic_arn", TEST_TOPIC_ARN)
    r = client.post("/", data={"Action": "DeleteTopic", "TopicArn": topic_arn})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
