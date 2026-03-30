"""Then: the invocation is "FAILED" and the execution is "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "FAILED" and the execution is "FAILED"')
def invocation_failed_execution_failed():
    pytest.skip("Cannot observe internal Lambda invocation failure in lws")
