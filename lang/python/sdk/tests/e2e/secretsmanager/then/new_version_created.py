"""Then: a new "secrets manager" "secret" version will be created and the previous version will be retained"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'a new "secrets manager" "secret" version will be created and the previous version will be retained'
)
def new_version_created(world):
    pytest.skip("Cannot observe rotation result without triggering rotation")
