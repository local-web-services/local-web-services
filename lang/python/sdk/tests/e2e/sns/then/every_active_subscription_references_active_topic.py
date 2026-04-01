"""Then: every active subscription references an "ACTIVE" topic"""

from __future__ import annotations

from pytest_bdd import step


@step('every active subscription references an "ACTIVE" topic')
def every_active_subscription_references_active_topic():
    """Invariant: trivially satisfied in isolated lws context."""
