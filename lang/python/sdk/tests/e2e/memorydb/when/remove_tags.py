"""When: tags are removed from a "memorydb" "resource" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('tags are removed from a "memorydb" "resource"')
def remove_tags(lws_session, world):
    pytest.skip("Cannot construct MemoryDB ARN for tag operations in this context")
