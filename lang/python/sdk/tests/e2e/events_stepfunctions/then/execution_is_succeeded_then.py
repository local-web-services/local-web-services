"""Then: the execution is "SUCCEEDED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then(world):
    pytest.skip("Cannot observe internal execution success in lws")
