"""When: an "SNS" notification is configured on the ElastiCache cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "SNS" notification is configured on the ElastiCache cluster')
def configure_notification(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache SNS notification configuration in lws")
