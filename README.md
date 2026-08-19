# libpath.Ruby <!-- omit in toc -->

Path parsing library, for Ruby

![Language](https://img.shields.io/badge/Ruby-CC342D?style=flat&logo=ruby&logoColor=white)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Gem Version](https://badge.fury.io/rb/libpath-ruby.svg)](https://badge.fury.io/rb/libpath-ruby)
[![Last Commit](https://img.shields.io/github/last-commit/synesissoftware/libpath.Ruby)](https://github.com/synesissoftware/libpath.Ruby/commits/master)
[![Ruby](https://github.com/synesissoftware/libpath.Ruby/actions/workflows/ruby.yml/badge.svg)](https://github.com/synesissoftware/libpath.Ruby/actions/workflows/ruby.yml)


## Table of Contents <!-- omit in toc -->

- [Introduction](#introduction)
- [Installation](#installation)
- [Components](#components)
- [Examples](#examples)
- [Project Information](#project-information)
  - [Where to get help](#where-to-get-help)
  - [Contribution guidelines](#contribution-guidelines)
  - [Dependencies](#dependencies)
    - [Efferent (fan-out)](#efferent-fan-out)
      - [Runtime Dependencies (aka "Normal Dependencies")](#runtime-dependencies-aka-normal-dependencies)
      - [Development Dependencies](#development-dependencies)
    - [Afferent (fan-in)](#afferent-fan-in)
      - [Runtime dependents](#runtime-dependents)
      - [Development dependents](#development-dependents)
  - [Related projects](#related-projects)
  - [License](#license)


## Introduction

**libpath** is a path-parsing and utility library. It is concerned entirely with paths, as opposed to file-system entities.

The first **libpath** library was a C library with a C++ wrapper. There have been several implementations in other languages. **libpath.Ruby** is the Ruby version.


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


### Dependencies


#### Efferent (fan-out)

Libraries upon which **libpath.Ruby** depends:


##### Runtime Dependencies (aka "Normal Dependencies")

* \<none>;


##### Development Dependencies

* [**rake**](https://rubygems.org/gems/rake);
* [**test-unit**](https://rubygems.org/gems/test-unit);
* [**xqsr3**](https://github.com/synesissoftware/xqsr3);


#### Afferent (fan-in)

Projects that depend on **libpath.Ruby**:


##### Runtime dependents

* \<none>;

> **NOTE**: **[recls.Ruby](https://github.com/synesissoftware/recls.Ruby)** version 3+ is planned to depend on **libpath.Ruby** (it currently has its own path-parsing logic).


##### Development dependents

* \<none>;


### Related projects

* [**libpath**](https://github.com/synesissoftware/libpath) (**C**/**C++**);
* [**libpath.Go**](https://github.com/synesissoftware/libpath.Go);
* [**libpath.Python**](https://github.com/synesissoftware/libpath.Python);
* [**libpath.Rust**](https://github.com/synesissoftware/libpath.Rust);

**libpath.Ruby** is based on the C/C++ **libpath** library, which itself was prompted by a request on the [STLSoft](https://github.com/synesissoftware/STLSoft-1.10) project by my friend and esteemed programmer [Adi Shavit](https://github.com/adishavit).


### License

**libpath.Ruby** is released under the 3-clause BSD license. See [LICENSE](./LICENSE) for details.


<!-- ########################### end of file ########################### -->
