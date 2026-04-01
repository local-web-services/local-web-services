"""Then: the "elasticache" "cluster" will publish lifecycle events to the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticache" "cluster" will publish lifecycle events to the "sns" "topic"')
def cluster_will_publish_lifecycle_events():
    pytest.skip("Cannot observe internal ElastiCache SNS notification configuration in lws")
