"""Given: an "sns" publish task is configured on the "step functions" "state machine" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "sns" publish task is configured on the "step functions" "state machine"')
def sns_publish_task_configured_given():
    pytest.skip("Cannot pre-set an SNS task configuration state for sequence setup")
