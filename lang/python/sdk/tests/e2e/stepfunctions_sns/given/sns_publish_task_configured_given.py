"""Given: a "SNS" publish task is configured on the state machine"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "SNS" publish task is configured on the state machine')
def sns_publish_task_configured_given():
    pytest.skip("Cannot pre-set an SNS task configuration state for sequence setup")
