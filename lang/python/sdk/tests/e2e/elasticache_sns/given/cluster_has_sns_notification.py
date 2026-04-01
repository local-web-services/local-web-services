"""Given: the "elasticache" "cluster" has a "SNS" notification configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "cluster" has a "SNS" notification configured')
def cluster_has_sns_notification():
    pytest.skip("Cannot observe internal ElastiCache SNS notification configuration in lws")
