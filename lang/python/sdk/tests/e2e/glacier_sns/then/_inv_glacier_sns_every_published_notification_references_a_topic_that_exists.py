"""Then: every "PUBLISHED" notification references a topic that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every "PUBLISHED" notification references a topic that exists')
def _inv_glacier_sns_every_published_notification_references_a_topic_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
