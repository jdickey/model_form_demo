## `model_form_demo`

Simple demonstration of

1. A model-based form that
2. Uses a form builder, not raw HTML `form` tags, and
3. Fortitude widget-based views, operated from
4. Modern, simple-endpoint controller action methods that use
5. Form objects to wrap the model instance used.

This was done as a simple demo project in November, 2015, as an exploration of combining these technical bits. It was initially expected to take a mere handful of *uninterrupted* hours of work. I expect that the project will yield code that is reusable in other projects without having to go through exploratory coding within the context of those projects.

If you see a bug, or something that could have been done better, please open an issue (and an accompanying PR to demonstrate; unjustified invective will *not* be received positively). Thanks!

### Setup and Docker support

This project included support for running inside a Docker container from the very beginning, with [`Dockerfile`](Dockerfile) and [`docker-compose.yml`](docker-compose.yml) files in the project root. The app uses [Chamber](https://github.com/thekompanee/chamber) for (optionally secure) configuration data, as can be seen in `config/database.yml`; to run inside a Docker container, environment variables to override Chamber configuration must be set (`DB_HOST`, `DB_PORT` and `DB_USERNAME`, which are defaulted to the settings in `config/settings.yml`). (*Note:* Yes, this Really Should go into `docker-compose.ml` rather than specifying `-e` command-line parameters for every command; pull request, anyone?)

Dockerisation is preferred simply because the original maintainer has grown tired of going through a rebuild-the-world fire drill every time Postgres pushes a new release out that gets picked up by `brew update`.

### Code of Conduct and Open Governance

A [code of conduct](CODE_OF_CONDUCT.md) applies to this project; kindly abide by it and contact [the maintainer](https://github.com/jdickey) if you have any questions, comments, or complaints.

The initial maintainer, and any future maintainers, commit to supporting open interaction and discussion of issues and decisions affecting the project community; this will be reflected over time in the project wiki and in issues marked with the tag `community`.

Welcome aboard! If this proves useful to anyone else, kindly [drop a note](https://github.com/jdickey).

## License (New BSD)

Copyright © 2015 Jeff Dickey and Prolog Systems Pte Ltd.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, 

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.