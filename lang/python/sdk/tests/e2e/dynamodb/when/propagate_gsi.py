"""When: "GSI" propagation completes for the pending write"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('"GSI" propagation completes for the pending write')
def propagate_gsi(world):
    pytest.skip("Cannot trigger GSI propagation externally in lws")
