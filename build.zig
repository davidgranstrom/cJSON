const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const version = .{ .major = 1, .minor = 7, .patch = 16 };
    const cflags = [_][]const u8{
        "-std=c89",
        "-pedantic",
        "-Wall",
        "-Wextra",
        "-Werror",
        "-Wstrict-prototypes",
        "-Wwrite-strings",
        "-Wshadow",
        "-Winit-self",
        "-Wcast-align",
        "-Wformat=2",
        "-Wmissing-prototypes",
        "-Wstrict-overflow=2",
        "-Wcast-qual",
        "-Wundef",
        "-Wswitch-default",
        "-Wconversion",
        "-Wc++-compat",
        "-fstack-protector-strong",
        "-Wcomma",
        "-Wdouble-promotion",
        "-Wparentheses",
        // "-Wformat-overflow", clang did not like this
        "-Wunused-macros",
        "-Wmissing-variable-declarations",
        "-Wused-but-marked-unused",
        "-Wswitch-enum",
    };

    const cjson_static = b.addStaticLibrary(.{
        .name = "cjson-static",
        .version = version,
        .target = target,
        .optimize = optimize,
    });
    cjson_static.addCSourceFiles(&source_files, &cflags);
    cjson_static.linkLibC();
    b.installArtifact(cjson_static);

    const cjson_shared = b.addSharedLibrary(.{
        .name = "cjson",
        .version = version,
        .target = target,
        .optimize = optimize,
    });
    cjson_shared.addCSourceFiles(&source_files, &cflags);
    cjson_shared.linkLibC();
    b.installArtifact(cjson_shared);
}

const source_files = [_][]const u8{
    "cJSON.c",
    "cJSON_Utils.c",
};
