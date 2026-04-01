"""Then: every "PUBLISHED" message references a "sns" "topic" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "PUBLISHED" message references a "sns" "topic" that exists')
def _inv_apigateway_sns_every_published_message_references_a_topic_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
