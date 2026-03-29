"""Then: the execution is "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution is "FAILED"')
def execution_is_failed_then(world):
    pytest.skip("Cannot observe internal execution failure in lws")
