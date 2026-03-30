"""Then: the document is "INDEXED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the document is "INDEXED"')
def document_is_indexed(world):
    pytest.skip("Cannot observe Lambda document index result in lws")
