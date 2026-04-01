"""Then: the "api gateway" "integration" times out or responds non-deterministically"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "api gateway" "integration" times out or responds non-deterministically')
def integration_times_out_or_responds(world):
    pytest.skip("Cannot verify integration timeout behaviour in this context")
