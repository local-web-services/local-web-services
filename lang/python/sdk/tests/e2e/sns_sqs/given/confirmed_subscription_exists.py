"""Given: no "sns" "subscription" was "CONFIRMED" for the "sns" "topic" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient


@given('a "sns" "subscription" was "CONFIRMED" for the "sns" "topic"')
@given('a confirmed subscription existed for the "sns" "topic"')
def confirmed_subscription_exists(lws_session):
    SnsSqsTestClient(lws_session).create_queue()
    SnsSqsTestClient(lws_session).subscribe_queue_to_topic()
