"""Given: an "SNS" notification has been configured on the ElastiCache cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "SNS" notification has been configured on the ElastiCache cluster')
def elasticache_sns_notification_configured():
    pytest.skip("Cannot configure ElastiCache SNS notification in lws")
