"""Given: function_is_deleted_given"""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers


@given(parsers.re(r'^the function is "DELETED"$'))
def function_is_deleted_given():
    pytest.skip("Cannot observe Lambda DELETED state without triggering delete lifecycle")
