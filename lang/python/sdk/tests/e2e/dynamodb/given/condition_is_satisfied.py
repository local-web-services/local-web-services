"""Given: the condition is satisfied"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("the condition is satisfied")
def condition_is_satisfied(lws_session):
    DynamodbTestClient(lws_session).put_item()
