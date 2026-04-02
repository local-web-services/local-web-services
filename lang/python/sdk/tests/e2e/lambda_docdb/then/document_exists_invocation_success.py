"""Then: the "documentdb" "document" will exist and the "lambda" "invocation" will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "documentdb" "document" will exist and the "lambda" "invocation" will be "SUCCESS"')
def document_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda document write result in lws")
