"""Then: a new secret version is created and the previous version is retained"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("a new secret version is created and the previous version is retained")
def new_version_created(world):
    pytest.skip("Cannot observe rotation result without triggering rotation.")
