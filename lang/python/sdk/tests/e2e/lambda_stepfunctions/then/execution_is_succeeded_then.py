"""Then: the "step functions" "execution" will be "SUCCEEDED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "step functions" "execution" will be "SUCCEEDED"')
def execution_is_succeeded_then(world):
    pytest.skip("Cannot observe internal execution completion in lws")
