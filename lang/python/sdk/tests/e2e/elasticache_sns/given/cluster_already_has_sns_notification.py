"""Given: the cluster already has an "SNS" notification configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster already has an "SNS" notification configured')
def cluster_already_has_sns_notification():
    pytest.skip("Cannot configure SNS notification on ElastiCache cluster before test step in lws")
