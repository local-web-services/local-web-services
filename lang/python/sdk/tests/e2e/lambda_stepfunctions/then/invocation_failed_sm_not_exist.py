"""Then: the invocation will be "FAILED" with a StateMachineDoesNotExist error"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation will be "FAILED" with a StateMachineDoesNotExist error')
def invocation_failed_sm_not_exist(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")
