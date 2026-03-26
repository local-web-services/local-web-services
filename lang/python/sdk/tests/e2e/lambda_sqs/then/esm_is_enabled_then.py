"""Then: the event source mapping is "ENABLED" and will poll the queue for messages"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the event source mapping is "ENABLED" and will poll the queue for messages')
def esm_is_enabled_then(world):
    pytest.skip("Cannot observe event source mapping state in lws")
