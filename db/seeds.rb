# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#100.times do |i|
 # blog_post = BlogPost.where(title: "Blog Post #{i}").first_or_initialize
#  blog_post.update(content: "Hello world", published_at: Time.current)
#end

10.upto(109) do |i|
  BlogPost.all.update(content: "A Hello, World program is generally a simple computer program which emits to the screen a message similar to Hello, World while ignoring any user input. A small piece of code in most general-purpose programming languages, this program is used to illustrate a language's basic syntax.")
end