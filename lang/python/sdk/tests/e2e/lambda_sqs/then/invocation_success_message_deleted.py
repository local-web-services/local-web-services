"""Then: the invocation will be "SUCCESS" and the "SQS" message will be deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation will be "SUCCESS" and the "SQS" message will be deleted')
def invocation_success_message_deleted(world):
    pytest.skip("Cannot observe Lambda invocation result in lws")
