"""Then: the "elasticsearch" "document" will exist and the invocation will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticsearch" "document" will exist and the invocation will be "SUCCESS"')
def document_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda document index result in lws")
