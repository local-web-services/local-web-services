"""Given: a Lambda task is configured on the state machine"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a Lambda task is configured on the state machine")
def lambda_task_has_been_configured_given():
    pytest.skip("Cannot pre-set a Lambda task configuration state for sequence setup")
