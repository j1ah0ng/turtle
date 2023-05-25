workspace(name = "turtle")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_jar")

http_archive(
    name = "bazel_compdb",
    sha256 = "d51f8168954d4aa0ca984f53a1a6be298d827ff39303d10522dffb2a5c1942dc",
    strip_prefix = "bazel-compilation-database-0.5.0",
    urls = ["https://github.com/grailbio/bazel-compilation-database/archive/0.5.0.tar.gz"],
)

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
