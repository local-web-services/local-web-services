"""Then: mapping_enters_deleting_state"""

from __future__ import annotations

import pytest
from pytest_bdd import parsers, then


@then(parsers.re(r'^the mapping enters "DELETING" state$'))
def mapping_enters_deleting_state(world):
    pytest.skip("Cannot observe ESM DELETING state in lws")
