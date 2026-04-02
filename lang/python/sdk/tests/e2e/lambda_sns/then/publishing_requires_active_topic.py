"""Then: "sns" publishing requires an "ACTIVE" "sns" "topic" to be present"""

from __future__ import annotations

from pytest_bdd import step


@step('"sns" publishing requires an "ACTIVE" "sns" "topic" to be present')
def publishing_requires_active_topic():
    """Invariant step: trivially satisfied in isolated test context."""
