"""Then: the "elasticsearch" "domain" will be "PROCESSING" and write operations may fail"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticsearch" "domain" will be "PROCESSING" and write operations may fail')
def domain_is_processing_then(world):
    pytest.skip("Cannot observe domain processing state in lws")
