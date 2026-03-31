"""Then: the "sns" "message" will be published to the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "sns" "message" will be published to the "sns" "topic"')
def message_published_to_topic(world):
    pytest.skip("Cannot observe Lambda SNS publish result in lws")
