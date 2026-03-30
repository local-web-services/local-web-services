"""When: an event source mapping finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an event source mapping finishes creating")
def finish_create_esm(world):
    pytest.skip("Cannot trigger ESM lifecycle transition in lws")
