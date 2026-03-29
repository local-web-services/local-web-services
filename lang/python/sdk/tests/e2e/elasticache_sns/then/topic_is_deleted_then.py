"""Then: the topic is "DELETED" and ElastiCache event notifications will fail"""

from __future__ import annotations

from pytest_bdd import then


@then('the topic is "DELETED" and ElastiCache event notifications will fail')
def topic_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_topic to succeed but got: {world['error']}"
