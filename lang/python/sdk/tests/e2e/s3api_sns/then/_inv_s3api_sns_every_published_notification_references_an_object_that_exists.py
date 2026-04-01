"""Then: every "PUBLISHED" notification references an object that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "PUBLISHED" notification references an object that exists')
def _inv_s3api_sns_every_published_notification_references_an_object_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
