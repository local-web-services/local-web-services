"""Given: a document slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("a document slot is available")
def document_slot_available():
    """No-op: always room for documents."""
