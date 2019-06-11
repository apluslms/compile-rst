A docker container that can compile RST document hierarchies using Sphinx.

The container includes [a-plus-rst-tools](https://github.com/Aalto-LeTech/a-plus-rst-tools) in `/opt/a-plus-rst-tools`, which is included in `PYTHONPATH` when using `a-plus-rst-build`.

The container can be used with [roman](https://github.com/apluslms/roman) by adding following in the `roman.yml`:

```yaml
steps:
  - img: apluslms/compile-rst
    mnt: /compile
    env:
      STATIC_CONTENT_HOST: "http://localhost:8080/static/default"
```

Alternatively, the container can be used directly with command `docker run -v .:/compile apluslms/compile-rst`.


# Commands provided by the container

* `a-plus-rst-auto-build` (default)

    Detects if the source looks like a course material.
    It is so if:

    * There is no `build.sh`
    * There is no `Makefile`
    * There is `conf.py`
    * `conf.py` contains lines starting with `course_open_date` and `course_close_date`

    If the source matches, then `a-plus-rst-build` is executed with `--clean` flag.
    Otherwise, `mooc-grader-build` is executed.

* `a-plus-rst-build [-C|--clean|clean] [-c|--use-cache] [--touchrst|touchrst]`

    Appends `a-plus-rst-tools` in `PYTHONPATH` and then executes `sphinx-build`.

    If `--clean` is set, then `-E` is passed to `sphinx-build` ([sphinx doc](https://www.sphinx-doc.org/en/master/man/sphinx-build.html#cmdoption-sphinx-build-e)).

    If `--use-cache` is set, then `--clean` is unset.

    If `--touchrst` is set, then `find . -name "*.rst" -exec touch {} \;` is executed before Sphinx.


* `mooc-grader-build [html] [touchrst]`

    Support for the build process used in [MOOC-Grader](https://github.com/Aalto-LeTech/mooc-grader)`/gitmanager`.

    There are two options.
    First, if `build.sh` exists, it's executed using `/bin/bash`.
    Second, if `Makefile` exists with `SPHINXBUILD` and `html:` in it, then `make` is executed.

    In `Makefile` case, the script automatically adds `html` to the `make` command.
    In addition, if there is `touchrst:` in the `Makefile`, then `touchrst` is added as the first action for `make`.
