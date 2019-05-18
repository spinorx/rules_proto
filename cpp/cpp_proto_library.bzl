load("//cpp:cpp_proto_compile.bzl", "cpp_proto_compile")

def cpp_proto_library(**kwargs):
    name = kwargs.pop("name")
    deps = kwargs.pop("deps")
    visibility = kwargs.pop("visibility", None)

    name_pb = name + "_pb"
    cpp_proto_compile(
        name = name_pb,
        deps = deps,
        visibility = visibility,
        verbose = kwargs.pop("verbose", 0),
        transitivity = kwargs.pop("transitivity", {}),
        transitive = kwargs.pop("transitive", True),
    )

    native.cc_library(
        name = name,
        srcs = [name_pb],
        deps = [
            "//external:protobuf_clib",
        ],
        includes = [name_pb],
        visibility = visibility,
        **kwargs
    )
