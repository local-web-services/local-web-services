"""Then: the "glacier" "archive" will exist in the "glacier" "vault" and the invocation will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "glacier" "archive" will exist in the "glacier" "vault" and the invocation will be "SUCCESS"'
)
def archive_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda archive upload result in lws")
