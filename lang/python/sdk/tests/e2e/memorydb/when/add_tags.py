"""When: tags are added to a "memorydb" "resource" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('tags are added to a "memorydb" "resource"')
def add_tags(lws_session, world):
    pytest.skip("Cannot construct MemoryDB ARN for tag operations in this context")
