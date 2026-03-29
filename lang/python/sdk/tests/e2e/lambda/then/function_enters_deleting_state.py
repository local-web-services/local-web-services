"""Then: function_enters_deleting_state"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r'^the function enters "DELETING" state$'))
def function_enters_deleting_state(world):
    assert world["error"] is None, f"Expected delete_function to succeed but got: {world['error']}"
