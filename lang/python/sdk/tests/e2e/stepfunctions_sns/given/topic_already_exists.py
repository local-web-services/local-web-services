"""Given: the topic already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSnsTestClient


@given("the topic already exists")
def topic_already_exists(lws_session):
    StepfunctionsSnsTestClient(lws_session).create_topic()
