
# Class encapsulating all page-specific view code for `things/index`.
class Views::Things::Index < Views::Base
  def content
    content_for :title, 'Model Form Demo'
    h1 'Welcome#index'
    tag_p 'Find me in app/views/things/index.rb'
  end
end # class Views::Things::Index
