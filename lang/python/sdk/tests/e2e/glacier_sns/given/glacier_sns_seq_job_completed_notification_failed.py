"""
Given: the Glacier job has completed but notification delivery has failed because the topic was
deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "the Glacier job has completed but notification delivery has failed because the topic was deleted"  # noqa: E501
)
def glacier_sns_seq_job_completed_notification_failed():
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")
