"""When: a Lambda event source mapping is created linking a queue to a function"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a Lambda event source mapping is created linking a queue to a function")
def create_event_source_mapping(world):
    pytest.skip("Cannot create event source mapping in lws")
