"""Given: the target topic is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the target topic is not "DELETED"')
def apigw_sns_target_topic_is_not_deleted():
    """No-op: topics are not DELETED by default."""
