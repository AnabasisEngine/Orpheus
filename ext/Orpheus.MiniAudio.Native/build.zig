const std = @import("std");
const fs = std.fs;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});

    const shared_lib_options: std.build.SharedLibraryOptions = .{
        .name = "miniaudio",
        .target = target,
        .optimize = mode,
    };

    const lib: *std.build.LibExeObjStep = b.addSharedLibrary(shared_lib_options);
    lib.linkLibC();
    lib.defineCMacroRaw("MA_DLL");

    lib.addCSourceFiles(&.{"miniaudio.c"}, &.{ "-std=c99", "-fPIC" });
    b.installArtifact(lib);
}