"""When: the Glacier job completes but notification delivery fails because the topic was deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Glacier job completes but notification delivery fails because the topic was deleted")
def glacier_job_completes_notification_fails(world):
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")
