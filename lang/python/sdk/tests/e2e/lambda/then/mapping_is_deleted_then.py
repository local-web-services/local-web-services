"""Then: mapping_is_deleted_then"""

from __future__ import annotations

import pytest
from pytest_bdd import parsers, then


@then(parsers.re(r'^the mapping is "DELETED"$'))
def mapping_is_deleted_then(world):
    pytest.skip("Cannot observe ESM DELETED state in lws")
