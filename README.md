## `model_form_demo`

[![Code Climate](https://codeclimate.com/github/jdickey/model_form_demo/badges/gpa.svg)](https://codeclimate.com/github/jdickey/model_form_demo)
[ ![Codeship Status for jdickey/model_form_demo](https://codeship.com/projects/25ac3b60-7bda-0133-3687-5e23d6b78f76/status)](https://codeship.com/projects/119736)
[![Coverage Status](https://coveralls.io/repos/jdickey/model_form_demo/badge.svg?branch=master&service=github)](https://coveralls.io/github/jdickey/model_form_demo?branch=master)

Simple demonstration of

1. A model-based form that
2. Uses a form builder, not raw HTML `form` tags, and
3. Fortitude widget-based views, operated from
4. Modern, simple-endpoint controller action methods that use
5. Form objects to wrap the model instance used.

This was done as a simple demo project in November, 2015, as an exploration of combining these technical bits. I expect that the project will yield code that is reusable in other projects without having to repeat exploratory coding within the context of those projects.

If you see a bug, or something that could have been done better, please open an issue (and an accompanying PR to demonstrate; unjustified invective will *not* be received positively). Thanks!

### Setup and Docker support

This project included support for running inside a Docker container from the very beginning, with [`Dockerfile`](Dockerfile) and [`docker-compose.yml`](docker-compose.yml) files in the project root. The app uses [Chamber](https://github.com/thekompanee/chamber) for (optionally secure) configuration data, as can be seen in `config/database.yml`; to run inside a Docker container, environment variables to override Chamber configuration must be set (`DB_HOST`, `DB_PORT` and `DB_USERNAME`, which are defaulted to the settings in `config/settings.yml`). (*Note:* Yes, this Really Should go into `docker-compose.ml` rather than specifying `-e` command-line parameters for every command; pull request, anyone?)

Dockerisation is preferred simply because the original maintainer has grown tired of going through a rebuild-the-world fire drill every time Postgres pushes a new release out that gets picked up by `brew update`.

### Design is a Good Thing™, Framework Be Damned

​The whole *point* of [Fortitude](https://github.com/ageweke/fortitude) is, as its `README` says, "Views As Code". This implies, *inter alia*, being able to *test* them just as you can with any other Ruby class. And you *can*, right on up to and occasionally including the point where they touch Rails. And while [Fortitude Issue 34](https://github.com/ageweke/fortitude/issues/34) was opened and closed in some four days, we didn't even open it until we'd flailed around for more than three days trying to understand what was breaking, and why. Over the course of those four days, [Andrew Geweke](https://github.com/ageweke), the maintainer of Fortitude, gave a concise [master class](https://github.com/ageweke/fortitude/issues/34#issuecomment-160342506) in How Rails Works with Views (In Spite of Itself). Many, *many* writers have bemoaned Rails abhorrence of clean, SOLID design practices in its relentless pursuit of the fastest-path-to-clone-2005-Basecamp goal; anything that touches the combination of view-related code and "helper" "methods" is a clear example. Rails assumes that views (and especially helpers) will *always* exist simultaneously and in association with a controller, which will be set up with nearly inscrutably complex dependent state. (Read the issue, and especially the "master-class" comment, for explanation). The upshot of this appears to be that, except in *very* limited circumstances (where a mocked context will provide enough data for your widget to work), you're stuck with testing Fortitude views in the same way you tested dumb-string-interpolation views using ERb, [Haml](http://haml.info/), [Slim](http://slim-lang.com/), or Jim-Bob's Amazing Template Language: forget about testing views *per se*; test that controllers render the views you expect and have integration tests ("feature specs", if you're coming from RSpec/Capybara), that test how your views look, not just how they work. :anguished: 

This answers one of the main points of enquiry that led us to embark upon this exploration as a focused subset of an earlier, larger-scoped one. "Views As Code" can be taken only so far, through no fault of Fortitude's; classically-experienced object-oriented developers new to Rails are *strongly implored* to explore one of the numerous more modern Ruby Web-development frameworks that have been developed in the last few years (generally post-2010); what you sacrifice in terms of industrial community may well be adequately compensated for by shipping code on schedule that you can actually bear to look at in a year's time. `</rant>`

### Code of Conduct and Open Governance

A [code of conduct](CODE_OF_CONDUCT.md) applies to this project; kindly abide by it and contact [the maintainer](https://github.com/jdickey) if you have any questions, comments, or complaints.

The initial maintainer, and any future maintainers, commit to supporting open interaction and discussion of issues and decisions affecting the project community; this will be reflected over time in the project wiki and in issues marked with the tag `community`.

Welcome aboard! If this proves useful to anyone else, kindly [drop a note](https://github.com/jdickey).

## License (New BSD)

Copyright © 2015 Jeff Dickey and Prolog Systems Pte Ltd.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, 

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.