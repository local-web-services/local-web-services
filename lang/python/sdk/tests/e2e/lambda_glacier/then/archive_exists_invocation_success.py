"""Then: the archive "EXISTS" in the vault and the invocation is "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the archive "EXISTS" in the vault and the invocation is "SUCCESS"')
def archive_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda archive upload result in lws")
