"""When: a table finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a table finishes creating")
def finish_creating_table(world: dict):
    pytest.skip("Internal lifecycle transition is not triggerable in integration context")
