"""Then: the "step functions" "execution" will be "FAILED" and the request will be "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "step functions" "execution" will be "FAILED" and the request will be "FAILED"')
def execution_failed_request_failed():
    pytest.skip("Cannot simulate Step Functions execution failure via API Gateway in lws")
