"""Then: the invocation will be "FAILED" and the "step functions" "execution" will be "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation will be "FAILED" and the "step functions" "execution" will be "FAILED"')
def invocation_failed_execution_failed():
    pytest.skip("Cannot observe internal Lambda invocation failure in lws")
