"""Then: the "lambda" "function" active execution count will increase"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "function" active execution count will increase')
def active_execution_count_increases(world):
    pytest.skip("Cannot observe Lambda execution count changes in lws")
