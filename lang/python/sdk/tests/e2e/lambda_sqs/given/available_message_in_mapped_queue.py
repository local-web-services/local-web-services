"""Given: an "AVAILABLE" message exists in the mapped queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "AVAILABLE" message exists in the mapped queue')
def available_message_in_mapped_queue():
    pytest.skip("Cannot set up event source mapping in lws")
