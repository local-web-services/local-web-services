"""Then: the document "EXISTS" and the invocation is "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the document "EXISTS" and the invocation is "SUCCESS"')
def document_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda document write result in lws")
