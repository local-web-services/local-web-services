"""When: an automatic rotation event occurs for an active "secrets manager" "secret" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an automatic rotation event occurs for an active "secrets manager" "secret"')
def rotation_event(world):
    pytest.skip("Cannot trigger automatic rotation events programmatically")
