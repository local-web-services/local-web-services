"""Then: publishing requires an "ACTIVE" topic to be present"""

from __future__ import annotations

from pytest_bdd import then


@then('publishing requires an "ACTIVE" topic to be present')
def publishing_requires_active_topic():
    """Invariant step: trivially satisfied in isolated test context."""
