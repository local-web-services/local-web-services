"""Given: the "sns" "topic" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient


@given('the "sns" "topic" existed')
def topic_exists(client, world):
    world["topic_arn"] = SnsTestClient(client).create_topic()
