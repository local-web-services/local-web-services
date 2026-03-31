"""Then: the "step functions" "execution" will be "FAILED" with a ResourceNotFoundException"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "step functions" "execution" will be "FAILED" with a ResourceNotFoundException')
def execution_failed_resource_not_found():
    pytest.skip("Cannot observe internal execution Glacier task failure in lws")
