
class Foo(object):
    def foo(self):
        raise NotImplementedError


class FooPy36(object):
    def foo(self):
        return 'foo in py36'


class FooPy37(object):
    def foo(self):
        return 'foo in py37'
