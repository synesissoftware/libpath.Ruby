# libpath.Ruby <!-- omit in toc -->

**libpath**, for Ruby

[![Gem Version](https://badge.fury.io/rb/libpath-ruby.svg)](https://badge.fury.io/rb/libpath-ruby)
[![Ruby](https://github.com/synesissoftware/libpath.Ruby/actions/workflows/ruby.yml/badge.svg)](https://github.com/synesissoftware/libpath.Ruby/actions/workflows/ruby.yml)


## Table of Contents <!-- omit in toc -->

- [Introduction](#introduction)
- [Installation](#installation)
- [Components](#components)
- [Examples](#examples)
- [Project Information](#project-information)
  - [Where to get help](#where-to-get-help)
  - [Contribution guidelines](#contribution-guidelines)
  - [Related projects](#related-projects)
  - [License](#license)


## Introduction

**libpath** is a path-parsing and utility library. It is concerned entirely with paths, as opposed to file-system entities.


## Installation

Install via **gem** as in:

```
gem install libpath-ruby
```

or add it to your `Gemfile`.

Use via **require**, as in:

```Ruby
require 'libpath'
```

## Components

The main components of **libpath.Ruby** are:

* **`LibPath::Form`** — path-form classification and probes (`classify_path`, `path_is_absolute?`, `path_is_homed?`, `path_is_rooted?`, `name_is_malformed?`);
* **`LibPath::Path::ParsedPath`** — structured parse of a path string into directory / file / search-relative attributes (platform-selected Unix or Windows implementation);
* **`LibPath::Util`** — path combination and rewriting (`combine_paths`, `derive_relative_path`, `make_compare_path`, `make_path_absolute`, `make_path_canonical`);
* **`LibPath::Constants`** — platform path-name / path / shell character constants;
* **`LibPath::Exceptions`** — path-related exceptions such as `MalformedNameException`;

Platform-specific details live under `::Unix` / `::Windows` submodules; the top-level `Form`, `Path`, and `Util` modules select the ambient OS automatically.


## Examples

Examples are provided in the ```examples``` directory, along with a markdown description for each. A detailed list TOC of them is provided in [EXAMPLES.md](./EXAMPLES.md).


## Project Information


### Where to get help

[GitHub Page](https://github.com/synesissoftware/libpath.Ruby "GitHub Page")


### Contribution guidelines

Defect reports, feature requests, and pull requests are welcome on https://github.com/synesissoftware/libpath.Ruby.


### Related projects

**libpath.Ruby** is based on the [C/C++ libpath library](https://github.com/synesissoftware/libpath), which itself was prompted by a request on the [STLSoft](https://github.com/synesissoftware/STLSoft-1.10) project by my friend and esteemed programmer [Adi Shavit](https://github.com/adishavit).

**libpath.Ruby** will be used in **version 3+** of the **[recls.Ruby](https://github.com/synesissoftware/recls.Ruby)** library, which currently has its own path-parsing logic.


### License

**libpath.Ruby** is released under the 3-clause BSD license. See LICENSE for details.


<!-- ########################### end of file ########################### -->

