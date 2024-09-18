class UserBluePrinter < Blueprinter::Base
  identifier :id
  field :email, name: :login
  field :username, name: :author
end