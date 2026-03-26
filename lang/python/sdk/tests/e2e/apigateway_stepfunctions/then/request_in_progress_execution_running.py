"""Then: the request and execution are both "IN_PROGRESS" and "RUNNING" respectively"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the request and execution are both "IN_PROGRESS" and "RUNNING" respectively')
def request_in_progress_execution_running():
    pytest.skip("Cannot inspect in-progress execution state via API Gateway in lws")
