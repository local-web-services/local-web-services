"""Wrapper: delegates to the shared lws_arch_tests implementation."""

from lws_arch_tests.test_file_length import TestFileLength as _Base


class TestFileLength(_Base):
    pass
