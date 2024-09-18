class BlogPostBluePrinter < Blueprinter::Base
  identifier :id
  field :content, name: :post_content
  field :title
  association :user, blueprint: UserBluePrinter
  association :responses, blueprint: ResponsesBluePrinter
end