"""When: a "lambda" "event source mapping" is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "lambda" "event source mapping" is created')
def create_event_source_mapping(lws_session, world):
    pytest.skip("Cannot create ESM in lws without a real event source ARN")
