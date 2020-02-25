
def get_foo_class():
    from sys import version_info
    from . import core

    ver = 'FooPy%s%s' % (version_info.major, version_info.minor)
    return getattr(core, ver)
