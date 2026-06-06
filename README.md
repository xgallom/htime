# htime

A minimal command timer. Runs any program and prints how long it took.

## Usage

```sh
htime <command> [args...]
```

```sh
htime zig build
# Process took 1.234s

htime ffmpeg -i input.mp4 output.webm
# Process took 42.1s
```

The exit code of the wrapped command is preserved — `htime` exits with the same code.

## Installation

### Prebuilt binaries

Download from the [releases page](https://github.com/xgallom/htime/releases).

### Build from source

Requires [Zig 0.15.2](https://ziglang.org/download/).

```sh
git clone https://github.com/xgallom/htime
cd htime
zig build --release=fast
```

Binary is at `zig-out/bin/htime`.

## License

[MIT](LICENSE.md)
