"""Then: the message is "AVAILABLE" for processing"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the message is "AVAILABLE" for processing')
def message_available_for_processing(world):
    pytest.skip("Cannot observe internal message state in lws")
