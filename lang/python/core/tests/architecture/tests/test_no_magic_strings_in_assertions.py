"""Wrapper: delegates to the shared lws_arch_tests implementation with core ratchet."""

from lws_arch_tests.test_no_magic_strings_in_assertions import (
    TestNoMagicStringsInAssertions as _Base,
)


class TestNoMagicStringsInAssertions(_Base):
    RATCHET = 81
