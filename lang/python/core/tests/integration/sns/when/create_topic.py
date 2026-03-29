"""When: an "SNS" topic is created"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TOPIC, _extract_xml_tag


@when('an "SNS" topic is created')
def create_topic(client, world):
    r = client.post("/", data={"Action": "CreateTopic", "Name": TEST_TOPIC})
    if r.status_code == 200:
        world["result"] = r.text
        world["topic_arn"] = _extract_xml_tag(r.text, "TopicArn")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
