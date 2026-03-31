"""Given: the "cognito" "user pool" has no EventBridge configuration"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user pool" has no EventBridge configuration')
def pool_has_no_eventbridge_config():
    """No-op: pools have no EventBridge configuration by default."""
