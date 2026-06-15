# Copyright 2023 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""visionos_framework Starlark tests."""

load(
    "//test/starlark_tests/rules:analysis_target_outputs_test.bzl",
    "analysis_target_tree_artifacts_outputs_test",
)
load(
    "//test/starlark_tests/rules:infoplist_contents_test.bzl",
    "infoplist_contents_test",
)

def visionos_framework_test_suite(name):
    """Test suite for visionos_framework.

    Args:
      name: the base name to be used in things created by this macro
    """

    # Test that visionos_framework works without explicit infoplists
    analysis_target_tree_artifacts_outputs_test(
        name = "{}_no_infoplist_builds_test".format(name),
        target_under_test = "//test/starlark_tests/targets_under_test/visionos:fmwk_minimal_no_infoplist",
        expected_outputs = ["fmwk_minimal_no_infoplist.framework"],
        tags = [name],
    )

    infoplist_contents_test(
        name = "{}_no_infoplist_has_default_values_test".format(name),
        target_under_test = "//test/starlark_tests/targets_under_test/visionos:fmwk_minimal_no_infoplist",
        expected_values = {
            "CFBundleIdentifier": "com.google.example.framework",
            "CFBundleName": "fmwk_minimal_no_infoplist",
            "CFBundlePackageType": "FMWK",
        },
        tags = [name],
    )

    native.test_suite(
        name = name,
        tags = [name],
    )
