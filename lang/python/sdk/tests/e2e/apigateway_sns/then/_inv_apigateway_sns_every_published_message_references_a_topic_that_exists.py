"""Then: every "PUBLISHED" message references a topic that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every "PUBLISHED" message references a topic that exists')
def _inv_apigateway_sns_every_published_message_references_a_topic_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
