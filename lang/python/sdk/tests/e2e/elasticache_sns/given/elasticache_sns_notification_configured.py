"""Given: a "SNS" notification is configured on the "elasticache" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "SNS" notification is configured on the "elasticache" "cluster"')
def elasticache_sns_notification_configured():
    pytest.skip("Cannot configure ElastiCache SNS notification in lws")
