
# Base class for all view classes in the system. Does not itself directly render
# content via a `#content` method. Adapted from Fortitude doc at
# https://github.com/ageweke/fortitude/blob/b92df9d/README-erector.md
class Views::Base < Fortitude::Widget
  doctype :html5

  # Enforces HTML spec rules for element nesting (e.g., no <p> inside <span>).
  enforce_element_nesting_rules true
  # Fail if you use an ID attribute already in use on the current page.
  enforce_id_uniqueness true
  # (Per default,) emit properly closed void elements (e.g., <br/>, not <br>).
  close_void_tags true
  # It turns out that I was misunderstanding this; it doesn't affect how `needs`
  # variables get *passed to* a widget, but rather how a widget accesses those.
  # Enable this setting, and a widget can use *either* instance variables copied
  # from the controller (e.g., `@things`) *or* the moral equivalent of
  # `attr_reader` methods (`things`). Disable it, either by setting to `false`,
  # by commenting it out, or by removing the line entirely, and *only* reader
  # methods work.
  use_instance_variables_for_assigns false
end