# encoding: utf-8

from collections import namedtuple
from textwrap import dedent

import pytest


@pytest.fixture
def get_value_from_CMakeCache():
    from generateAppliDoc import get_value_from_CMakeCache as fct
    return fct


class Test_get_value_from_CMakeCache:
    def test_file_does_not_exist(self, get_value_from_CMakeCache):
        filename = "does_not_exist_file"
        key = "OTB_APPLICATIONS_NAME_LIST"
        with pytest.raises(IOError):
            get_value_from_CMakeCache(filename, key)

    def test_no_key_corresponding(self, get_value_from_CMakeCache, tmpdir):
        cmakefile = tmpdir.mkdir("sub").join("CMakeCache.txt")
        cmakefile.write('nothing')
        filename = str(cmakefile)
        key = "OTB_APPLICATIONS_NAME_LIST"
        with pytest.raises(KeyError):
            get_value_from_CMakeCache(filename, key)

    def test_key_corresponding(self, get_value_from_CMakeCache, tmpdir):
        key = "OTB_APPLICATIONS_NAME_LIST"
        input_value = ('MultivariateAlterationDetector;'
                       'ComputeOGRLayersFeaturesStatistics')

        cmakefile = tmpdir.mkdir("sub").join("CMakeCache.txt")
        filecontent = dedent("""
                             //comment
                             {}:STRING={}
                             //comment
                             """.format(key, input_value))
        cmakefile.write(filecontent)
        filename = str(cmakefile)
        value = get_value_from_CMakeCache(filename, key)
        assert value == input_value


class Test_get_applications_from_CMakeCache:
    def common(self, monkeypatch, input_applications):
        from generateAppliDoc import get_applications_from_CMakeCache
        monkeypatch.setattr("generateAppliDoc.get_value_from_CMakeCache",
                            lambda filename, key: ";".join(input_applications))

        applications = get_applications_from_CMakeCache("CMakeCache.txt")
        return applications

    def test_TestApplication_not_in_list(self, monkeypatch):
        input_applications = ['a', 'b', 'c']
        applications = self.common(monkeypatch, input_applications)
        assert applications == input_applications

    def test_TestApplication_removed(self, monkeypatch):
        input_applications = ['a', 'b', 'c', "TestApplication"]
        applications = self.common(monkeypatch, input_applications)
        assert "TestApplication" not in applications


@pytest.fixture(params=['no_test_dir', 'test_dir', 'otb_prefix', 'extra_apps'])
# `no_test_dir` : `Apptest` directory does not exist. `App` prefix to group are
#                 ignored.
# `test_dir`    : `Apptest` directory is present in the application directory
#                  and should be ignored for the source file listing.
# `otb_prefix`  : source file is prefixed by `otb` or ignored
# `extra_apps`  : source files whose name is not in the list of applications
#                 should be ignored.
def sources_tree(tmpdir, request):
    apps_dir = tmpdir.ensure_dir('Modules', 'Applications')

    groups = {'Edge': ('CMakeLists.txt', 'otbEdgeExtraction.cxx',),
              'Others': ('CMakeLists.txt', 'otbOther.cxx'),
              'ImageUtils': ('otbCompareImages.cxx', 'otbSplitImage.cxx',
                             'CMakeLists.txt'),
              }

    if request.param == 'test_dir':
        apps_dir.ensure('AppTest', 'app', 'otbMyTest.cxx')
    elif request.param == 'otb_prefix':
        groups['Others'] += ('notprefixed.cxx',)
    elif request.param == 'extra_apps':
        groups['Edge'] += ('otbLineSegmentDetection.cxx',)

    for group, apps in groups.iteritems():
        group_dir = apps_dir.mkdir("App{}".format(group))
        group_dir.ensure('CMakeLists.txt')
        group_dir.ensure('otb-module.cmake')
        group_dir.ensure('test', 'CMakeLists.txt')
        group_dir.ensure('test', 'dummy.cxx')
        for app in apps:
            group_dir.ensure('app', app)

    return tmpdir


@pytest.fixture
def fx_apps(monkeypatch):
    apps = ['SplitImage', 'EdgeExtraction', 'CompareImages', 'Other']
    monkeypatch.setattr("generateAppliDoc.get_applications_from_CMakeCache",
                        lambda filename: apps)
    return apps


def test_associate_group_to_applications(sources_tree, fx_apps):
    from generateAppliDoc import associate_group_to_applications
    output = associate_group_to_applications(sources_tree.strpath, fx_apps)
    AppProp = namedtuple('AppProp', ['name', 'group'])
    expected = [AppProp('SplitImage', 'ImageUtils'),
                AppProp('CompareImages', 'ImageUtils'),
                AppProp('EdgeExtraction', 'Edge'),
                AppProp('Other', 'Others'),
                ]

    assert sorted(output) == sorted(expected)