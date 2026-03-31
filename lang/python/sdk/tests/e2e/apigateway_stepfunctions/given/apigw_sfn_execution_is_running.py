"""Given: a "step functions" "execution" was "RUNNING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "step functions" "execution" was "RUNNING"')
def apigw_sfn_execution_is_running():
    pytest.skip("Cannot simulate running execution state in lws")
