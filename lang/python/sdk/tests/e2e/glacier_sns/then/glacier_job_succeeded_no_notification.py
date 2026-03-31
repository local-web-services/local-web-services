"""Then: the "glacier" "job" will be "SUCCEEDED" but no notification will be published"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "glacier" "job" will be "SUCCEEDED" but no notification will be published')
def glacier_job_succeeded_no_notification():
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")
