"""Then: the "lambda" "function" active execution count will decrease"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "function" active execution count will decrease')
def active_execution_count_decreases(world):
    pytest.skip("Cannot observe Lambda execution count changes in lws")
