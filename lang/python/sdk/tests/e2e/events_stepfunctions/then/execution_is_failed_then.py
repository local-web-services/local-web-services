"""Then: the "step functions" "execution" will be "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "step functions" "execution" will be "FAILED"')
def execution_is_failed_then(world):
    pytest.skip("Cannot observe internal execution failure in lws")
