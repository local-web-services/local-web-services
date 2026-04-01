"""Given: the "sns" "topic" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSnsTestClient


@given('the "sns" "topic" existed')
def topic_exists(lws_session):
    StepfunctionsSnsTestClient(lws_session).create_topic()
