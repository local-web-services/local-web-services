"""Then: the active execution count increases"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the active execution count increases")
def active_execution_count_increases(world):
    pytest.skip("Cannot observe Lambda execution count changes in lws")
