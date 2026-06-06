const std = @import("std");
const log = std.log.scoped(.default);

pub fn main() !u8 {
    const stdout_f = std.fs.File.stdout();
    var stdout_buf: [256]u8 = undefined;
    var stdout_w = stdout_f.writer(&stdout_buf);
    const stdout = &stdout_w.interface;
    defer stdout.flush() catch unreachable;
    var gpa_allocator = std.heap.DebugAllocator(.{}).init;
    defer _ = gpa_allocator.deinit();
    const gpa = gpa_allocator.allocator();
    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);
    if (args.len > 1) {
        var child = std.process.Child.init(args[1..], std.heap.c_allocator);
        const start = std.time.nanoTimestamp();
        const result = try child.spawnAndWait();
        const end = std.time.nanoTimestamp();
        try stdout.print("Process took {D}\n", .{@as(u64, @intCast(end - start))});
        try stdout.flush();
        switch (result) {
            .Exited => |code| return code,
            else => |tag| {
                log.err("Received {}", .{tag});
                return 0;
            },
        }
    } else {
        log.err("Missing program arguments", .{});
        return 0;
    }
}
