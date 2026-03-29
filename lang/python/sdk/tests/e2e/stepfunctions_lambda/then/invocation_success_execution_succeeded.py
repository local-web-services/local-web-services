"""Then: the invocation is "SUCCESS" and the execution is "SUCCEEDED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "SUCCESS" and the execution is "SUCCEEDED"')
def invocation_success_execution_succeeded():
    pytest.skip("Cannot observe internal Lambda invocation success in lws")
