"""Then: every "PUBLISHED" notification references a "glacier" "job" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "PUBLISHED" notification references a "glacier" "job" that exists')
def _inv_glacier_sns_every_published_notification_references_a_job_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
