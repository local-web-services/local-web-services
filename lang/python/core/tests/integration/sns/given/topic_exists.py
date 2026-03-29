"""Given: the topic exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient


@given("the topic exists")
def topic_exists(client, world):
    world["topic_arn"] = SnsTestClient(client).create_topic()
