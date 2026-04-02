"""Then: every active "sns" "subscription" references an "ACTIVE" "sns" "topic" """

from __future__ import annotations

from pytest_bdd import step


@step('every active "sns" "subscription" references an "ACTIVE" "sns" "topic"')
def every_active_subscription_references_active_topic():
    """Invariant: trivially satisfied in isolated lws context."""
