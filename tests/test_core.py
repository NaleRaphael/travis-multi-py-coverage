import pytest
from mymodule.utils import get_foo_class


def test_foo():
    from sys import version_info

    foo_cls = get_foo_class()
    foo_instance = foo_cls()

    py_ver = 'py%s%s' % (version_info.major, version_info.minor)
    assert foo_instance.foo() == 'foo in %s' % py_ver
