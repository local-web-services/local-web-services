"""Then: the message is published to the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the message is published to the topic")
def message_published_to_topic(world):
    pytest.skip("Cannot observe Lambda SNS publish result in lws")
