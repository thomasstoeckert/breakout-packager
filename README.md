# Breakout Packager
This is a simple command-line application to take a collection of ".bol" files outputted from my Breakout Editor and package them into a ready-to-compile ".h" file for my MSP430 Breakout clone.

The application is configured through the use of a ".toml" configuration file, with two properties: `output_file` and `input_files`. `output_file` is a string, the file path of the desired ".h" file. `input_files` is an array of strings, each pointing to a single `.bol` file.

The application, by default, will look for a `levels.toml` in its local directory for this configuration information. This can be overwritten, however, by passing in the file path of a custom `.toml` configuration file as the first argument of the program.

---

This probably doesn't have much (if any) use to anyone else. But it's important to document these things, and it's also important to share.