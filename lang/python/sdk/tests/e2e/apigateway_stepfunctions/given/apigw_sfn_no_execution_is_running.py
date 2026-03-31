"""Given: no "step functions" "execution" was "RUNNING" """

from __future__ import annotations

from pytest_bdd import given


@given('no "step functions" "execution" was "RUNNING"')
def apigw_sfn_no_execution_is_running():
    """No-op: fresh state has no running executions."""
