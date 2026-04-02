"""When: a running "step functions" "execution" exceeds its timeout"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running "step functions" "execution" exceeds its timeout')
def execution_timeout(world):
    pytest.skip("Cannot trigger execution timeout programmatically")
