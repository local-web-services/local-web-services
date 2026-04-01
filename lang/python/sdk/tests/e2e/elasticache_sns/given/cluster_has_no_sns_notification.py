"""Given: the "elasticache" "cluster" has no "SNS" notification configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "cluster" has no "SNS" notification configured')
def cluster_has_no_sns_notification():
    """No-op: clusters have no SNS notification configured by default."""
