"""
Given: the Glacier job has completed and published a notification to the configured "SNS" topic
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Glacier job has completed and published a notification to the configured "SNS" topic')
def glacier_sns_seq_job_completed_notification_published():
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")
