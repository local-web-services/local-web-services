"""Given: an execution is "RUNNING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an execution is "RUNNING"')
def apigw_sfn_execution_is_running():
    pytest.skip("Cannot simulate running execution state in lws")
