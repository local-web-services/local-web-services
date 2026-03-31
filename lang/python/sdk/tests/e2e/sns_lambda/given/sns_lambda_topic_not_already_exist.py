"""Given: the topic did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the topic did not already exist")
def sns_lambda_topic_not_already_exist():
    """No-op: fresh state has no topics."""
