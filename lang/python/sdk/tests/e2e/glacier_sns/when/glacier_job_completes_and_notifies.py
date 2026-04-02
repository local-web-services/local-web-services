"""When: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"')
def glacier_job_completes_and_notifies(world):
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")
