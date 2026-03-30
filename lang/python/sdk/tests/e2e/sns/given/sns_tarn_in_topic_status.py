"""Given: tarn in topic_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient


@given("tarn in topic_status")
def sns_tarn_in_topic_status(lws_session, world):
    world["topic_arn"] = SnsTestClient(lws_session).create_topic()
