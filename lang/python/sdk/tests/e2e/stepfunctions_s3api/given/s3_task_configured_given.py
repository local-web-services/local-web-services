"""Given: an S3 task has been configured on the state machine"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an S3 task has been configured on the state machine")
def s3_task_configured_given():
    pytest.skip("Cannot pre-set an S3 task configuration state for sequence setup")
