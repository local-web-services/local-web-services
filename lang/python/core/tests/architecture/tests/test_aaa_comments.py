"""Wrapper: delegates to the shared lws_arch_tests implementation with core ratchet."""

from lws_arch_tests.test_aaa_comments import TestAaaComments as _Base


class TestAaaComments(_Base):
    RATCHET = 827
