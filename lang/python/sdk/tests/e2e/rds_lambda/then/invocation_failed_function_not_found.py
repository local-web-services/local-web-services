"""Then: the invocation is "FAILED" with a function not found error"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "FAILED" with a function not found error')
def invocation_failed_function_not_found():
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")
