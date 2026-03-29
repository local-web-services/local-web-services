"""When: an event source mapping finishes being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an event source mapping finishes being deleted")
def finish_delete_esm(world):
    pytest.skip("Cannot trigger ESM lifecycle transition in lws")
