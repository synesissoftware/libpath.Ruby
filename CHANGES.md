# libpath.Ruby - Changes <!-- omit in toc -->


## 0.2.4 - 27th August 2026

* renamed **libpath.gemspec** to **libpath-ruby.gemspec** so the filename stem matches `spec.name`;
* **libpath-ruby.gemspec**: `required_ruby_version` is the range `>= 2.0`; **Gemfile.lock** and **.ruby-version** excluded from `spec.files`; `spec.summary` matches the README tagline; packaged **AUTHORS**, **CHANGES**, **CONTRIBUTING**, **EXAMPLES**, **FAQ**, **INSTALL**, **NEWS**, **SECURITY**, **TODO**;
* **Gemfile** sets `lockfile false` when Bundler supports it; stop tracking **Gemfile.lock**;
* CI uses `bundler-cache: false` and explicit `bundle install`; **Warnings** job on Ruby **3.4**; `gem build libpath-ruby.gemspec`;
* updated **run_all_unit_tests.sh** (from https://github.com/synesissoftware/misc-dev-scripts) to skip **tput** when **$TERM** is unset or stdout is not a TTY;
* library source **Home:** URLs now use `https`;
* workarounds for avoiding potentially modifying frozen strings;
* **README.md**: tagline before badges; canonical badge row; **Dependencies** (Efferent / Afferent); related projects; License → `./LICENSE`;
* **EXAMPLES.md** example links are repo-relative (`./examples/…`);
* `elide_redundant_path_name_separators!` is freeze-safe (Ruby 3.4 `FrozenError` on a frozen remainder, e.g. malformed UNC);


## 0.2.3 - 15th August 2026

* added `# frozen_string_literal: true` to all **lib/** sources;
* completed **EXAMPLES.md** (EOF marker; table alignment);


## 0.2.2.3 - 13th April 2024

* warnings fixes;


## 0.2.2.2 - 7th April 2024

* merged **tidying** into **master**;


## 0.2.2.1 - 6th April 2024

* project boilerplate;
* canonicalisation of layout;


## 0.2.2 - 18th May 2019

* minor fix to source;


## 0.2.1 - 16th April 2019

* added `#to_s` attribute to Path classes;
* added example **examples/path_from_arg0.rb**;
* significant improvements to documentation;
* added **README.md**;


## 0.2.0.1 - 16th April 2019

* significant improvements to documentation;
* added **.ruby-version-exclusions**;
* gemspec requires Ruby 2.0+;
* updated **run_all_unit_tests.sh** (from **misc-dev-scripts**);


## 0.2.0 - 30th January 2019

* added **Constants**, **Exceptions**, and `Util#name_is_malformed?()`;


## 0.1.1.2 - 30th January 2019

* fixed `ParsedPath` compare-path attributes on Windows;


## 0.1.1.1 - 30th January 2019

* various fixes to path-handling;


## 0.1.0 - 28th January 2019

* added `LibPath::Path(::Unix|::Windows)::ParsedPath`;


## 0.0.20 - 27th January 2019

* Windows compatibility;


## 0.0.19 - 27th January 2019

* further path-handling modifications;


## 0.0.18 - 27th January 2019

* handling redundant path-name separators;


## 0.0.17 - 27th January 2019

* fixed `split_path()` for repeated internal separators;


## 0.0.16 - 27th January 2019

* improved slash correction on Windows (`/` to `\`);


## 0.0.15 - 25th January 2019

* added `LibPath::Util(::Unix|::Windows).derive_relative_path()`;


## 0.0.14 - 25th January 2019

* refactored `classify_path()`;
* renamed `path_is_drived?()` to `path_is_letter_drived?()`;


## 0.0.13 - 25th January 2019

* added `LibPath::Form(::Unix|::Windows).classify_path()`;


## 0.0.12 - 21st January 2019

* fix;


## 0.0.11 - 21st January 2019

* further tidying of Windows Form functions;


## 0.0.10 - 20th January 2019

* improved `get_windows_volume()` for complex cases;


## 0.0.9 - 20th January 2019

* `get_windows_volume()` obtains volume form as third returned element;


## 0.0.8 - 20th January 2019

* added `combine_paths()` and `make_path_absolute()`;
* added `Form::Windows.path_is_drived?()`;


## 0.0.7 - 19th January 2019

* merge;


## 0.0.6 - 17th January 2019

* fix;


## 0.0.5 - 9th January 2019

* added `Util(::Unix|::Windows).make_path_canonical()`;


## 0.0.4 - 9th January 2019

* added `Form.split_path()` for Unix and Windows;


## 0.0.3 - 9th January 2019

* added internal Form API functions;


## 0.0.2 - 8th January 2019

* added Form predicates `path_is_absolute?`, `path_is_homed?`, `path_is_rooted?`, and Windows `path_is_UNC?`;


## 0.0.1 - 8th January 2019

* initial version;


<!-- ########################### end of file ########################### -->
