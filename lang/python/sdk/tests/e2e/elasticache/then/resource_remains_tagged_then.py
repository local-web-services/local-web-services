"""Then: the "elasticache" "resource" remains tagged"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticache" "resource" remains tagged')
def resource_remains_tagged_then():
    pytest.skip("Cannot verify resource tag state in this context")
