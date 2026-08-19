# libpath.Ruby - TODO <!-- omit in toc -->


## Functional improvements

* [ ] quiet Ruby 3.4+ `literal string will be frozen in the future` warnings from `gsub!` in **lib/libpath/internal_/windows/form.rb** (tests already pass under `-W`);


## Performance improvements

* \<none>


## Packaging improvements

* [x] ~~~rename gemspec so the filename stem matches `spec.name` (`libpath.gemspec` → **libpath-ruby.gemspec**)~~~;
* [x] ~~~obtain a **run_all_unit_tests.sh** (from **misc-dev-scripts**) that skips `tput` when `$TERM` is unset or stdout is not a TTY (CI: `tput: No value for $TERM and no -T specified`)~~~;
* [x] ~~~**Gemfile** `lockfile false`; stop tracking **Gemfile.lock**; CI `bundler-cache: false`~~~;
* [x] ~~~gemspec polish: README tagline as `spec.summary`, package docs, exclude **Gemfile.lock** / **.ruby-version**~~~;
* [x] ~~~README canonical structure (tagline before badges; **Dependencies**; CI badge → **ruby.yml**)~~~;
* [x] ~~~after the packaging/boilerplate/CI baseline: bump **VERSION** and align **CHANGES**/**NEWS**~~~;
* [ ] **git rm** **Gemfile.lock** when committing this lift (deleted in the work tree and gitignored; still in HEAD);
* [ ] this lift is on **bp-2**, which is not in CI `on.push.branches` (gold seven-name set); use a PR (unfiltered `pull_request:`) or merge to a listed branch to run push CI;


<!-- ########################### end of file ########################### -->
