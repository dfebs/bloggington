require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  test "does not get created when fields are missing" do
    blog_post = BlogPost.new
    assert_not blog_post.save, "Created blog post with missing fields"
  end

  test "should report error" do
    assert_raises(NameError) do
      some_undefined_variable
    end
  end
end
