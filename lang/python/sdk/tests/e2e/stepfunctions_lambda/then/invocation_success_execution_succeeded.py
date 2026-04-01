"""Then: the invocation will be "SUCCESS" and the "step functions" "execution" will be "SUCCEEDED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation will be "SUCCESS" and the "step functions" "execution" will be "SUCCEEDED"')
def invocation_success_execution_succeeded():
    pytest.skip("Cannot observe internal Lambda invocation success in lws")
