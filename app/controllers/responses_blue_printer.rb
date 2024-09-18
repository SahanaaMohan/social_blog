class ResponsesBluePrinter < Blueprinter::Base
  identifier :id
  field :body, name: :comment
  association :user, blueprint: UserBluePrinter
end