"""Given: the "sns" "topic" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "topic" did not exist')
def sns_lambda_topic_does_not_exist():
    """No-op: fresh state has no topics."""
