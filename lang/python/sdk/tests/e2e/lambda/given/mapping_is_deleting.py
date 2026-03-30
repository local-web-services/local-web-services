"""Given: mapping_is_deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers


@given(parsers.re(r'^the mapping is "DELETING"$'))
def mapping_is_deleting():
    pytest.skip("Cannot observe ESM DELETING state in lws")
