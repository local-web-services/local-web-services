"""Then: the execution is "FAILED" and the request is "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution is "FAILED" and the request is "FAILED"')
def execution_failed_request_failed():
    pytest.skip("Cannot simulate Step Functions execution failure via API Gateway in lws")
