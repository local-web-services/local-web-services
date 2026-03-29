"""When: a pending transaction resolves non-deterministically"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a pending transaction resolves non-deterministically")
def resolve_pending_transaction(world):
    pytest.skip("Cannot trigger non-deterministic transaction resolution in lws")
