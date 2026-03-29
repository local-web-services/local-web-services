"""Then: the invocation is "SUCCESS" and the "SQS" message is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "SUCCESS" and the "SQS" message is "DELETED"')
def invocation_success_message_deleted(world):
    pytest.skip("Cannot observe Lambda invocation result in lws")
