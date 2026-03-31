"""Then: the "step functions" "execution" will be "RUNNING" and the invocation will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "step functions" "execution" will be "RUNNING" and the invocation will be "SUCCESS"')
def execution_running_invocation_success(world):
    pytest.skip("Cannot observe Lambda invocation result in lws")
