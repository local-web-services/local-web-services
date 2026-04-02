"""Then: the "api gateway" "request" will be "IN_PROGRESS" and the "step functions" "execution" will be "RUNNING" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "api gateway" "request" will be "IN_PROGRESS" and the "step functions" "execution" will be "RUNNING"'
)
def request_in_progress_execution_running():
    pytest.skip("Cannot inspect in-progress execution state via API Gateway in lws")
