"""When: a "SNS" notification is configured on the "elasticache" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "SNS" notification is configured on the "elasticache" "cluster"')
def configure_notification(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache SNS notification configuration in lws")
