workspace(name = "turtle")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_jar")

# Generate compile_commands.json
http_archive(
    name = "bazel_compdb",
    sha256 = "d51f8168954d4aa0ca984f53a1a6be298d827ff39303d10522dffb2a5c1942dc",
    strip_prefix = "bazel-compilation-database-0.5.0",
    urls = ["https://github.com/grailbio/bazel-compilation-database/archive/0.5.0.tar.gz"],
)

# Rust toolchain
http_archive(
    name = "rules_rust",
    sha256 = "50272c39f20a3a3507cb56dcb5c3b348bda697a7d868708449e2fa6fb893444c",
    urls = ["https://github.com/bazelbuild/rules_rust/releases/download/0.22.0/rules_rust-v0.22.0.tar.gz"],
)
load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")
rules_rust_dependencies()
rust_register_toolchains(
    edition = '2021',
    versions = [
        '1.69.0',
    ],
)

# Python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_python",
    sha256 = "863ba0fa944319f7e3d695711427d9ad80ba92c6edd0b7c7443b84e904689539",
    strip_prefix = "rules_python-0.22.0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.22.0/rules_python-0.22.0.tar.gz",
)

load("@rules_python//python:repositories.bzl", "py_repositories")

py_repositories()

# HDL toolchain
kRulesHdlCommit = "af96df4384cc237608be1ac249db55602080dc88"
http_archive(
    name = "rules_hdl",
    strip_prefix = "bazel_rules_hdl-%s" % kRulesHdlCommit,
    sha256 = "394156ad96d0838c578437bcefa9baa93c94e53790ea126fcfa609c46368604d",
    urls = [
            "https://github.com/hdl/bazel_rules_hdl/archive/%s.tar.gz" % kRulesHdlCommit,
    ],
)
load("@rules_hdl//dependency_support:dependency_support.bzl", rules_hdl_dependency_support = "dependency_support")
rules_hdl_dependency_support()

load("@rules_hdl//:init.bzl", rules_hdl_init = "init")
rules_hdl_init()

