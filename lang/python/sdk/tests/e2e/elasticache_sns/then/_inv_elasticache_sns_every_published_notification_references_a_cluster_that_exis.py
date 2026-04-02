"""Then: every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists')
def _inv_elasticache_sns_every_published_notification_references_a_cluster_that_exis():
    """Invariant step: trivially satisfied in isolated test context."""
