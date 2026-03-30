"""Then: the job is "SUCCEEDED" but no notification is published"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the job is "SUCCEEDED" but no notification is published')
def glacier_job_succeeded_no_notification():
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")
