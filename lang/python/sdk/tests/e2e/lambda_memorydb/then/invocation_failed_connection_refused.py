"""Then: the "lambda" "invocation" will be "FAILED" with a connection refused error"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "invocation" will be "FAILED" with a connection refused error')
def invocation_failed_connection_refused(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")
